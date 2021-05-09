import 'package:firebase_storage/firebase_storage.dart';
import 'package:care_hospital_admin/pages/profile/showdata.dart';
import 'package:care_hospital_admin/pages/shared/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  TextEditingController _controller = TextEditingController();
  int number = 0,size;

  CollectionReference profile = FirebaseFirestore.instance.collection('profile');
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<QuerySnapshot> getdata() async {
    if (number == 0) {
      var result = await profile.get()
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
    } else {
      var result = await profile.where("phonenumber", isEqualTo: number).get()
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
 // String _path;
 // Map<String,String> _paths;
  //String _extension;
 // FileType _pickType;
 // GlobalKey<ScaffoldState> _scafflodkey = GlobalKey();
  // List<StorageUploadTask> _tasks = <StorageUploadTask>[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        backgroundColor: Colors.teal[300],
        elevation: 0.0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 12.0, bottom: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: TextFormField(
                    onChanged: (val) {
                      number = int.parse(val);
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Search Phonenumber",
                      contentPadding: const EdgeInsets.only(left: 24.0),
                      border: InputBorder.none,

                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    if(number.toString().length != 10){
                      number = 0;
                    }
                    getdata();
                  });
                },
              )
            ],
          ),
        ),
    ),
      drawer: Drawerr(),
      body: Container(
        child: FutureBuilder(
          future: getdata(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
              // return Center(child: Text("Loading"));
            }

            if(size == 0){
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
                    title: new Text('${document.data()['firstname']} ${document.data()['lastname']}'),
                    subtitle: new Text('${document.data()['phonenumber']}'),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/${document.data()['gender']}.png'),
                      radius: 20.0,
                    ),

                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return ShowData(document.data());
                      }));
                    },
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





