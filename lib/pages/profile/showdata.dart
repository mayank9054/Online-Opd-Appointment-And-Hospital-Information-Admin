import 'dart:io';
import 'package:care_hospital_admin/pages/profile/listview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowData extends StatefulWidget {
  var profileinfo;

  ShowData(this.profileinfo);

  @override
  _ShowDataState createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  var profileinfo;
  var len;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileinfo = widget.profileinfo;
    print(profileinfo);
    len = profileinfo['report'].length;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        iconTheme: IconThemeData(
          color: Colors.teal,
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.teal,
          ),
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/${profileinfo['gender']}.png'),
                    radius: 70.0,
                  ),
                ),
                SizedBox(height: 40.0),
                Text(
                  'Name : ${profileinfo['firstname']} ${profileinfo['lastname']}',
                  style: GoogleFonts.lato(
                    textStyle: _textStyle(),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Number :  ${profileinfo['phonenumber']}',
                  style: GoogleFonts.lato(
                    textStyle: _textStyle(),
                  ),
                ),
                // Divider(),
                SizedBox(height: 20.0),
                Text(
                  'Gender :  ${profileinfo['gender']}',
                  style: GoogleFonts.lato(
                    textStyle: _textStyle(),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Email : ${profileinfo['email']}',
                  style: GoogleFonts.lato(
                    textStyle: _textStyle(),
                  ),
                ),
                // Divider(),
                SizedBox(height: 20.0),
                Text(
                  'Date Of Birth :  ${profileinfo['dob']}',
                  style: GoogleFonts.lato(
                    textStyle: _textStyle(),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Weight :  ${profileinfo['weight']}(KG)',
                  style: GoogleFonts.lato(
                    textStyle: _textStyle(),
                  ),
                ),
                // Divider(),
                SizedBox(height: 20.0),
                Text(
                  'Height :  ${profileinfo['height']}(CM)',
                  style: GoogleFonts.lato(
                    textStyle: _textStyle(),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Address :  ${profileinfo['address']}',
                  style: GoogleFonts.lato(
                    textStyle: _textStyle(),
                  ),
                ),
               SizedBox(height: 20),

               Center(
                 child: Container(
                   width: 170,
                   child: Card(
                     color: Colors.grey[50],
                     margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                     child: new ListTile(
                       title: new Text('Upload Report',
                       style: TextStyle(
                         color: Colors.red,
                         fontSize: 18.0,
                       ),
                       textAlign: TextAlign.center,
                       ),
                       onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context) {
                           return listview(profileinfo);
                         }));
                       },
                       ),

                     ),
                 ),
               ),
              ],
            ),
          ),
        ),
      ),

    );
  }
  TextStyle _textStyle(){
    return TextStyle(
      fontSize: 20.0,
      color: Colors.grey[600],
    );
  }




}

