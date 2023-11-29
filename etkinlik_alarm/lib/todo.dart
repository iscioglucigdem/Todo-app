import 'package:etkinlik_alarm/auth_service.dart';
import 'package:etkinlik_alarm/profil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Todo extends StatefulWidget {
  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  // late GoogleMapController _controller;
  FirebaseAuth auth = FirebaseAuth.instance;
  //harita görüntüleme ve işin yapılacağı konumun seçilmesi eksiktir , o konumun enlem ve boylamı elle girilimiştir
  var latitude = 52.3546274;
  var longitude = 4.8285838;
  Map<String, dynamic> toMap = {};
  @override
  @override
  void initState() {
    super.initState();
    _data();
  }

  void _data() async {
    try {
      Map<String, dynamic> data =
          await AuthService().getEtkinlik(auth.currentUser!.uid);

      setState(() {
        toMap = data;
      });
    } catch (e) {
      print(e);
    }
  }

//iki mesafe arasındaki konuma bakar
  void getLocation() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      var locationMessage =
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
    });
    //İki mesafe arasındaki uzaklığa bakar
    double mesafe = Geolocator.distanceBetween(
        position.latitude, position.longitude, latitude, longitude);
  }

  Future<Position> _konumIzni() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Konum hizmetleri devre dısı.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Konum hizmeti reddedildi');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Konum izni tamamen reddedildi.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text("YAPILACAK İŞLER"),
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle, size: 35.0),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profil()),
                );
              },
            ),
          ]),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          child: Expanded(
            child: ListView.builder(
              itemCount: toMap.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(toMap[index]),
                  onTap: () {
                    _showDialogSil(context, index);
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: ElevatedButton(
              onPressed: () {
                _showDialog(context);
              },
              child: Text(
                "Etkinlik ekle",
                style: TextStyle(fontSize: 20, color: Colors.purple),
              )),
        ),
      ]),
    );
  }

  void _showDialog(BuildContext context) {
    TextEditingController yapilacakIs = TextEditingController();
    TextEditingController konum = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Listeye Ekle'),
          content: Column(
            children: [
              TextField(
                controller: yapilacakIs,
                decoration: InputDecoration(labelText: 'Yapılacak iş '),
              ),
              TextField(
                controller: konum,
                decoration: InputDecoration(labelText: 'Konumun adı'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  toMap['todoName'] = yapilacakIs.text;
                  toMap['konum'] = konum.text;
                  AuthService().todo(auth.currentUser!.uid, toMap);
                });
                Navigator.pop(context);
              },
              child: Text('Ekle'),
            ),
          ],
        );
      },
    );
  }

  void _showDialogSil(BuildContext context, index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Etkinliği sil'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  toMap.remove(index);
                });
                Navigator.pop(context);
              },
              child: Text('Sil'),
            ),
          ],
        );
      },
    );
  }
}
