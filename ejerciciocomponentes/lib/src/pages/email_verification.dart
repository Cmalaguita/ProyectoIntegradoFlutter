import 'package:ejerciciocomponentes/src/services/alumno_service.dart';
import 'package:flutter/material.dart';

class EmailVerificationPage extends StatefulWidget {
  EmailVerificationPage({Key? key}) : super(key: key);
  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}
class _EmailVerificationPageState extends State<EmailVerificationPage> {
   var _codeController = TextEditingController();
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
      child: Container(
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
          children: <Widget>[
            SizedBox(
              height: 70,
            ),
            const Text(
              'Verificación de email',
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
                  if (_codeController.value.text.isEmpty) {
                    return "Campo obligatorio";
                  }                
                },
                controller: _codeController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Opensans'),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.cable_outlined,
                    color: Colors.white,
                  ),
                  hintText: 'Introduzca Código',
                  hintStyle:
                      TextStyle(color: Colors.white, fontFamily: 'Opensans'),
                ),
              ),
            ),
            Container(
               margin: const EdgeInsets.only(left: 20, right: 20),
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              width: double.infinity,
              child: ElevatedButton(
                  child: const Text(
                    'Verificar email',
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Opensans'),
                  ),
                  style: _eBtnStyle,
                  onPressed: () {
                    if (_codeController.value.text.isNotEmpty ) {
                                AlumnoService().comprobarCodigoVerificacionEmail(_codeController.value.text.toString(), email).then((value) =>{
                                  if (value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("La verificación de email se ha realizado correctamente."))),
      Navigator.pushNamedAndRemoveUntil(context, 'login',(Route<dynamic> route)=> false,)  
                                  }else if (!value){
 ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("FALSE"))),
                                  }
                                });
                    } else if (_codeController.value.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Introduce el codigo")));
                    }
                  }),
            ),
          ],
        ),
      ),
    ),
    );
  }
}