

import 'package:authwallapp/viewmodels/acua_view_model.dart';
import 'package:authwallapp/widgets1/in_progress_message.dart';
import 'package:authwallapp/widgets1/shape_border_gridview.dart';
import 'package:common/extensions/color_extensions.dart';
import 'package:common/model/shape_border_type.dart';
import 'package:common/widgets/app_bar_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:authwallapp/viewmodels/auth_view_model.dart';
import 'package:authwallapp/viewmodels/colors_view_model.dart';

import 'package:authwallapp/widgets/app_bar_back_button.dart';
import 'package:authwallapp/widgets/acua_logout_fab.dart';
import 'package:provider/provider.dart';

import 'PROVIDERS/SENSORS_PROVIDERS/cpl.dart';
import 'PROVIDERS/SENSORS_PROVIDERS/humidity.dart';
import 'PROVIDERS/SENSORS_PROVIDERS/pressure.dart';
import 'PROVIDERS/SENSORS_PROVIDERS/suelo.dart';
import 'PROVIDERS/SENSORS_PROVIDERS/temperature.dart';
import 'PROVIDERS/SENSORS_PROVIDERS/termocuple.dart';

class SensorScreen extends StatefulWidget {
  final String colorCode;
  final Function(ShapeBorderType) onShapeTap;
  final VoidCallback onLogout;
  

  const SensorScreen({
    Key? key,
    required this.colorCode,
    required this.onShapeTap,
    required this.onLogout,
  }) : super(key: key);

  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  Color get color => widget.colorCode.hexToColor();
  VoidCallback get logout => widget.onLogout;



 @override
  Widget build(BuildContext context) {
    _body(context);
    return Padding(
      padding: const EdgeInsets.all(0.8),
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection:Axis.vertical ,
            
                child: 
                    Container(
                    padding: const EdgeInsets.all(5.0),
                      child:
                        Wrap(
                          alignment: WrapAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    
                                  
                                          Expanded(
                                            
                                            child: Container(
                                              width: 40,
                                              child: Column(
                                                children: [
                                                  Temperature(),
                                                ],
                                              ),
                                            ),
                                          ),  
                                       
                                    
                                
                                        Column(
                                          
                                          children: [
                                            Row(
                                              children: [
                                                Humidity(),
                                                /* Pressure()    */
                                              ],
                                            ),
                                            Row(
                                              children: [
                                              Suelo(),
                                              Cpl()   
                                              ],
                                            ),                                                                 
                                    
                                          ],
                                          
                                        ), 
                                                                                                      
                                  ],
                                ),   
                              ], //children
                        )
                    ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: LogoutFab(onLogout: widget.onLogout),
    ),
    );
  }
//------------------------------------------------------------------------





  Widget _body(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final acuaViewModel = context.watch<AcuaViewModel>();
    bool inProgress;
    String? progressName;
    if (authViewModel.logingOut) {
      inProgress = true;
      progressName = "Logout";
    } else if (acuaViewModel.clearingSensors) {
      inProgress = true;
      progressName = "Clearing Sensors";
    } else {
      inProgress = false;
      progressName = null;
    }
    return inProgress && progressName != null
        ? InProgressMessage(progressName: progressName, screenName: "AcuaSensorScreen")
        : ShapeBorderGridView(
            color: color,
            onShapeTap: widget.onShapeTap,
          );
  }
}
