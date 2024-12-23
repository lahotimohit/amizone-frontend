import 'package:amizone_frontend/dashboard/screens/home.dart';
import 'package:amizone_frontend/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:amizone_frontend/api/endpoints.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void onLogin(String username, String password, BuildContext context) async {
  var loginUri = Uri.parse(loginURL);
  var response = await http
      .post(loginUri, body: {"enrollment": username, "password": password});
  Navigator.of(context).pop();
  if (response.statusCode == 200) {
    SecureStorage storage = SecureStorage();
    storage.writeSecureData("enrollment", username);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const AmizoneDashboard()));
  } else {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final String message = responseData["message"];
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
