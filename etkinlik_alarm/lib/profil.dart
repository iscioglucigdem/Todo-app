import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profil extends StatefulWidget {
  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  FirebaseAuth auth = FirebaseAuth.instance;
  late File yuklenecekDosya;
  String? indirmeBaglantisi = null;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      baglantiAl();
    });
  }

  baglantiAl() async {
    String baglanti = await FirebaseStorage.instance
        .ref()
        .child("Profil resimleri")
        .child(auth.currentUser!.uid)
        .getDownloadURL();
    setState(() {
      indirmeBaglantisi = baglanti;
    });
  }

  kameradanAl() async {
    var alinanDosya =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (alinanDosya != null) {
      setState(() {
        yuklenecekDosya = File(alinanDosya!.path);
      });
    }

    Reference referansYol = FirebaseStorage.instance
        .ref()
        .child("Profil resimleri")
        .child(auth.currentUser!.uid);
    UploadTask yuklemeGorevi = referansYol.putFile(yuklenecekDosya);
    String url = await (await yuklemeGorevi).ref.getDownloadURL();
    setState(() {
      indirmeBaglantisi = url;
    });
  }

  String kullaniciBilgileri() {
    String? email;
    if (auth.currentUser != null) {
      // String displayName = auth.currentUser!.displayName ?? "Belirtilmemiş";
      email = auth.currentUser!.email ?? "Belirtilmemiş";
      print("E-Posta Adresi: $email");
    }
    return email!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PROFİL SAYFASI"),
        backgroundColor: Colors.purple,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipOval(
                  child: indirmeBaglantisi == null
                      ? IconButton(
                          onPressed: kameradanAl,
                          icon: Icon(
                            Icons.account_circle,
                            size: 60,
                          ))
                      : Image.network(
                          indirmeBaglantisi!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        )),
              SizedBox(
                height: 5,
              ),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.purple, minimumSize: Size(100, 25)),
                child: Text(
                  "Resim ekle",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: kameradanAl,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                kullaniciBilgileri(),
                style: TextStyle(fontSize: 25, color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
