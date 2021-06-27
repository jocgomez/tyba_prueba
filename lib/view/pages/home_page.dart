import 'package:flutter/material.dart';
import 'package:tyba_prueba/controller/api_restaurant.dart';
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

  @override
  void dispose() {
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarComponent(),
      body: SingleChildScrollView(
        child: Container(
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
                      onTap: () {},
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      title: Text(_listResults[index].formattedAddress),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16),
                child: Text(
                  "Lista de restaurantes:",
                  style: StylesElements.tsBoldSecondary18,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Card(
                    child: Text("1"),
                  );
                },
              )
            ],
          ),
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
              Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium)
                  .then((position) {
                ApiRequest.getRestaurants(lat: position.latitude, lon: position.longitude)
                    .then((value) {
                  print(value);
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
