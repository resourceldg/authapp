import 'package:authwallapp/acua_mvp_sensors_screen.dart';
import 'package:authwallapp/widgets1/in_progress_message.dart';
import 'package:common/dimens/app_dimens.dart';
import 'package:flutter/material.dart';
import 'package:authwallapp/viewmodels/auth_view_model.dart';

import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback onLogin;
  

    
const LoginScreen({Key? key, required this.onLogin,}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    
    String? emptyValidator(String? value) {
    return (value == null || value.isEmpty) ? 'El campo es requerido' : null;
    }
    final authViewModel = context.watch<AuthViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(24.0),
                margin: const EdgeInsets.only(top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[                    
                  Column(
                        children: 
                          [Text(
                            'Hola Extraño',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.black45),
                          ),
                        ],
                  ),
                    
                    Form(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            SizedBox(height: 8),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(labelText: 'Ingresa tu correo'),
                              validator: emptyValidator,
                            ),
                            SizedBox(height: 8),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(labelText: 'Y tu contraseña'),
                              validator: emptyValidator,
                            ),
                            SizedBox(height: 18),
                           Center(
                                child: authViewModel.logingIn
                                    ? InProgressMessage(progressName: "Login", screenName: "LoginScreen")
                                    : ElevatedButton(
                                        onPressed: () async {
                                          final authViewModel = context.read<AuthViewModel>();
                                          final result = await authViewModel.login(email: _emailController.text, password: _passwordController.text); 
                                          if (result == true) {
                                            onLogin();
                                            
                                          } else {
                                            authViewModel.logingIn = false;
                                            
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(AppDimens.SIZE_SPACING_MEDIUM),
                                          child: Text('Log in'),
                                        ),
                                      ),
                              ),
                            
                          ],
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
            )
    );
  }
}
