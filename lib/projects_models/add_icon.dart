import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';


class AddProjectIcon extends StatefulWidget {
  TextEditingController IconSelect;
  AddProjectIcon({super.key,required this.IconSelect});

  @override
  State<AddProjectIcon> createState() => _AddProjectIconState();
}

class _AddProjectIconState extends State<AddProjectIcon> {

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
  HexColor tabbarcolor = HexColor('#404258');
  HexColor taskspinkcolor = HexColor('#FFB9B9');
  HexColor tasksdarkcolor = HexColor('#404258');
  HexColor tasksbluecolor = HexColor('#81C6E8');


  String icon ='';


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225,
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
                        widget.IconSelect.text = 'icons/project_icon/web-programming.png'; 
                        icon = 'icons/project_icon/web-programming.png';
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
                          Image.asset('icons/project_icon/web-programming.png',color: tasksredcolor,height: 40,width: 40,),
                        ],
                      ),                                          
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.IconSelect.text = 'icons/project_icon/briefing.png'; 
                        icon = 'icons/project_icon/briefing.png';
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
                          Image.asset('icons/project_icon/briefing.png',color: tasksredcolor,height: 40,width: 40,),
                        ],
                      ),                                          
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.IconSelect.text = 'icons/project_icon/curve.png'; 
                        icon = 'icons/project_icon/curve.png';
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
                          Image.asset('icons/project_icon/curve.png',color: tasksredcolor,height: 40,width: 40,),
                        ],
                      ),                                          
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.IconSelect.text = 'icons/project_icon/design.png'; 
                        icon = 'icons/project_icon/design.png';
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
                          Image.asset('icons/project_icon/design.png',color: tasksredcolor,height: 40,width: 40,),
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
                        widget.IconSelect.text = 'icons/project_icon/fast.png'; 
                        icon = 'icons/project_icon/fast.png';
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
                          Image.asset('icons/project_icon/fast.png',color: tasksredcolor,height: 40,width: 40,),
                        ],
                      ),                                          
                    ),
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.IconSelect.text = 'icons/project_icon/link.png'; 
                        icon = 'icons/project_icon/link.png';
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
                          Image.asset('icons/project_icon/link.png',color: tasksredcolor,height: 40,width: 40,),
                        ],
                      ),                                          
                    ),
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.IconSelect.text = 'icons/project_icon/power.png'; 
                        icon = 'icons/project_icon/power.png';
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
                          Image.asset('icons/project_icon/power.png',color: tasksredcolor,height: 40,width: 40,),
                        ],
                      ),                                          
                    ),
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.IconSelect.text = 'icons/project_icon/sketch.png'; 
                        icon = 'icons/project_icon/sketch.png';
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
                          Image.asset('icons/project_icon/sketch.png',color: tasksredcolor,height: 40,width: 40,),
                        ],
                      ),                                          
                    ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0,top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.IconSelect.text = 'icons/project_icon/united.png'; 
                          icon = 'icons/project_icon/united.png';
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
                            Image.asset('icons/project_icon/united.png',color: tasksredcolor,height: 40,width: 40,),
                          ],
                        ),                                          
                      ),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.IconSelect.text = 'icons/project_icon/working.png'; 
                          icon = 'icons/project_icon/working.png';
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
                            Image.asset('icons/project_icon/working.png',color: tasksredcolor,height: 40,width: 40,),
                          ],
                        ),                                          
                      ),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.IconSelect.text = 'icons/project_icon/case-study.png'; 
                          icon = 'icons/project_icon/case-study.png';
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
                            Image.asset('icons/project_icon/case-study.png',color: tasksredcolor,height: 40,width: 40,),
                          ],
                        ),                                          
                      ),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.IconSelect.text = 'icons/project_icon/statistics.png'; 
                          icon = 'icons/project_icon/statistics.png';
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
                            Image.asset('icons/project_icon/statistics.png',color: tasksredcolor,height: 40,width: 40,),
                          ],
                        ),                                          
                      ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}