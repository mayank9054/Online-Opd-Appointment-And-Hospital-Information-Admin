import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;

class pdfview extends StatefulWidget {
  String paths;
  pdfview(this.paths);
  @override
  _pdfviewState createState() => _pdfviewState();
}

class _pdfviewState extends State<pdfview> {
  PDFDocument doc;
  String path;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    path = widget.paths;
    ViewNow();
  }
  ViewNow() async {
    print('$doc!!!!!!!!@@@@@@@@####$path');
    doc = await PDFDocument.fromURL(path);
    print('$doc!!!!!!!!@@@@@@@@####$path');
    setState(() {
      print('$doc!!!!!!!!@@@@@@@@####$path');
    });
  }

  @override
  Widget build(BuildContext context) {



    Widget Loading(){
      ViewNow();
      if(doc==null){
        return Center(
            child: CircularProgressIndicator(
            ));
      }
    }

    return Scaffold(
      body: doc==null?Loading():PDFViewer(document: doc),
    );
  }
}


