import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:todo/data_base/databasehive.dart';

class EditTasksPage extends StatefulWidget {
  final Title;
  final Notes;
  TextEditingController StartTime;
  TextEditingController StartHour;
  TextEditingController EndTime;
  TextEditingController DateOfTask;
  TextEditingController Repeat;
  TextEditingController ColorSelect;
  VoidCallback onEditTask;
  TextEditingController IconSelect;
  String readtitle;
  String readnotes;
  String readstart_time;
  String readend_time;
  String readdate;
  String readiconlink;
  TextEditingController IndexColor;
  String readiconlindex;
  int Index;

  EditTasksPage({super.key,
  required this.Title,
  required this.Notes,
  required this.StartTime,
  required this.StartHour,
  required this.EndTime,
  required this.DateOfTask,
  required this.Repeat,
  required this.ColorSelect,
  required this.onEditTask,
  required this.IconSelect,
  required this.readtitle,
  required this.readnotes,
  required this.readstart_time,
  required this.readend_time,
  required this.readdate,
  required this.readiconlink,
  required this.IndexColor,
  required this.readiconlindex,
  required this.Index,
  });

  @override
  State<EditTasksPage> createState() => _EditTasksPageState();
}

class _EditTasksPageState extends State<EditTasksPage> {

  //Add DataBase
  DataBase db2 = DataBase();

  //Vars
  String colorselect = '#FF7285';
  int indexcolor = 0;
  String _selectedrepeat = 'None';
  String icon = 'https://cdn-icons-png.flaticon.com/512/984/984196.png';

  //Controllers
  final _titlecont = TextEditingController();
  final _notescont = TextEditingController();

  //Key
  final GlobalKey<FormState> _fromkey = GlobalKey<FormState>();

  //COLORS
  HexColor buttoncolor = HexColor('#8280FF');
  HexColor tasksredcolor = HexColor('#FF7285');
  HexColor tasksyelcolor = HexColor('#FFCA83');
  HexColor tasksgrecolor = HexColor('#4AD991');
  HexColor iconcolor = HexColor('#B4B4C6');
  HexColor taskspinkcolor = HexColor('#FFB9B9');
  HexColor tasksdarkcolor = HexColor('#404258');
  HexColor tasksbluecolor = HexColor('#81C6E8');
  Color backgroundcolor = Colors.black;
  Color backgroundcolor2 = Colors.white;
  Color h1 = Colors.white;
  Color per = Colors.grey;
  Color inactivtasks = Colors.grey.shade400;

  //time 
  DateTime current_date = DateTime.now();
  TimeOfDay start_time = TimeOfDay.now();
  TimeOfDay end_time = TimeOfDay.now();
  DateTime _timedate = DateTime.now();

  //Lists
  List<String> repeat = [
    'None',
    'Daily',
    'Weekly'
  ];

  DataBase db = DataBase();

