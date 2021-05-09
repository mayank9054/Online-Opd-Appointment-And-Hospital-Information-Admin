import 'dart:io';
import 'package:care_hospital_admin/pages/profile/downloadpdf.dart';
import 'package:care_hospital_admin/pages/profile/pdfview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class listview extends StatefulWidget {
  var profileinfo;

  listview(this.profileinfo);

  @override
  _listviewState createState() => _listviewState();
}

class _listviewState extends State<listview> {
  @override
  var profileinfo, len, details;
  String downloadURL;
  bool loading = false;
  bool downloading = false;
  var progressString = "";

  void initState() {
    // TODO: implement initState
    super.initState();
    profileinfo = widget.profileinfo;
    details = profileinfo['report'];
    len = details.length;
  }

  Future<void> downloadFile(String imgUrl) async {
    Dio dio = Dio();

    try {
      var dir = await getApplicationDocumentsDirectory();

      await dio.download(imgUrl, "${dir.path}/myimage.pdf",onReceiveProgress: (rec, total) {
        print('${dir.path}');
        print("Rec: $rec , Total: $total");

        setState(() {
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
        });
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressString = "Completed";
    });
    print("Download completed");
  }

  @override
  Widget build(BuildContext context) {
    Widget Loading() {
      return Center(child: CircularProgressIndicator());
    }

    return loading ? Loading() : Scaffold(
            body: SafeArea(
              child: Stack(
                  children: <Widget>[
                Container(
                  child: ListView.builder(
                      itemCount: profileinfo['report'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          trailing: InkWell(
                            child: Icon(Icons.download_sharp),
                            onTap: () {
                              int con = index;
                              con++;
                              downloadFile(profileinfo['report'][index]);
                            },
                          ),
                          title: Text("$index.pdf"),
                          leading: Icon(Icons.picture_as_pdf),
                          onTap: () {
                            int con = index;
                            con++;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    pdfview(profileinfo['report']['$con']),
                              ),
                            );
                          },
                        );
                      }),
                ),
                //Stack(
                 // children: <Widget>[
                    Center(
                        child: downloading
                            ? Container(
                          height: 120.0,
                          width: 200.0,
                          child: Card(
                            color: Colors.black,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircularProgressIndicator(),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  "Downloading File: $progressString",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                            : Text(''),
                    ),
                //  ],
                //)
              ]),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              foregroundColor: Colors.red,
              backgroundColor: Colors.grey[200],
              onPressed: () async {
                getPdfAndUpload();
              },
            ),
          );
  }

  Future getPdfAndUpload() async {
    File filee;
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      filee = File(result.files.single.path);
      print(filee);
    } else {
      // User canceled the picker
    }
  if(len!= null){
    len++;
  }

    print('lenlenlenlenlenlenlenlenlenlenvlenlenlenlenlenlenlenlenlenlenlenlenlenlenlenlenv$len');
    try {
      setState(() {
        loading = true;
      });
      await FirebaseStorage.instance
          .ref('report/${profileinfo['firstname']} ${profileinfo['lastname']} $len.pdf')
          .putFile(filee);
      downloadURL = await FirebaseStorage.instance
          .ref(
              'report/${profileinfo['firstname']} ${profileinfo['lastname']} $len.pdf')
          .getDownloadURL();
      print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!$downloadURL');
      senddatafirestore();
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future<void> senddatafirestore() async {
    print(profileinfo['report']);
    profileinfo['report'].addAll({'$len': '$downloadURL'});
    print('!!!!!!!!!!!!!!@@@@@@@@@@@@@@@@#############${profileinfo['report']}');

    String pa = profileinfo['uid'];
    if (downloadURL != null) {
      await FirebaseFirestore.instance.collection('profile').doc(pa).update({
        'report':  profileinfo['report'],
      }).then((value) {
        print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!sucess');
        setState(() {
          loading = false;
        });
      });
    }
  }
}
