// Import MaterialApp and other widgets which we can use to quickly create a material app
import 'package:flutter/material.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Todo List',
        home: new TodoList()
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoListState extends State<TodoList> {
  List<String> _todoItems = [];

  // This will be called each time the + button is pressed
  void _addTodoItem(String task) {
    // Only add the task if the user actually entered something
    if(task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }

  // Build the whole list of todo items
  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        // itemBuilder will be automatically be called as many times as it takes for the
        // list to fill up its available space, which is most likely more than the
        // number of todo items we have. So, we need to check the index is OK.
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index]);
        }
      },
    );
  }

  // Build a single todo item
  Widget _buildTodoItem(String todoText) {
    return new ListTile(
        title: new Text(todoText)
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text('Todo List')
      ),
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _pushAddTodoScreen, // pressing this button now opens the new screen
          tooltip: 'Add task',
          child: new Icon(Icons.add)
      ),
    );
  }
  void _pushAddTodoScreen() {
    // Push this page onto the stack
    Navigator.of(context).push(
      // MaterialPageRoute will automatically animate the screen entry, as well
      // as adding a back button to close it
        new MaterialPageRoute(
            builder: (context) {
              return new Scaffold(
                  appBar: new AppBar(
                      title: new Text('Add a new task')
                  ),
                  body: new TextField(
                    autofocus: true,
                    onSubmitted: (val) {
                      _addTodoItem(val);
                      Navigator.pop(context); // Close the add todo screen
                    },
                    decoration: new InputDecoration(
                        hintText: 'Enter something to do...',
                        contentPadding: const EdgeInsets.all(16.0)
                    ),
                  )
              );
            }
        )
    );
  }
}