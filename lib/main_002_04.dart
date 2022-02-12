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
import 'package:authwallapp/data/acua_mvp_repostory.dart';
import 'package:authwallapp/viewmodels/acua_view_model.dart';
import 'package:common/cache/preference.dart';
import 'package:flutter/material.dart';
import 'package:authwallapp/router/my_app_router_delegate_04.dart';

import 'package:authwallapp/data/auth_repository.dart';
import 'package:authwallapp/data/colors_repository.dart';
import 'package:authwallapp/viewmodels/auth_view_model.dart';
import 'package:authwallapp/viewmodels/colors_view_model.dart';
import 'package:flutter/services.dart'; 
import 'package:provider/provider.dart';

import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';
import 'router/my_app_route_information_parser_04.dart';

//MQTT imports

import 'MQTT_CONNECTORS/cpl_connector.dart';
import 'MQTT_CONNECTORS/hum_connector.dart';
import 'MQTT_CONNECTORS/hum_suelo_connector.dart';
import 'MQTT_CONNECTORS/pres_connector.dart';
import 'MQTT_CONNECTORS/temp_connector.dart';
import 'MQTT_CONNECTORS/termocuple_connector.dart';
 

void main() async {
WidgetsFlutterBinding.ensureInitialized();
  await TempProvider().init();
  await PresProvider().init();  
  await HumProvider().init();
  await CplProvider().init();
  await HumSueloProvider().init();
  await TermocupleProvider().init(); 

  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]); 
  configureApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyAppRouterDelegate delegate;
  late MyAppRouteInformationParser parser;
  late AuthRepository authRepository;
  late ColorsRepository colorsRepository;
  late AcuaMvpRepository acuaRepository;

  @override
  void initState() {
    super.initState();
    authRepository = AuthRepository(Preference());
    colorsRepository = ColorsRepository();
    acuaRepository = AcuaMvpRepository();
    delegate = MyAppRouterDelegate(authRepository, colorsRepository,acuaRepository);
    parser = MyAppRouteInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(
          create: (_) => AuthViewModel(authRepository),
        ),
        ChangeNotifierProvider<ColorsViewModel>(
          create: (_) => ColorsViewModel(colorsRepository),
        ),
        ChangeNotifierProvider<AcuaViewModel>(
          create: (_) => AcuaViewModel(acuaRepository),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: delegate,
        routeInformationParser: parser,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
