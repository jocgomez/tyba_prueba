import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tyba_prueba/model/restaurant.dart';

class ApiRequest {
  static Future<List<Restaurant>> getRestaurants(
      {@required double lat, @required double lon}) async {
    final http.Response response = await http.get(
        'https://travel-advisor.p.rapidapi.com/restaurants/list-by-latlng?latitude=${lat.toString()}&longitude=${lon.toString()}&limit=30&currency=COP&distance=2&open_now=false&lunit=km&lang=es_ES',
        headers: <String, String>{
          "x-rapidapi-key": "acfd9c9ca6msh565c6d75f0668c5p137fa8jsn3a12f28cdc3a",
          "x-rapidapi-host": "travel-advisor.p.rapidapi.com",
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<Restaurant> listRestaurant = [];
      data["data"].forEach((value) {
        listRestaurant.add(Restaurant.fromJson(value));
      });
      return listRestaurant;
    } else {
      throw Exception('Error al consultar los restaurantes');
    }
  }
}
