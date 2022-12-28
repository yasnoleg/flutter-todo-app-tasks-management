import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo/data_base/databasehive.dart';

class TodoForTask extends StatefulWidget {
  DataBase database;
  int Index;
  VoidCallback onSwitch;
  TextEditingController TodoContent;
  VoidCallback onAddTodoLine;
  TodoForTask({super.key,
  required this.database,
  required this.Index,
  required this.onSwitch,
  required this.TodoContent,
  required this.onAddTodoLine,
  });

  @override
  State<TodoForTask> createState() => _TodoForTaskState();
}

class _TodoForTaskState extends State<TodoForTask> {

  //COLORS
  HexColor buttoncolor = HexColor('#8280FF');
  HexColor tasksredcolor = HexColor('#FF7285');
  HexColor tasksyelcolor = HexColor('#FFCA83');
  HexColor tasksgrecolor = HexColor('#4AD991');
  HexColor iconcolor = HexColor('#B4B4C6');
  HexColor morningcolor = HexColor('#ffe9a6');
  Color backgroundcolor = Colors.black;
  Color backgroundcolor2 = Colors.white;
  Color h1 = Colors.white;
  Color per = Colors.grey;
  Color inactivtasks = Colors.grey.shade400;

  String mam = 'oky';

  double listsize = 0;
  double containersize = 130;

  bool isTapped = false;

  List TodoList = [];

  //Count Size
  CountSize(){
    if(TodoList.length == 0){
      setState(() {
        listsize = 0;
      });
    }else{
      setState(() {
        listsize = TodoList.length*55;
      });
    }
  }

  //Count Container Size
  CountContainerSize(){
    if(TodoList.length == 0){
      setState(() {
        containersize = 130;
      });
    }else{
      setState(() {
        containersize = 130 + listsize;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    
    setState(() {
      isTapped = widget.database.taskinfos[widget.Index][7];
      TodoList = widget.database.taskinfos[widget.Index][9];
    });
    CountSize();
    CountContainerSize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
            child: Container(
              height: isTapped ? containersize : 60,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print(widget.database.taskinfos[widget.Index][9].length);
                            print(widget.database.taskinfos[widget.Index][9]);
                          },
                          child: Text('Able Todo List Only For This Task ',style: TextStyle(fontSize: 20,fontFamily: 'h2',fontWeight: FontWeight.w500,color: h1),)),
                        Expanded(
                          child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(
                                        () {
                                          widget.onSwitch();
                                          isTapped = !isTapped;
                                          HapticFeedback.lightImpact();
                                        },
                                      );
                                      
                                    },
                                    child: FlutterSwitch(
                                      width: 50,
                                      height: 20.0,
                                      toggleSize: 20.0,
                                      value: isTapped,
                                      activeToggleColor: h1,
                                      inactiveToggleColor: buttoncolor,
                                      activeColor: buttoncolor,
                                      inactiveColor: buttoncolor.withAlpha(90),
                                      onToggle: (val) {
                                        setState(() {
                                          isTapped = val;
                                          widget.onSwitch();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ),
                      ],
                    ),
                    isTapped == true ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5,top: 10,right: 15,bottom: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: TextField(
                              controller: widget.TodoContent,
                              decoration: InputDecoration(
                                hintText: 'Add Todo List ',
                                fillColor: const Color.fromARGB(92, 158, 158, 158),
                                filled: true,
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    widget.onAddTodoLine();
                                    setState(() {
                                      TodoList = widget.database.taskinfos[widget.Index][9];
                                    });
                                    CountSize();
                                    CountContainerSize();
                                    widget.TodoContent.clear();
                                  },
                                  child: const Icon(Icons.add)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: listsize,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                            itemCount: TodoList.length,
                            itemBuilder: ((context, index) {
                              return Dismissible(
                                key: ValueKey(TodoList[index]),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Colors.transparent,
                                  child: Icon(Icons.remove_circle_outline,color: tasksredcolor,
                                  ),
                                ),
                                onDismissed: (direction) {
                                  setState(() {
                                    TodoList.removeAt(index);
                                    widget.database.taskinfos[widget.Index][9] = TodoList;
                                  });
                                  widget.database.UpdateData();
                                },
                                child: CheckboxListTile(
                                  title: Text('${TodoList[index][0]}',style: TextStyle(decoration:TodoList[index][1] == true ? TextDecoration.lineThrough : TextDecoration.none),),
                                  secondary: Icon(Icons.task),
                                  value: TodoList[index][1], 
                                  selected: TodoList[index][1],
                                  checkColor: h1,
                                  activeColor: buttoncolor,
                                  onChanged: ((value) {
                                    setState(() {
                                      TodoList[index][1] = value!;
                                      widget.database.taskinfos[widget.Index][9][index] = TodoList[index];
                                    });
                                    widget.database.UpdateData();
                                  })
                                ),
                              );
                            })
                          ),
                        ),
                      ],
                    ) : Container(),
                  ],
                ),
              ),
            ),
          ),
        ],
    );
  }
}