import 'package:etkinlik_alarm/auth_service.dart';
import 'package:etkinlik_alarm/login.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController kullaniciAdiController = TextEditingController();
  TextEditingController epostaController = TextEditingController();
  TextEditingController sifreController = TextEditingController();

  void _clearTextFields() {
    epostaController.clear();
    sifreController.clear();
    kullaniciAdiController.clear();
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
                    "Kayıt Ol",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
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
                    height: 20,
                  ),
                  Text(
                    "Kullanıcı Adi",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 2),
                  Container(
                    height: 48,
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      controller: kullaniciAdiController,
                      decoration: InputDecoration(
                        hintText: 'kullanıcı adı',
                        hintStyle: TextStyle(color: Colors.white38),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                BorderSide(width: 1, color: Colors.purple)),
                      ),
                    ),
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
                        AuthService().signUp(context,
                            email: epostaController.text.toString(),
                            name: kullaniciAdiController.text.toString(),
                            password: sifreController.text.toString());
                        _clearTextFields();
                      },
                      child: Text(
                        'Kayıt ol',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                      _clearTextFields();
                    },
                    child: Text(
                      'Giris Yap',
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
