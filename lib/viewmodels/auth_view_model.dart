/*
 * Copyright 2020 Cagatay Ulusoy (Ulus Oy Apps). All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import 'dart:convert';
import 'dart:io';

import 'package:authwallapp/data/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:authwallapp/MODELS/user.dart';


class AuthViewModel extends ChangeNotifier {
  final AuthRepository? authRepository;
  bool logingIn = false;
  bool logingOut = false;
  

  AuthViewModel(this.authRepository);

  Future<bool> login ({
  required final String email,
  required final String password,}) async {
    logingIn = true;
    print(email);
    print(password);
    const url='http://192.168.1.17:8000/login';
    var response = await http.post(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode != HttpStatus.ok) {
      print('Response: ${response.statusCode}');
      return false;
    }
    final json = jsonDecode(response.body);
    final user = MyUser.fromJson(json);
    final result = await authRepository!.login();
    notifyListeners();
    logingIn = false;
    return result;
  }

  Future<bool> logout() async {
    logingOut = true;
    notifyListeners();
    final logoutResult = await authRepository!.logout();
    logingOut = false;
    notifyListeners();
    return logoutResult;
  }
}
