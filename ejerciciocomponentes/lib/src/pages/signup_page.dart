// ignore_for_file: file_names

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ejerciciocomponentes/navigation_drawer/navigation_drawer.dart';
import 'package:ejerciciocomponentes/src/pages/card_page.dart';
import 'package:ejerciciocomponentes/src/utils/icon_utils.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../menu_provider.dart';
import 'alert_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Widget _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Password',
          style: const TextStyle(fontFamily: 'Opensans', color: Colors.white),
        ),
        const SizedBox(
          height: 10.0,
        ),
        //container 1
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0,7),
              

            )
          ]),
          height: 60.0,
          child: const TextField(
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your Password',
              hintStyle: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            ),
          ),
        ),
         const SizedBox(
          height: 10.0,
        ),
        //container 2
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration( borderRadius: BorderRadius.circular(30.0), boxShadow: [
            BoxShadow(
              
              color: Colors.grey.shade400.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0,7),
              

            )
          ]),
          height: 60.0,
          child: const TextField(
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle( color: Colors.white, fontFamily: 'Opensans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Repeat Password',
              hintStyle: TextStyle( color: Colors.white, fontFamily: 'Opensans'),
              
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Email',
            style: TextStyle(fontFamily: 'Opensans', color: Colors.white)),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration( borderRadius: BorderRadius.circular(30.0), boxShadow: [
            BoxShadow(
              
              color: Colors.grey.shade400.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0,7),
              

            )
          ]),
          height: 60.0,
          child: const TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildforgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        style: TextButton.styleFrom(padding: EdgeInsets.only(right: 0.0)),
        child: Text(
          'Forgot Password?',
          style: TextStyle(color: Colors.blue.shade900),
        ),
      ),
    );
  }

  Widget _cancelSignUp() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: TextButton.styleFrom(padding: EdgeInsets.only(right: 0.0)),
        child: Text(
          "Get back to the Login!",
          style: TextStyle(color: Colors.blue.shade900),
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    final ButtonStyle _eBtnStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      elevation: 5.0,
      textStyle: const TextStyle(fontSize: 20, color: Colors.white),
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        child: const Text(
          'Create Account',
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Opensans'),
        ),
        style: _eBtnStyle,
        onPressed: () => print('Login Button Pressed'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        onTap: (){
          Focus.of(context).unfocus();
        },
        child: Stack(
          children: <Widget>[
            Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    // Color(0xFF1B262C),
                    // Color(0xFF0F4C75),
                    // Color(0xFF00B7C2),
                    // Color(0xFFF79B4B7),

                    Color(0xFF73AEF5),
                    Color(0xFF61A4F1),
                    Color(0xFF478DE0),
                    Color(0xFF398AE5),
                  ],
                  stops: [0.1, 0.4, 0.7, 0.9],
                ))),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 40.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Opensans',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    _buildEmail(),
                    const SizedBox(height: 30.0),
                    _buildPassword(),
                    _buildLoginBtn(),
                    _cancelSignUp(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
