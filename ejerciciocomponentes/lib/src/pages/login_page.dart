import 'dart:convert';
import 'dart:io';
import 'package:ejerciciocomponentes/src/services/alumno_service.dart';
import 'package:ejerciciocomponentes/src/services/storage_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
bool _rememberMe = false;
final _formValidatorKey = GlobalKey<FormState>();
var emailController = TextEditingController();
var passController = TextEditingController();
Future<void> login() async {
  if (passController.text.isNotEmpty && emailController.text.isNotEmpty) {   
    var response = await http.post(Uri.parse('http://10.0.2.2:5000/api/Alumno/Login_Alumno'),
    headers:{
       HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.acceptHeader: 'application/json',
    } ,
        body: jsonEncode (<String,String>{
          'email': emailController.text,
          'password': passController.text
        }));
    if (response.statusCode == 200) {
      StorageService().add("authorization",response.headers['authorization'].toString());
      dotenv.env['ID_ALUMNO']=response.body.toString();
      AlumnoService().cargarAlumnoPorId().then((value) => {
      dotenv.env['ID_CICLO']= value.idCiclo.toString(),
      if (value.emailVerificado) {
         Navigator.pushNamedAndRemoveUntil(context, '/',(Route<dynamic> route)=> false,)
      }
      else if(!value.emailVerificado){
      AlumnoService().generarCodigo(value.email),
      Navigator.pushNamedAndRemoveUntil(context, 'emailVerify',(Route<dynamic> route)=> false,arguments: value.email)   
      }
      });    
    }
    else {
      
      ScaffoldMessenger.of (context)
          .showSnackBar(SnackBar(content: Text("Credenciales inválidas.")));
    }
   } else {
    ScaffoldMessenger.of (context)
        .showSnackBar (SnackBar(content: Text("No se permiten campos en blanco.")));

   }
   }
   

  Widget _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(fontFamily: 'Opensans', color: Colors.white),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 7),
                )
              ]),
          height: 60.0,
          child: TextFormField(
             validator: (value){
              if ( value==null || value.isEmpty ) {
                return "Campo obligatorio";
              }
              return null;
            },
            controller: passController,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            decoration: const InputDecoration(
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
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 7),
                )
              ]),
          height: 60.0,
          child:  TextFormField(
             validator: (value){
              if ( value==null || value.isEmpty ) {
                return "Campo obligatorio";
              }
               if (!EmailValidator.validate(value)) {
                 return "Formato de email incorrecto";
               }
              return null;
            },
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white, fontFamily: 'Opensans'),
            decoration: const InputDecoration(
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
        onPressed: () => Navigator.pushNamed(context, 'passreco'),
        style: TextButton.styleFrom(padding: EdgeInsets.only(right: 0.0)),
        child: Text(
          'Forgot Password?',
          style: TextStyle(color: Colors.blue.shade900),
        ),
      ),
    );
  }

  Widget _buildSignUp() {
    return Container(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, 'signup'),
        style: TextButton.styleFrom(padding: EdgeInsets.only(right: 0.0)),
        child: Text(
          "Don't have an account yet? Sign up",
          style: TextStyle(color: Colors.blue.shade900),
        ),
      ),
    );
  }

  Widget _buildRememberMeChckBox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
              data: ThemeData(unselectedWidgetColor: Colors.white),
              child: Checkbox(
                value: _rememberMe,
                checkColor: Colors.green,
                activeColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    _rememberMe = value!;
                  });
                },
              )),
          const Text(
            'Remember me',
            style: TextStyle(color: Colors.white),
          ),
        ],
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
          'Login',
          style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Opensans'),
        ),
        style: _eBtnStyle,
        onPressed:  () {
          
          if (_formValidatorKey.currentState!.validate()) {        
          login();
          }
          
          }
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: const <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Sign in with',
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
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
                child: Form(
                  key:_formValidatorKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Sign in',
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
                      _buildforgotPasswordBtn(),
                      _buildRememberMeChckBox(),
                      _buildLoginBtn(),
                      _buildSignUp(),
                      _buildSignInWithText(),
                      GestureDetector(
                        onTap: () => print('Login with Google'),
                        child: Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0, 2),
                                blurRadius: 6.0,
                              ),
                            ],
                            image: DecorationImage(
                                image: AssetImage('web/icons/google.png')),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
