import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/widgets/todo_items.dart';

class Home extends StatefulWidget {
    Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList=ToDo.todoList();
  List<ToDo> _foundToDo=[];
  final _todoController= TextEditingController();

  @override
  void initState() {
    _foundToDo=todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:   Color.fromARGB(255, 242, 238, 238) ,
      appBar: _buildAppbar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 20,
                           bottom: 20),
                        child:   Text('ToDo App', style: TextStyle(
                          fontSize: 30,fontWeight: FontWeight.w500,
                          ),
                          ),
                      ),
                      for(ToDo toDo in _foundToDo.reversed
                      )
                            ToDoItem(todo: toDo,
                            onToDoChange: _handleToDoChange,
                            onDeleteItem: _deleteToDoItem,
                            ),
                    ],
                  ),
                )
              ],
            )
          ),
          Align( alignment: Alignment.bottomCenter,
          child: Row(children: [
            Expanded(child: Container(margin: EdgeInsets.only(
              bottom: 20,
             right: 20,
             left: 20),
             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
             // ignore: prefer_const_constructors
             decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [ BoxShadow(color:Colors.grey,offset: Offset(0.0,0.0),
              blurRadius: 10.0,
              spreadRadius: 0.0,
              )],
              borderRadius: BorderRadius.circular(10),
             ),
             child:  TextField(
              controller: _todoController,
              decoration:  InputDecoration(
                hintText: 'Add a new todo item',
                border: InputBorder.none,
              ),
             ),
            ),
            ),
            Container(
              margin:  EdgeInsets.only(bottom: 20, right: 20) ,
              child: ElevatedButton(
                child: Text('+', style:  TextStyle(fontSize: 40),),
                onPressed: () {
                  _addToDoItem(_todoController.text);
                },
                style: ElevatedButton.styleFrom(
                  // onPrimary: Color(Colors.blue),
                  minimumSize: Size(60, 60),
                  elevation: 10,
                ),
              ),
            )],
          ),)
        ],
      )
      );
  }
   void _handleToDoChange(ToDo toDo){
    setState(() {
      toDo.isDone=!toDo.isDone;
    });
   }
   void _deleteToDoItem(String id){
    setState(() {
       todosList.removeWhere((item) => item.id==id);
    });
   }
   void _addToDoItem(String todo){
    setState(() {
        todosList.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(), 
          todoText: todo));
    });
    _todoController.clear();    
   }
   void _runFilter(String enterKeyword){
    List<ToDo> results=[];
    if(enterKeyword.isEmpty){
      results=todosList;
    }else{
      results=todosList
      .where((item) => item.todoText!.toLowerCase()
      .contains(enterKeyword.toLowerCase()))
      .toList();
    }
    setState(() {
      _foundToDo=results;
    });
   }

  Widget searchBox() {
    return Container(
            padding:   EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child:  TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(Icons.search,size: 20,
                ),
                    prefixIconConstraints: BoxConstraints(
                     maxHeight: 20,
                     maxWidth: 20,
                    ),
                    hintText: 'Search',
              ),
            ),
          );
  }

  AppBar _buildAppbar() {
    return AppBar(
      elevation: 0,
      backgroundColor:  Color.fromARGB(255, 242, 238, 238),
      title:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Icon(Icons.menu,
        color: Color.fromARGB(255, 76, 74, 74),
          size: 30),
          SizedBox(
             height: 40,
             width: 40,
             child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:  Icon(Icons.person),
             ),
          ),
      ],
      ),
    );
  }
}