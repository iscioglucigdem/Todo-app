import 'package:etkinlik_alarm/auth_service.dart';
import 'package:etkinlik_alarm/signUp.dart';
import 'package:etkinlik_alarm/todo.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController epostaController = TextEditingController();
  TextEditingController sifreController = TextEditingController();

  void _clearTextFields() {
    epostaController.clear();
    sifreController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Giriş yap",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "E-mail",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    height: 48,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: epostaController,
                      decoration: InputDecoration(
                        hintText: 'e-mail',
                        hintStyle: TextStyle(color: Colors.white38),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                BorderSide(width: 1, color: Colors.purple)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Parola",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Container(
                    height: 48,
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: sifreController,
                      decoration: InputDecoration(
                        hintText: 'parola',
                        hintStyle: TextStyle(color: Colors.white38),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                BorderSide(width: 1, color: Colors.purple)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 38,
                  ),
                  Container(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.purple[400],
                          minimumSize: Size(400, 55),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14))),
                      onPressed: () async {
                        AuthService().login(context,
                            email: epostaController.text,
                            password: sifreController.text);
                        _clearTextFields();
                      },
                      child: Text(
                        'Giriş yap',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    style: TextButton.styleFrom(
                        // backgroundColor: Colors.purple[400],
                        minimumSize: Size(400, 55),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))),
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                      _clearTextFields();
                    },
                    child: Text(
                      'Kayıt Ol',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
