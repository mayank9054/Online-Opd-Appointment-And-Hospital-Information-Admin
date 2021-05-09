import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class listdata extends StatefulWidget {
  final data;
  listdata({Key key, this.data}) : super(key: key);
  @override
  _listdataState createState() => _listdataState();
}

class _listdataState extends State<listdata> {
  var data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.data;
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("${data['${++index}']}",
              style: GoogleFonts.balooBhai(
                fontSize: 25.0,
                color: Colors.green[900],
              ),),
          );
        });
  }
}
