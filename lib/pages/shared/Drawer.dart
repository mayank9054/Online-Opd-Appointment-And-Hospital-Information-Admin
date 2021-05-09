import 'package:care_hospital_admin/pages/Login.dart';
import 'package:care_hospital_admin/pages/department/Gastroenterology.dart';
import 'package:care_hospital_admin/pages/department/GeneralSurgery.dart';
import 'package:care_hospital_admin/pages/department/OrthopaedicsAndTraumatology.dart';
import 'package:care_hospital_admin/pages/department/PlasticSurgery.dart';
import 'package:care_hospital_admin/pages/department/Psychiatry.dart';
import 'package:care_hospital_admin/pages/department/Skin.dart';
import 'package:care_hospital_admin/pages/department/Surgery.dart';
import 'package:care_hospital_admin/pages/department/TB_Chest.dart';
import 'package:care_hospital_admin/pages/department/generalmedicine.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:care_hospital_admin/pages/profile/profile.dart';

class Drawerr extends StatefulWidget {
  @override
  _DrawerrState createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.teal[50],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage:
                  AssetImage('assets/logo.png'),
                  radius: 50.0,
                  backgroundColor: Colors.teal[50],
                ),
                SizedBox(height: 10.0),
                Text(
                  ' Care Hospital',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Profile();
              }));
            },
            child: ListTile(
              leading: Icon(
                Icons.person,
                size: 25.0,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Gastroenterology();
              }));
            },
            child: ListTile(
              leading: Icon(
                Icons.assignment,
                size: 25.0,
              ),
              title: Text(
                'Gastroenterology',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GeneralMedicine();
              }));
            },
            child: ListTile(
              leading: Icon(
                Icons.assignment,
                size: 25.0,
              ),
              title: Text(
                'General Medicine',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GeneralSurgery();
              }));
            },
            child: ListTile(
              leading: Icon(
                Icons.assignment,
                size: 25.0,
              ),
              title: Text(
                'General Surgey',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return OrthopaedicsAndTraumatology();
              }));
            },
            child: ListTile(
              leading: Icon(
                Icons.assignment,
                size: 25.0,
              ),
              title: Text(
                'Orthopaedics And Traumatology',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PlasticSurgery();
              }));
            },
            child: ListTile(
              leading: Icon(
                Icons.assignment,
                size: 25.0,
              ),
              title: Text(
                'Plastic Surgery',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Psychiatry();
              }));
            },
            child: ListTile(
              leading: Icon(
                Icons.assignment,
                size: 25.0,
              ),
              title: Text(
                'Psychiatry',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Skin();
              }));
            },
            child: ListTile(
              leading: Icon(
                Icons.assignment,
                size: 25.0,
              ),
              title: Text(
                'Skin',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Surgery();
              }));
            },
            child: ListTile(
              leading: Icon(
                Icons.assignment,
                size: 25.0,
              ),
              title: Text(
                'Surgery',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),

          Divider(),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TBChest();
              }));
            },
            child: ListTile(
              leading: Icon(
                Icons.assignment,
                size: 25.0,
              ),
              title: Text(
                'TB & Chest',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          Divider(),
          InkWell(
            onTap: showMyDialog,
            child: ListTile(
              leading: Icon(
                Icons.logout,
                size: 25.0,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text(''),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Do you want to Log out ?',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancle'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: signout,
            ),
          ],
        );
      },
    );
  }
  Future<void> signout() async {
    await _auth.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Login();
    }));
  }
}

// class drawer {
//
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
//
//
// }