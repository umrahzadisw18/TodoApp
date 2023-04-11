class ToDo{
  String? id;
  String? todoText;
  late bool isDone;
  ToDo({
    required this.id,
    required this.todoText,
    this.isDone=false,


  });
  static  List<ToDo> todoList(){
    return[
      ToDo(id: '01', todoText: 'Morning exercise ',isDone: true),
      ToDo(id: '02', todoText: 'Morning prayer ',isDone: true),
      ToDo(id: '03', todoText: 'Check Emails '),
      ToDo(id: '04', todoText: 'Team Meeting'),
    ];

  }
}