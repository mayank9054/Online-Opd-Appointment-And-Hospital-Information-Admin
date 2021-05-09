import 'package:care_hospital_admin/Services/AuthenticationService.dart';
import 'package:care_hospital_admin/pages/loading.dart';
import 'package:care_hospital_admin/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _key = new GlobalKey();

  bool _isLoading = false;
  bool _validate = false;

  String email;
  String password;
  bool loading = false;

  final AuthService _auth = AuthService();

  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(

        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(5, 30, 5, 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.png'),
                  radius: 80.0,
                  backgroundColor: Colors.white,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                'Care Hospital',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        autofocus: true,
                        decoration: InputDecoration(
                          // focusColor: Colors.red,
                          // fillColor: Colors.teal,
                          // filled: true,
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.teal,
                          ),
                        ),
                        controller: _emailContoller,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) => !val.contains('@') ? "Enter valid Email" : null,
                        onSaved: ((value) {
                          email = value;
                          print(email);
                        }),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          // focusColor: Colors.red,
                          // fillColor: Colors.teal,
                          // filled: true,
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.teal,
                          ),
                        ),
                        controller: _passwordController,
                        obscureText: true,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {
                          if(val.length != 0 || val != ""){
                            return null;
                          }else{
                            return "Enter valid Password";
                          }
                        },
                        onSaved: ((value) {
                          password = value;
                          print(password);
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                color: Colors.redAccent[700],
                child: Text(
                  'Login',
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
                onPressed: () async {
                  if (_key.currentState.validate()) {
                    _key.currentState.save();
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(
                        email, password);
                    if (result == null) {
                      setState(() {
                        loading = false;
                        // error = 'Could not sign in with those credentials';
                      });
                    } else {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return Profile();
                      }));
                    }
                  };
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
