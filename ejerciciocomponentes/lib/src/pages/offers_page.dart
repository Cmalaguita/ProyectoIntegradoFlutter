import 'package:ejerciciocomponentes/navigation_drawer/navigation_drawer.dart';
import 'package:ejerciciocomponentes/src/models/inscripcion.dart';
import 'package:ejerciciocomponentes/src/models/posicion.dart';
import 'package:ejerciciocomponentes/src/services/inscripcion_service.dart';
import 'package:ejerciciocomponentes/src/services/posicion_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class OffersPage extends StatefulWidget {
  OffersPage({Key? key}) : super(key: key);

  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  final _height = 565.0;
  final _controller = ScrollController();
  TextEditingController textController = TextEditingController();

  List<Posicion> listaPos = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: navigationDrawer(),
        appBar: AppBar(
          title: Text('Posiciones de trabajo'),
        ),
        body: Stack(children: [
          posiciones(),
        ]
//Drawer de navegacion
            ));
  }

// metodo que arrastra el controlador de scroll a la posicion determinada por altura * el indice del array en el que se encuentra la posicion.
  _animateToIndex(i) => _controller.animateTo(_height * i,
      duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);

  Widget _buildFloatingSearchBar(List<Posicion> listaDePosiciones) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        setState(() {
          textController.text = query;
        });
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {
              textController.clear();
            },
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        List<Widget> listWidPos = [];

        for (var p in listaDePosiciones.where((element) =>
            element.nombre
                .toLowerCase()
                .contains(textController.text.toLowerCase()) ||
            element.descripcion
                .toLowerCase()
                .contains(textController.text.toLowerCase()))) {
          listWidPos.add(ListTile(
            title: Text(p.nombre),
            subtitle: Text(p.empresa.nombre),
            trailing: IconButton(
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              onPressed: () {
                int index = 0;
                index = listaDePosiciones
                    .indexWhere((note) => note.nombre.contains(p.nombre));
                _animateToIndex(index);
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
          ));
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              children: listWidPos,
            ),
          ),
        );
      },
    );
  }

  posiciones() {
    return FutureBuilder(
        future: PosicionService().cargarTodasLasPosiciones(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            String alumnoid =
                dotenv.env['ID_ALUMNO'] ?? "No se encuentra id de usuario";
            List<Posicion> listaPosiciones = [];
            List<Widget> listwid = [
              Container(
                color: Colors.blue[300],
                height: 50,
              )
            ];
            if (snapshot.data is List<Posicion>) {
              listaPosiciones = snapshot.data;

              for (Posicion p in listaPosiciones) {
                List<Widget> listwidciclos = [];
                for (var c in p.ciclos) {
                  listwidciclos.add(Chip(
                    avatar: const Icon(Icons.auto_stories_outlined),
                    label: Text(
                      c.nombre,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 11,
                          color: Colors.black),
                    ),
                  ));
                }
                listwid.add(
                  Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.blue[300],
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
                        title: Text(
                          p.nombre,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                        ),
                        subtitle: Column(
                          textDirection: TextDirection.ltr,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.empresa.nombre,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6),
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              height: 165,
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Descripcion:' + p.descripcion,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                ),
                              ),
                            ),
                            Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                  Container(
                                    child: Text(
                                      'Salario: ' +
                                          p.remuneracion.toString() +
                                          '€',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'Horario: ' + p.horario,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'Finaliza: ' +
                                          p.fechaFin
                                              .toIso8601String()
                                              .substring(0, 10),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ])),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                shape: BoxShape.rectangle,
                                color: Colors.blueAccent,
                              ),
                              child: ListView(
                                children: listwidciclos,
                              ),
                              height: 100,
                            ),
                            Container(
                              height: 80,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                shape: BoxShape.rectangle,
                                color: Colors.blue[300],
                                image: const DecorationImage(
                                  image: AssetImage('web/bgs/posicion.png'),
                                ),
                              ),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.start,
                              children: [
                                FutureBuilder(
                                    future: InscripcionService()
                                        .comprobarInscripcion(
                                            dotenv.env['ID_ALUMNO'] ??
                                                "No se encuentra id de usuario",
                                            p.id.toString()),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data != "-1") {
                                          return OutlinedButton(
                                            onPressed: () {
                                              InscripcionService()
                                                  .borrarInscripcion(
                                                      snapshot.data.toString())
                                                  .then((_) {
                                                setState(() {

                                                });
                                              });
                                            },
                                            child: const Text('Borrar Inscripción'),
                                          );
                                        } else {
                                          return OutlinedButton(
                                            onPressed: () {
                                              InscripcionService()
                                                  .crearInscripcion(Inscripcion(
                                                      int.parse(alumnoid),
                                                      p.empresaId,
                                                      p.id,
                                                      'Pendiente',
                                                      DateTime.now())) .then((_) {
                                                setState(() {

                                                });
                                              });
                                            },
                                            child: const Text('Inscribirse'),
                                          );
                                        }
                                      } else {
                                                    return const CircularProgressIndicator();
                                      }
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return Stack(children: [
                ListView(
                  controller: _controller,
                  children: listwid,
                ),
                _buildFloatingSearchBar(listaPosiciones),
              ]);
            } else {
              return const Text(
                  "Se ha producido un error al cargar las posiciones");
            }
          } else if (snapshot.hasError) {
            return const Text(
                "Se ha producido un error al cargar las posiciones, el servicio no se ha devuelto datos");
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