  @override
  void initState() {
    // TODO: implement initState
    widget.Title.text = widget.readtitle;
    widget.Notes.text = widget.readnotes;
    widget.StartTime.text = widget.readstart_time;
    widget.EndTime.text = widget.readend_time;
    widget.DateOfTask.text = widget.readdate;
    icon = widget.readiconlink;
    widget.IconSelect.text = icon;

    //initialisation of controllers 


    if(db.bx.get("todo") == null) {
      db.InitData();
    }else{
      db.LoadData();
    }

    
    indexcolor = int.parse(db.taskinfos[widget.Index][12].toString());
    widget.IndexColor.text = db.taskinfos[widget.Index][12];
    widget.ColorSelect.text = db.taskinfos[widget.Index][6];
    widget.StartHour.text = db.taskinfos[widget.Index][8];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> circularofcolors = [
      //lightred
      GestureDetector(
        onTap: () {
          setState(() {
            widget.ColorSelect.text = '#FF7285';
            widget.IndexColor.text = '0';
            indexcolor = 0;
          });
        },
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color: tasksredcolor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: indexcolor == 0 ? Icon(Icons.done,color: h1,) : Container(),
        ),
      ),
      //light yel
      GestureDetector(
        onTap: () {
          setState(() {
            widget.ColorSelect.text = '#FFCA83';
            widget.IndexColor.text = '1';
            indexcolor = 1;
          });
        },
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color: tasksyelcolor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: indexcolor == 1 ? Icon(Icons.done,color: h1,) : Container(),
        ),
      ),
      //light gre
      GestureDetector(
        onTap: () {
          setState(() {
            widget.ColorSelect.text = '#4AD991';
            widget.IndexColor.text = '2';
            indexcolor = 2;
          });
        },
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color: tasksgrecolor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: indexcolor == 2 ? Icon(Icons.done,color: h1,) : Container(),
        ),
      ),
      //light pink
      GestureDetector(
        onTap: () {
          setState(() {
            widget.ColorSelect.text = '#FFB9B9';
            widget.IndexColor.text = '3';
            indexcolor = 3;
          });
        },
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color: taskspinkcolor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: indexcolor == 3 ? Icon(Icons.done,color: h1,) : Container(),
        ),
      ),
      //dark color
      GestureDetector(
        onTap: () {
          setState(() {
            widget.ColorSelect.text = '#404258';
            widget.IndexColor.text = '4';
            indexcolor = 4;
          });
        },
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color: tasksdarkcolor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: indexcolor == 4 ? Icon(Icons.done,color: h1,) : Container(),
        ),
      ),
      //light blue
      GestureDetector(
        onTap: () {
          setState(() {
            widget.ColorSelect.text = '#81C6E8';
            widget.IndexColor.text = '5';
            indexcolor = 5;
          });
        },
        child: Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color: tasksbluecolor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: indexcolor == 5 ? Icon(Icons.done,color: h1,) : Container(),
        ),
      ),
    ];
    return SingleChildScrollView(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Form(
              key: _fromkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //TITLE
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15,top: 20,right: 15,bottom: 0),
                            child: Text('Icon',style: TextStyle(color: h1,fontFamily: 'h1',fontWeight: FontWeight.w600,fontSize: 20),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15,top: 10,right: 15,bottom: 15),
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context, 
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    )
                                  ),
                                    builder: ((context) {
                                      return Container(
                                        height: 160,
                                        decoration: BoxDecoration(
                                          
                                        ),
                                        child: SizedBox(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 10,top: 10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          widget.IconSelect.text = 'https://cdn-icons-png.flaticon.com/512/984/984196.png'; 
                                                          icon = 'https://cdn-icons-png.flaticon.com/512/984/984196.png';
                                                          Navigator.of(context).pop();
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: iconcolor,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.network('https://cdn-icons-png.flaticon.com/512/984/984196.png',color: tasksredcolor,height: 40,width: 40,),
                                                          ],
                                                        ),                                          
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          widget.IconSelect.text = 'https://cdn-icons-png.flaticon.com/512/833/833314.png'; 
                                                          icon = 'https://cdn-icons-png.flaticon.com/512/833/833314.png';
                                                          Navigator.of(context).pop();
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: iconcolor,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.network('https://cdn-icons-png.flaticon.com/512/833/833314.png',color: tasksredcolor,height: 40,width: 40,),
                                                          ],
                                                        ),                                          
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          widget.IconSelect.text = 'https://cdn-icons-png.flaticon.com/512/761/761488.png'; 
                                                          icon = 'https://cdn-icons-png.flaticon.com/512/761/761488.png';
                                                          Navigator.of(context).pop();
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: iconcolor,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.network('https://cdn-icons-png.flaticon.com/512/761/761488.png',color: tasksredcolor,height: 40,width: 40,),
                                                          ],
                                                        ),                                          
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          widget.IconSelect.text = 'https://cdn-icons-png.flaticon.com/512/2702/2702134.png'; 
                                                          icon = 'https://cdn-icons-png.flaticon.com/512/2702/2702134.png';
                                                          Navigator.of(context).pop();
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: iconcolor,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.network('https://cdn-icons-png.flaticon.com/512/2702/2702134.png',color: tasksredcolor,height: 40,width: 40,),
                                                          ],
                                                        ),                                          
                                                      ),
                                                    ),
                                                    
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          widget.IconSelect.text = 'https://cdn-icons-png.flaticon.com/512/3043/3043888.png'; 
                                                          icon = 'https://cdn-icons-png.flaticon.com/512/3043/3043888.png';
                                                          Navigator.of(context).pop();
                                                        });
                                                      },
                                                    child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: iconcolor,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.network('https://cdn-icons-png.flaticon.com/512/3043/3043888.png',color: tasksredcolor,height: 40,width: 40,),
                                                          ],
                                                        ),                                          
                                                      ),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          widget.IconSelect.text = 'https://cdn-icons-png.flaticon.com/512/948/948256.png'; 
                                                          icon = 'https://cdn-icons-png.flaticon.com/512/948/948256.png';
                                                          Navigator.of(context).pop();
                                                        });
                                                      },
                                                    child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: iconcolor,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.network('https://cdn-icons-png.flaticon.com/512/948/948256.png',color: tasksredcolor,height: 40,width: 40,),
                                                          ],
                                                        ),                                          
                                                      ),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          widget.IconSelect.text = 'https://cdn-icons-png.flaticon.com/512/3220/3220768.png'; 
                                                          icon = 'https://cdn-icons-png.flaticon.com/512/3220/3220768.png';
                                                          Navigator.of(context).pop();
                                                        });
                                                      },
                                                    child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: iconcolor,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.network('https://cdn-icons-png.flaticon.com/512/3220/3220768.png',color: tasksredcolor,height: 40,width: 40,),
                                                          ],
                                                        ),                                          
                                                      ),
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          widget.IconSelect.text = 'https://cdn-icons-png.flaticon.com/512/3135/3135791.png'; 
                                                          icon = 'https://cdn-icons-png.flaticon.com/512/3135/3135791.png';
                                                          Navigator.of(context).pop();
                                                        });
                                                      },
                                                    child: Container(
                                                        height: 60,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: iconcolor,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.network('https://cdn-icons-png.flaticon.com/512/3135/3135791.png',color: tasksredcolor,height: 40,width: 40,),
                                                          ],
                                                        ),                                          
                                                      ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                    );
                                  },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 184, 182, 182),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network('${icon}',color: tasksredcolor,height: 35,width: 35,),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5,top: 20,right: 15,bottom: 0),
                              child: Text('Title',style: TextStyle(color: h1,fontFamily: 'h1',fontWeight: FontWeight.w600,fontSize: 20),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5,top: 10,right: 15,bottom: 15),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                        return 'Please enter the title';
                                      }
                                    return null;
                                  },
                                  controller: widget.Title,
                                  decoration: const InputDecoration(
                                    hintText: 'Add Task Name..',
                                    fillColor: Color.fromARGB(92, 158, 158, 158),
                                    filled: true,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //DETAILS
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 20,right: 15,bottom: 0),
                    child: Text('Notes',style: TextStyle(color: h1,fontFamily: 'h1',fontWeight: FontWeight.w600,fontSize: 20),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 10,right: 15,bottom: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                              return 'Please enter some notes';
                            }
                          return null;
                        },
                        controller: widget.Notes,
                        minLines: 1,
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: 'Add Task Description..',
                          fillColor: Color.fromARGB(92, 158, 158, 158),
                          filled: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        ),
                      ),
                    ),
                  ),
                  //time & date 
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15,top: 20,right: 15,bottom: 0),
                              child: Text('Start Time',style: TextStyle(color: h1,fontFamily: 'h1',fontWeight: FontWeight.w600,fontSize: 20),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15,top: 10,right: 15,bottom: 15),
                              child: GestureDetector(
                                onTap: () {
                                  showTimePicker(
                                    context: context, 
                                    initialTime: TimeOfDay.now(),
                                  ).then(((value) {
                                    setState(() {
                                      start_time = value!;
                                      widget.StartTime.text = '${start_time.hour.toString()} : ${start_time.minute.toString()}';
                                      widget.StartHour.text = '${start_time.hour.toString()}';
                                    });
                                  }));
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 15,right: 15),
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(92, 158, 158, 158),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.watch_later_outlined,color: Color.fromARGB(255, 199, 198, 198)),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15),
                                        child: Text( (widget.StartTime.text).toString(),style: TextStyle(color: Color.fromARGB(255, 199, 198, 198),fontSize: 16),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15,top: 20,right: 15,bottom: 0),
                              child: Text('End Time',style: TextStyle(color: h1,fontFamily: 'h1',fontWeight: FontWeight.w600,fontSize: 20),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15,top: 10,right: 15,bottom: 15),
                              child: GestureDetector(
                                      onTap: () {
                                        showTimePicker(
                                          context: context, 
                                          initialTime: TimeOfDay.now(),
                                        ).then(((value) {
                                          setState(() {
                                            end_time = value!;
                                            widget.EndTime.text = '${end_time.hour.toString()} : ${end_time.minute.toString()}';
                                          });
                                        }));
                                      },
                                child: Container(
                                  padding: EdgeInsets.only(left: 15,right: 15),
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(92, 158, 158, 158),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.watch_later_outlined,color: Color.fromARGB(255, 199, 198, 198)),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15),
                                        child: Text( (widget.EndTime.text).toString(),style: TextStyle(color: Color.fromARGB(255, 199, 198, 198),fontSize: 16),),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //time & date 
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 20,right: 15,bottom: 0),
                    child: Text('Date',style: TextStyle(color: h1,fontFamily: 'h1',fontWeight: FontWeight.w600,fontSize: 20),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 10,right: 15,bottom: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () {
                          showDatePicker(
                            context: context, 
                            initialDate: current_date, 
                            firstDate: DateTime(2000), 
                            lastDate: DateTime(2050)
                          ).then((value) {
                            setState(() {
                              _timedate = value!;
                              widget.DateOfTask.text = '${_timedate.year.toString()}/${_timedate.day.toString()}/${_timedate.month.toString()}';
                            });
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 15,right: 15),
                          height: 50,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(92, 158, 158, 158),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_month_outlined,color: Color.fromARGB(255, 199, 198, 198)),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text((widget.DateOfTask.text ).toString(),style: TextStyle(color: Color.fromARGB(255, 199, 198, 198),fontSize: 16),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
            
            
                  //Repeat
                  //Padding(
                  //  padding: const EdgeInsets.only(left: 15,top: 20,right: 15,bottom: 0),
                  //  child: Text('Repeat',style: TextStyle(color: h1,fontFamily: 'h1',fontWeight: FontWeight.w600,fontSize: 20),),
                  //),
                  //Padding(
                  //  padding: const EdgeInsets.only(left: 15,top: 10,right: 15,bottom: 0),
                  //  child: Row(
                  //    children: [
                  //      Expanded(
                  //        child: Container(
                  //          height: 50,
                  //          decoration: BoxDecoration(
                  //            color: Color.fromARGB(92, 158, 158, 158),
                  //            borderRadius: BorderRadius.circular(10)
                  //          ),
                  //          child: Padding(
                  //            padding: const EdgeInsets.only(left: 15,right: 15),
                  //            child: DropdownButton(
                  //              icon: Icon(Icons.keyboard_arrow_down_outlined),
                  //              elevation: 4,
                  //              isExpanded: true,
                  //              borderRadius: BorderRadius.circular(10),
                  //              focusColor: per,
                  //              hint: Text(_selectedrepeat),
                  //              underline: Container(),
                  //              style: TextStyle(color: per,fontFamily: 'per',fontSize: 15,fontWeight: FontWeight.w500),
                  //              items: repeat.map<DropdownMenuItem<String>>((String value) {
                  //                return DropdownMenuItem<String>(
                  //                  value: value,
                  //                  child: Text(
                  //                    value,
                  //                    style: const TextStyle(fontSize: 18),
                  //                  ),
                  //                );
                  //              }).toList(),
                  //              onChanged: ((String? newValue) {
                  //                setState(() {
                  //                  _selectedrepeat = newValue!;
                  //                  widget.Repeat.text = _selectedrepeat;
                  //                });
                  //              })
                  //            ),
                  //          ),
                  //        ),
                  //      ),
                  //    ],
                  //  ),
                  //),
            
            
                  //Colors
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 20,right: 15,bottom: 0),
                    child: Text('Task Color',style: TextStyle(color: h1,fontFamily: 'h1',fontWeight: FontWeight.w600,fontSize: 20),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 10,right: 15,bottom: 20),
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: circularofcolors.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: circularofcolors[index],
                          );
                        }),
                      ),
                    ),
                  ),
                  //Button
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: GestureDetector(
                      onTap: (() {
                        if (_fromkey.currentState!.validate()) {
                          print('edit done');
                          widget.onEditTask();
                        }
                      }),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 60,
                            width: 150,
                            decoration: BoxDecoration(
                              color: buttoncolor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text('Edit',style: TextStyle(letterSpacing: 1,color: h1,fontFamily: 'h3',fontSize: 25,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          );
  }
}