import 'package:flutter/material.dart';
import 'package:todo_app/data/todo_service.dart';
import 'package:todo_app/model/todo.dart';

class TodoPage extends StatefulWidget {
  TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TodoService todoService = TodoService.instance;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController posController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
          title: Text('Yeni Todo'),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                        hintText: 'Başlık',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: descController,
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: 'Açıklama',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: posController,
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: 'Konum',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ))),
              ),
              TextButton(
                  onPressed: () {
                    todoService
                        .addTodo(Todo(
                            id: null,
                            title: titleController.text,
                            description: descController.text,
                            isdone: false,
                            pos: posController.text))
                        .then((value) {
                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    'Kaydet',
                    style: TextStyle(fontSize: 25),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
