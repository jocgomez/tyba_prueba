import 'package:flutter/material.dart';
import 'package:tyba_prueba/controller/api_restaurant.dart';
import 'package:tyba_prueba/model/restaurant.dart';
import 'package:tyba_prueba/view/components/appbar_Component.dart';
import 'package:tyba_prueba/view/utils/style.dart';
import 'package:google_place/google_place.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _passController = TextEditingController();
  GooglePlace _googlePlace;
  List<SearchResult> _listResults = [];
  double _latitude = 0;
  double _longitude = 0;
  bool _searching = false;

  @override
  void dispose() {
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarComponent(),
      body: Container(
        color: StylesElements.colorGreyBG,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            inputSearchRestaurants(),
            Container(
              constraints: BoxConstraints(maxHeight: 100, minHeight: 0),
              child: ListView.builder(
                itemCount: _listResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        _latitude = _listResults[index].geometry.location.lat;
                        _longitude = _listResults[index].geometry.location.lng;
                        _searching = true;
                      });
                    },
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(_listResults[index].formattedAddress),
                  );
                },
              ),
            ),
            _searching
                ? Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 16),
                    child: Text(
                      "Lista de restaurantes:",
                      style: StylesElements.tsBoldSecondary18,
                    ),
                  )
                : SizedBox(),
            _searching
                ? Expanded(
                    child: FutureBuilder(
                      future: ApiRequest.getRestaurants(lat: _latitude ?? 0, lon: _longitude ?? 0),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(StylesElements.colorPrimary),
                          ));
                        }
                        if (snapshot.hasData) {
                          List<Restaurant> _listRestaurants = snapshot.data;
                          return ListView.builder(
                            itemCount: _listRestaurants.length,
                            itemBuilder: (context, index) {
                              Restaurant restaurant = _listRestaurants[index];
                              return Card(
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        restaurant.name ?? 'Restaurante sin nombre...',
                                        style: StylesElements.tsBoldSecondary,
                                      ),
                                      Text(restaurant.address ?? ''),
                                      SizedBox(height: 10),
                                      Text(restaurant.ranking ?? ''),
                                      SizedBox(height: 10),
                                      Text(restaurant.description ?? ''),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                "No se encontró ningun restaurante, ¡prueba con otra ciudad!",
                                style: StylesElements.tsNormalSecondary,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget inputSearchRestaurants() {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 16, bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
                onChanged: (value) {
                  _googlePlace.search.getTextSearch(value).then((result) {
                    print(result);
                    if (result != null) {
                      if (result.status != 'OK') {
                        setState(() {
                          _listResults = result.results;
                          print(_listResults);
                        });
                      }
                    }
                  });
                },
                onSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                },
                controller: _passController,
                decoration:
                    StylesElements.textFieldDecoration("Restaurantes en...", false, null, () {})),
          ),
          IconButton(
            onPressed: () {
              /* setState(() {
                _latitude = 3.4255965;
                _longitude = -76.529725;
                _searching = true;
              }); */
              Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium)
                  .then((position) {
                setState(() {
                  _latitude = position.latitude;
                  _longitude = position.longitude;
                  _searching = true;
                });
              }).catchError((e) {
                print(e);
              });
              FocusScope.of(context).unfocus();
            },
            icon: Icon(Icons.pin_drop),
          )
        ],
      ),
    );
  }
}
