import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todo/data_base/databasehive.dart';

class EditTaskIcon extends StatefulWidget {
  DataBase database;
  int Index;
  EditTaskIcon({super.key,required this.database, required this.Index});

  @override
  State<EditTaskIcon> createState() => _EditTaskIconState();
}

class _EditTaskIconState extends State<EditTaskIcon> {

  String icon = 'https://cdn-icons-png.flaticon.com/512/984/984196.png';


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
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                            return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10,top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          widget.database.taskinfos[widget.Index][11] = 'https://cdn-icons-png.flaticon.com/512/984/984196.png'; 
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
                                          widget.database.taskinfos[widget.Index][11] = 'https://cdn-icons-png.flaticon.com/512/833/833314.png'; 
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
                                          widget.database.taskinfos[widget.Index][11] = 'https://cdn-icons-png.flaticon.com/512/761/761488.png'; 
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
                                          widget.database.taskinfos[widget.Index][11] = 'https://cdn-icons-png.flaticon.com/512/2702/2702134.png'; 
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
                                          widget.database.taskinfos[widget.Index][11] = 'https://cdn-icons-png.flaticon.com/512/3043/3043888.png'; 
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
                                          widget.database.taskinfos[widget.Index][11] = 'https://cdn-icons-png.flaticon.com/512/948/948256.png'; 
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
                                          widget.database.taskinfos[widget.Index][11] = 'https://cdn-icons-png.flaticon.com/512/3220/3220768.png'; 
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
                                          widget.database.taskinfos[widget.Index][11] = 'https://cdn-icons-png.flaticon.com/512/3135/3135791.png'; 
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
                          );
                        }
                      )
                    );
                  },
                  child: Container(
                    height: 75,
                    width: 75,
                    
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network('${widget.database.taskinfos[widget.Index][11]}',height: 55,width: 55,color: HexColor(widget.database.taskinfos[widget.Index][6]),),
                      ],
                    ),
                  ),
                );                             
              }
}