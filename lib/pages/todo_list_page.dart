import 'package:flutter/material.dart';
import 'package:todo_app/data/todo_service.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/pages/todo_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  Position? currentPosition;

  TodoService service = TodoService.instance;

  List<Todo> todos = [];
  List<Todo> doneTodos = [];

  @override
  void initState() {
    _getCurrentLocation();
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TodoPage()))
                .then((value) => loadData());
          },
          child: Icon(Icons.add),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          shape: Border(bottom: BorderSide(color: Colors.orange, width: 4)),
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          title: Text('Anasayfa'),
          bottom: TabBar(
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50), // Creates border
                color: Colors.orange),
            onTap: (value) {
              print(todos);
            },
            tabs: [
              Icon(Icons.check_box_outline_blank),
              Icon(Icons.check),
              Icon(Icons.home),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            getTodoList(todos),
            getTodoList(doneTodos),
            NewWidget(),
          ],
        ),
      ),
    );
  }

  Widget getTodoList(List<Todo> todos) {
    return todos.length == 0
        ? Center(child: Text('Todo Yok.'))
        : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.grey,
                child: ListTile(
                  trailing: Checkbox(
                      value: todos[index].isdone,
                      onChanged: (value) {
                        setState(() {
                          todos[index].isdone = value!;
                          service
                              .updateIsDone(todos[index])
                              .then((value) => loadData());
                        });
                      }),
                  title: Text(
                    todos[index].title,
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(
                    todos[index].description,

                    ///descriptinon.substrnig(5) +'...',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              );
            },
          );
  }

  loadData() {
    service.getTodos(true).then((value) {
      setState(() {
        todos = value;
      });
    });
    service.getTodos(false).then((value) {
      setState(() {
        doneTodos = value;
      });
    });
  }

  NewWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: (currentPosition != null)
              ? Text(
                  "LAT: ${currentPosition!.latitude}, LNG: ${currentPosition!.longitude}")
              : Text('konum yok'),
        ),
        TextButton(
            onPressed: () async {
              List<Placemark> placemarks = await placemarkFromCoordinates(
                  currentPosition!.latitude, currentPosition!.longitude);
              setState(() {
                _getCurrentLocation();
              });
            },
            child: Text('Konum'))
      ],
    );
  }

  void _getCurrentLocation() async {
    //LocationPermission permission = await Geolocator.requestPermission();

    print(currentPosition);
    await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
    ).then((Position position) {
      setState(() {
        currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<List<Placemark>> placemarkFromCoordinates(
    double latitude,
    double longitude, {
    String? localeIdentifier,
  }) =>
      GeocodingPlatform.instance.placemarkFromCoordinates(
        latitude,
        longitude,
        localeIdentifier: localeIdentifier,
      );
}
