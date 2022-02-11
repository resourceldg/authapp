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
import 'package:common/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:authwallapp/viewmodels/auth_view_model.dart';
import 'package:authwallapp/viewmodels/colors_view_model.dart';
import 'package:provider/provider.dart';

class LogoutFab extends StatelessWidget {
  final VoidCallback? onLogout;
  final Color? color;

  const LogoutFab({Key? key, required this.onLogout, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final colorsViewModel = context.watch<ColorsViewModel>();
    return authViewModel.logingOut || colorsViewModel.clearingColors
        ? _inProgressFab()
        : _extendedFab(authViewModel, colorsViewModel);
  }

  FloatingActionButton _inProgressFab() {
    return FloatingActionButton(
        onPressed: null,
        foregroundColor: color == null ? Colors.white : color!.onTextColor(),
        backgroundColor: color,
        child: CircularProgressIndicator(backgroundColor: Colors.white));
  }

  FloatingActionButton _extendedFab(
    AuthViewModel authViewModel,
    ColorsViewModel colorsViewModel,
  ) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.exit_to_app),
      onPressed: () async {
        await authViewModel.logout();
        await colorsViewModel.clearColors();
        onLogout!();
      },
      foregroundColor: color == null ? Colors.white : color!.onTextColor(),
      backgroundColor: color,
      label: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Logout'),
      ),
    );
  }
}
