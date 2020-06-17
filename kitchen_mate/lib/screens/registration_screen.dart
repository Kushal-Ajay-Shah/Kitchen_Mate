import 'package:flutter/material.dart';
import 'package:kitchen_mate/components/rounded_button.dart';
import 'package:kitchen_mate/models/user_email_arg.dart';
import 'package:kitchen_mate/screens/home_screen.dart';
import 'package:kitchen_mate/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  // final AuthService _auth = AuthService();
  bool showSpinner = false;
  String email = '';
  String password = '';
  String error = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  validator: (value) => value.isEmpty ? 'Enter an email' : null,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  validator: (val) =>
                      val.length < 6 ? 'Enter a password of atleast 6 characters' : null,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  title: 'Register',
                  colour: Colors.lime,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        showSpinner = true;
                      });
                      // dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      // if(result != null){
                      //   Navigator.pushNamed(context, Home.id);
                      // }//else if(result == null){
                      //   error = 'Please supply a valid email';
                      //     setState(() {
                      //       showSpinner = false;
                      //     });
                      //}
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser != null) {
                          Navigator.pushNamed(context, Home.id,arguments: UserEmail(email: email));
                        } else if (newUser == null) {
                          error = 'Please supply a valid email';
                          setState(() {
                            showSpinner = false;
                          });
                        }

                        setState(() {
                          showSpinner = false;
                        });
                      } catch (e) {
                        print(e);
                        error = 'Please supply a valid email';
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
