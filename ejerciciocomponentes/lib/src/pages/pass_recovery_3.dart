import 'package:ejerciciocomponentes/src/services/alumno_service.dart';
import 'package:flutter/material.dart';

class PassRecoveryPage3 extends StatefulWidget {
  PassRecoveryPage3({Key? key}) : super(key: key);

  @override
  State<PassRecoveryPage3> createState() => _PassRecoveryPage3State();
}

class _PassRecoveryPage3State extends State<PassRecoveryPage3> {
  var _passController = TextEditingController();
  var _repeatPassController = TextEditingController();
   final ButtonStyle _eBtnStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.all(15.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    elevation: 5.0,
    textStyle: const TextStyle(fontSize: 20, color: Colors.white),
  );
  @override
  Widget build(BuildContext context) {
    String email=ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: GestureDetector(
       onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children:[ Container(
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
            )),
              child: Column(
          children: [
              SizedBox(
                  height: 70,
                ),
                const Text(
                  'Cambio de contraseña',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 80,
                ),
              Container(
                 margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 7),
                        )
                      ]),
                child: TextFormField(
                  enabled: true,
                  validator: (value) {
                    if (_passController.value.text.isEmpty) {
                      return "Campo obligatorio";
                    }
                  },
                  controller: _passController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white, fontFamily: 'Opensans'),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    hintText: 'Introduzca la contraseña',
                    hintStyle: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
               Container(
                 margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 7),
                        )
                      ]),
                child: TextFormField(
                  enabled: true,
                  validator: (value) {
                    if (_repeatPassController.value.text.isEmpty) {
                      return "Campo obligatorio";
                    }
                    if (_repeatPassController!=_passController) {
                      return "Las contraseñas no son iguales";
                    }
                  },
                  controller: _repeatPassController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white, fontFamily: 'Opensans'),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14.0),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    hintText: 'Repita la contraseña',
                    hintStyle: TextStyle(color: Colors.white, fontFamily: 'Opensans'),
                  ),
                ),
              ),
        Container(
           margin: const EdgeInsets.only(left: 20, right: 20),
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  width: double.infinity,
                  child: ElevatedButton(
                      child: const Text(
                        'Cambiar contraseña',
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Opensans'),
                      ),
                      style: _eBtnStyle,
                      onPressed: () {
                        if (_passController.value.text.isNotEmpty && _repeatPassController.value.text.isNotEmpty && _passController.value.text==_repeatPassController.value.text) {
                          AlumnoService().cambiarPassword(_passController.value.text, email).then((value)=> {
                            if (value) {
                           Navigator.pushNamedAndRemoveUntil(context,"login",(Route<dynamic> route)=> false,),                      
                               ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("El cambio de contraseña se ha realizado correctamente.")))
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("El cambio de contraseña no se ha realizado correctamente")))
                            }
                          });          
                        } else if (_passController.value.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Introduce la contraseña.")));
                        }
                        else if(_repeatPassController.value.text.isEmpty){
                         ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Repite la contraseña.")));
                        }
                        else if(_repeatPassController.value.text!=_passController.value.text){
         ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Las contraseñas no coinciden")));
                        }
                      }),
                ),
          ],
            ),
            ),
          ]
        ),
      ),
    );
  }
}