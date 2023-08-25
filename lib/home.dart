import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_todo_app/todo.dart';
import 'package:flutter_todo_app/todo_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todoList = Todo.todoList();
  List<Todo> filteredList = [];
  final _todoController = TextEditingController();

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleDeletTodoItem(String id) {
    setState(() {
      todoList.removeWhere((element) => element.id == id);
    });
  }

  void _addTodoItem(String toDo) {
    setState(() {
      todoList.add(Todo(
          id: DateTime.timestamp().millisecondsSinceEpoch.toString(),
          todoText: toDo));

      //clear text field
      _todoController.clear();
    });
  }

  void _onFilteringList(String filterKey) {
    List<Todo> result = [];

    if (filterKey.isEmpty) {
      result = todoList;
    } else {
      result = todoList
          .where(
            (element) => element.todoText!.toLowerCase().contains(filterKey),
          )
          .toList();
    }

    setState(() {
      filteredList = result;
    });
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: Colors.grey.shade300,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            ),
            Container(
              height: 40,
              width: 40,
              child: const ClipRRect(
                child: Icon(
                  Icons.account_circle,
                  color: Colors.black,
                  size: 35,
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildSearchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _onFilteringList(value),
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }

  Widget _buildTodoList() {
    return Expanded(
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: 50,
              bottom: 20,
            ),
            child: const Text(
              'My ToDo list',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          for (Todo todoo in filteredList)
            TodoItem(
              todo: todoo,
              onTodoChanged: _handleTodoChange,
              onDeleteItem: _handleDeletTodoItem,
            )
        ],
      ),
    );
  }

  @override
  void initState() {
    filteredList = todoList;
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                _buildSearchBox(),
                _buildTodoList(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10,
                            spreadRadius: 0.0),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController, // ???
                      decoration: const InputDecoration(
                        hintText: 'Add new todo item',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: Size(60, 60),
                        elevation: 10),
                    onPressed: () {
                      _addTodoItem(_todoController.text);
                    },
                    child: const Text(
                      '+',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
