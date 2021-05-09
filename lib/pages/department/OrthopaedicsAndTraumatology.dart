import 'package:care_hospital_admin/pages/department/listdata.dart';
import 'package:care_hospital_admin/pages/shared/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrthopaedicsAndTraumatology extends StatefulWidget {
  @override
  _OrthopaedicsAndTraumatologyState createState() => _OrthopaedicsAndTraumatologyState();
}

class _OrthopaedicsAndTraumatologyState extends State<OrthopaedicsAndTraumatology> {

  String formatted = null;
  int size;
  DateTime dateTime;

  void datetimeresult() {
    DateTime now = dateTime;
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    formatted = formatter.format(now);
  }

  CollectionReference profile = FirebaseFirestore.instance.collection(
      'Orthopaedics and Traumatology');

  Future<QuerySnapshot> getdata() async {
    if(formatted != null) {
      var result = await profile.where("date", isEqualTo: formatted)
          .get()
          .then((QuerySnapshot documentSnapshot) {
        if (documentSnapshot == null) {
          CircularProgressIndicator();
        } else {
          size = documentSnapshot.size;
          print('!!!@@@@######${documentSnapshot.docChanges}');
          return documentSnapshot;
        }
      });
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Orthopaedics and Traumatology'),
        backgroundColor: Colors.teal[300],
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 15.0, bottom: 8.0,top: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990),
                            lastDate: DateTime.now().add(Duration(days: 30)),
                          ).then((date) {
                            setState(() {
                              dateTime = date;
                              datetimeresult();
                            });
                          });
                        },

                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        dateTime == null ? "" : formatted,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
      drawer: Drawerr(),
      body: Container(
        child: FutureBuilder(
          future: getdata(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
              // return Center(child: Text("Loading"));
            }

            if (size == 0 || formatted == null) {
              return Center(
                child: Text('No Data Found',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20.0,
                  ),
                ),
              );
            }

            return new ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return Card(
                  color: Colors.grey[50],
                  margin: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                  child: new ListTile(
                    title: new Text('${document.data()['name']} '),
                    subtitle: new Text('${document.data()['phonenumber']}'),
                    leading: Icon(
                      Icons.person,
                      size: 35.0,
                      color: Colors.red,
                    ),
                    trailing: IconButton(
                        icon : Icon(
                          Icons.history,
                          size: 35.0,
                          color: Colors.blueAccent,
                        ),
                        onPressed: () {
                          showModalBottomSheet(context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                              ),
                              builder: (context) {
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                                  child: listdata( data : document.data()['history']),
                                );
                              });
                        }
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
