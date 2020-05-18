import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:simple_code/simple_code.dart';
import 'package:todo_mobile/app/models/TaskModel.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "TODO LIST"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller
  _getData() {
    return controller.tasks.value;
  }

  @override
  Widget build(BuildContext context) {
    _showDialog() {
      TaskModel taskModel = new TaskModel();
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text("New Task"),
              content: Container(
                height: hsz(100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      onChanged: (value) => taskModel.title = value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter the title",
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    TextFormField(
                      onChanged: (value) => taskModel.description = value,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter the description",
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      SimpleNavigator.pop();
                    },
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.red,
                    )),
                Spacer(
                  flex: 1,
                ),
                IconButton(
                    onPressed: () {
                      controller.postTask(taskModel);
                      SimpleNavigator.pop();
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.green,
                    )),
              ],
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Observer(builder: (BuildContext context) {
        if (controller.tasks.error != null) {
          return Center(child: Text('NO CONNECTION'));
        } else if (controller.tasks.value == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List<TaskModel> list = _getData();
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(Duration(milliseconds: 1000));
              SimpleNavigator.pushReplacementNamed('/');
            },
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(list[index].title),
                  subtitle: Text(list[index].description),
                  leading: Checkbox(
                    value: list[index].complete,
                    onChanged: (change) {
                      setState(() {
                        list[index].complete = change;
                      });
                      controller.updateTask(list[index]);
                    },
                    activeColor: Colors.green,
                  ),
                  trailing: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        controller.deleteTask(list[index]);
                        setState(() {
                          list.removeAt(index);
                        });
                      }),
                );
              },
            ),
          );
        }
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
