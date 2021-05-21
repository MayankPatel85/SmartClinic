import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartclinic/widgets/clippers.dart';
import 'package:smartclinic/widgets/show_progress_indicator.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthMode _authMode = AuthMode.Login;
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isHidden = true;
  var _isLoading = false;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  void showErrorBox(String errorMessage) {
    Platform.isIOS
        ? showCupertinoDialog(
            context: context,
            builder: (ctx) => CupertinoAlertDialog(
              title: Text('Something went wrong'),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          )
        : showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Something went wrong'),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
  }

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState.validate();
    final _auth = FirebaseAuth.instance;
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });
    if (isValid) {
      _formKey.currentState.save();
      try {
        if (_authMode == AuthMode.Signup) {
          final authResult = await _auth.createUserWithEmailAndPassword(
              email: _userEmail, password: _userPassword);
          FirebaseFirestore.instance
              .collection('users')
              .doc(authResult.user.uid)
              .set({
            'username': _userName,
            'email': _userEmail,
          });
        }
        await _auth.signInWithEmailAndPassword(
            email: _userEmail, password: _userPassword);
      } on FirebaseAuthException catch (e) {
        showErrorBox(e.message);
      } catch (e) {
        showErrorBox('Something Went Wrong.');
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                    height: size.height * 0.34,
                    color: Color(0xFF3490de),
                  ),
                ),
                ClipPath(
                  clipper: CustomShape2(),
                  child: Container(
                    height: size.height * 0.47,
                    color: Color(0xFF3490de).withOpacity(0.4),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                _authMode == AuthMode.Login ? 'Login' : 'Sign Up',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.pink, //Color(0xFF3490de),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.blueAccent),
                      color: Colors.grey[300],
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter your E-mail',
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Invalid email!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userEmail = value;
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.blueAccent),
                      color: Colors.grey[300],
                    ),
                    child: TextFormField(
                      obscureText: _isHidden,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        border: InputBorder.none,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isHidden = !_isHidden;
                              });
                            },
                            child: Icon(_isHidden
                                ? Icons.visibility_off
                                : Icons.visibility)),
                      ),
                      validator: (value) {
                        if (value.isEmpty || value.length < 5) {
                          return 'Password should be at least 6 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userPassword = value;
                      },
                    ),
                  ),
                  if (_authMode == AuthMode.Signup)
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.blueAccent),
                        color: Colors.grey[300],
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter user name',
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter valid username.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _userName = value;
                        },
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _switchAuthMode,
                    child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
                      style: TextStyle(color: Colors.pink),
                    ),
                  ),
                  _isLoading
                      ? ShowProgressIndicator()
                      : Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(12)),
                          child: TextButton(
                            child: Text(
                              _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                              style:
                                  TextStyle(color: Colors.pink, fontSize: 20),
                            ),
                            onPressed: _trySubmit,
                          ),
                        ),
                ],
              ),
            ),
            ClipPath(
              clipper: CustomShape3(),
              child: Container(
                height: size.height * 0.27,
                color: Color(0xFF3490de),
              ),
            ),
          ],
        ),
      ),

      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 30),
      //       child: TextButton(
      //         onPressed: _switchAuthMode,
      //         child: Text(
      //           '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD',
      //           style: TextStyle(color: Colors.white),
      //         ),
      //       ),
      //     ),
      //     Container(
      //       padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      //       decoration: BoxDecoration(
      //           border: Border.all(color: Colors.white),
      //           borderRadius: BorderRadius.circular(12)),
      //       child: TextButton(
      //         child: Text(
      //           _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
      //           style: TextStyle(color: Colors.white, fontSize: 20),
      //         ),
      //         onPressed: () {},
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
