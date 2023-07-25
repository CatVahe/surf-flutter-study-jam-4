import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataNotifier extends ChangeNotifier {
  String _response = '';
  String _orientation = 'LANDSCAPE';

  String get getResponse => _response;

  Future<void> getBallResponse() async {
    try {
      var response = await http.get(Uri.parse("https://eightballapi.com/api"));
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

  String getOrientation({required double width, required double height}) {
    if (width >= height) {
      return 'LANDSCAPE';
    } else {
      return 'PORTRAIT';
    }
  }
}
