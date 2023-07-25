import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataNotifier extends ChangeNotifier {
  String _response = '';

  String get getResponse => _response;

  Future<void> getBallResponse() async {
    try {
      var response = await http.get(Uri.parse("https://eightballapi.com/apis"));
      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body);
        _response = result['reading'];
        print(_response);
        notifyListeners();
      } else {
        throw new Exception("error");
      }
    } catch (e) {
      _response = 'error';
      print(_response);
      notifyListeners();
    }
  }
}
