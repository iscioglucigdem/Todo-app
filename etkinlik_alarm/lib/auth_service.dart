

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:etkinlik_alarm/todo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login.dart';
class AuthService{

   final userCollection=FirebaseFirestore.instance.collection("users");
   final firebaseAuth=FirebaseAuth.instance;

    Future<void>  signUp(BuildContext context ,{required String email,required String name,required String password})async{
      try{
        final UserCredential userCredential= await firebaseAuth.createUserWithEmailAndPassword(email:email, password: password);
        if (userCredential.user!=null){
          _users(email: email, name: name, password: password);
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => Login()),
          );

        }

      }on FirebaseAuthException catch(e){
        Fluttertoast.showToast(msg:e.message!,toastLength: Toast.LENGTH_LONG);

      }

    }

   Future<void> _users({required String email,required String name,required String password})async{
     await userCollection.doc().set({
       "email": email,
       "kullaniciAdi": name,
       "password": password
     });
   }


    Future<void> login(BuildContext context , {required String email,required String password})async{
        try{
          final UserCredential userCredential= await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
          if (userCredential.user!=null){
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => Todo()),
            );
            //Fluttertoast.showToast(msg:"GİRİŞ BAŞARILI",toastLength: Toast.LENGTH_LONG);
          }
        }on FirebaseAuthException catch(e){
          Fluttertoast.showToast(msg:e.message!,toastLength: Toast.LENGTH_LONG);

        }
    }
   void todo(String userId,  Map<String, dynamic> toMap) {
     FirebaseFirestore.instance.collection('todo').doc(userId).update({
       'etkinlikler': FieldValue.arrayUnion([toMap]),
     });
   }


   Future<Map<String, dynamic>> getEtkinlik(String userId) async {
     try {
       DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
       await FirebaseFirestore.instance.collection('todo').doc(userId).get();

       if (documentSnapshot.exists) {
         Map<String, dynamic> data = documentSnapshot.data()!;
         Map<String, dynamic> etkinlikMap =
         Map<String, dynamic>.from(data['etkinlikler'] ?? {});
         return etkinlikMap;
       } else {
         return {};
       }
     } catch (e) {
       print(e);
       throw e;
     }
   }
}


