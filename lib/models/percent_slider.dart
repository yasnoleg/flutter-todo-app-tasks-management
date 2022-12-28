import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/percent_provider.dart';
import 'package:todo/data_base/databasehive.dart';

class PercentSlider extends StatefulWidget {
  DataBase database;
  int Index;
  double PercentTas;
  PercentSlider({super.key,
    required this.database,
    required this.Index,
    required this.PercentTas,
  });

  @override
  State<PercentSlider> createState() => _PercentSliderState();
}

class _PercentSliderState extends State<PercentSlider> {

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

  double percent = 0;

  DataBase db = DataBase();

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () {
      setState(() {
        percent = widget.database.taskinfos[widget.Index][10];
      });
      context.read<PercentUp>().initpercent();
    });

    //context.read<PercentUp>().setpercent(widget.database.taskinfos[widget.Index][10]);
    //db.taskinfos.clear();
    //db.bx.clear();
    if(db.bx.get("todo") == null) {
      db.InitData();
    }else{
      db.LoadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 0),
                                  child: Text('Task Progress',style: TextStyle(fontSize: 20,fontFamily: 'h2',fontWeight: FontWeight.w500,color: h1),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Text('You have complete ${(percent*100).toStringAsFixed(0)}% frome your task',style: TextStyle(fontSize: 15,fontFamily: 'h3',fontWeight: FontWeight.w300,color: h1.withOpacity(0.5),),maxLines: 2,),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: CircularPercentIndicator(
                              radius: 40,
                              animation: true,
                              animationDuration: 700,
                              lineWidth: 8,
                              percent: percent,
                              progressColor: buttoncolor,
                              backgroundColor: backgroundcolor.withOpacity(0.5),
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Text(((percent*100).toStringAsFixed(0)).toString() +' %',style: TextStyle(color: h1,fontSize: 20,fontFamily: 'h2',fontWeight: FontWeight.w400),),  
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0,right: 0,top: 10,bottom: 10),
                      child: Slider(
                        value: percent,
                        min: 0,
                        max: 1, 
                        activeColor: buttoncolor,
                        inactiveColor: buttoncolor.withAlpha(90),
                        onChanged: ((value) {
                          setState(() {
                            widget.database.taskinfos[widget.Index][10] = value;
                            percent = value;
                          });
                          context.read<PercentUp>().readTasksList(widget.Index, value);
                          widget.database.UpdateData();
                        })
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
