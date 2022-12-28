import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  String TapToExpandIt = 'Tap to Expand it';
  String Sentence = 'Widgets that have global keys reparent their subtrees when'
      ' they are moved from one location in the tree to another location in the'
      ' tree. In order to reparent its subtree, a widget must arrive at its new'
      ' location in the tree in the same animation frame in which it was removed'
      ' from its old location the tree.'
      ' Widgets that have global keys reparent their subtrees when they are moved'
      ' from one location in the tree to another location in the tree. In order'
      ' to reparent its subtree, a widget must arrive at its new location in the'
      ' tree in the same animation frame in which it was removed from its old'
      ' location the tree.';
  bool isExpanded = true;
  bool isExpanded2 = true;
  bool isExpanded3 = true;
  bool isExpanded4 = true;
  bool isExpanded5 = true;
  bool isExpanded6 = true;

  //COLORS
  HexColor buttoncolor = HexColor('#8280FF');
  HexColor tasksredcolor = HexColor('#FF7285');
  HexColor tasksyelcolor = HexColor('#FFCA83');
  HexColor tasksgrecolor = HexColor('#4AD991');
  HexColor tasklightpinkcolor = HexColor('#81C6E8');
  HexColor tasklightbluecolor = HexColor('#FFB9B9');
  HexColor iconcolor = HexColor('#B4B4C6');
  HexColor morningcolor = HexColor('#ffe9a6');
  Color backgroundcolor = Colors.black;
  Color backgroundcolor2 = Colors.white;
  Color h1 = Colors.white;
  Color per = Colors.grey;
  Color inactivtasks = Colors.grey.shade400;
  HexColor tabbarcolor = HexColor('#404258');

  @override
  Widget build(BuildContext context) {

    //Sizes 
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundcolor,
        title: Text('FAQ',style: TextStyle(color: h1,fontFamily: 'h1',fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          
          Padding(
            padding: EdgeInsets.only(left: 15,right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(h * 0.03),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      height: isExpanded == true ? h * 0.04 : h * 0.11,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text('Get Notifications',style: TextStyle(color: h1,fontFamily: 'h3',fontSize: h * 0.03,fontWeight: FontWeight.w300),)),
                              Icon(isExpanded == true ? Icons.arrow_drop_down_outlined : Icons.arrow_drop_up_outlined)
                            ],
                          ),
                          isExpanded == false ? Padding(
                            padding: EdgeInsets.only(top:h*0.01),
                            child: Text(''' automatically you will receive the notification when it time comes .''',style: TextStyle(color: h1,fontFamily: 'h3',fontSize: h * 0.02,fontWeight: FontWeight.w300),),
                          ) : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.only(left: 15,right: 15),
            child: ClipRRect(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded2 = !isExpanded2;
                  });
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(h*0.015),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      height: isExpanded2 == true ? h * 0.04 : h * 0.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text('Change Theme',style: TextStyle(color: h1,fontFamily: 'h3',fontSize: h * 0.03,fontWeight: FontWeight.w300),)),
                              Icon(isExpanded2 == true ? Icons.arrow_drop_down_outlined : Icons.arrow_drop_up_outlined)
                            ],
                          ),
                          isExpanded2 == false ? Padding(
                            padding: EdgeInsets.only(top: h*0.01),
                            child: Text(''' slide the screen from start to end or tap the icon of menu (it’s in topleft of the screen ) you will see drawer page , so click theme 

after that you will see the theme page so choose one and the background of the application should be change 

“if you are a designer or you are well in draw so contact us from email and send us you works ,If your drawing respects the required standards, we will add it to our application with your social media accounts” ''',style: TextStyle(color: h1,fontFamily: 'h3',fontSize: h * 0.02,fontWeight: FontWeight.w300),),
                          ) : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.only(left: 15,right: 15),
            child: ClipRRect(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded3 = !isExpanded3;
                  });
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(h*0.015),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      height: isExpanded3 == true ? h * 0.04 : h * 0.3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text('Add Task',style: TextStyle(color: h1,fontFamily: 'h3',fontSize: h * 0.03,fontWeight: FontWeight.w300),)),
                              Icon(isExpanded3 == true ? Icons.arrow_drop_down_outlined : Icons.arrow_drop_up_outlined)
                            ],
                          ),
                          isExpanded3 == false ? Padding(
                            padding: EdgeInsets.only(top: h*0.01),
                            child: Text(''' it very simple to add daily task 

tap add icon (in home page) and filling the gap : name , note , date , start/end time , color , icon 

and click start 

your task with what you filled will appear in the home page ''',style: TextStyle(color: h1,fontFamily: 'h3',fontSize: h * 0.02,fontWeight: FontWeight.w300),),
                          ) : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.only(left: 15,right: 15),
            child: ClipRRect(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded4 = !isExpanded4;
                  });
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(h*0.015),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      height: isExpanded4 == true ? h * 0.04 : h * 0.17,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text('Profile Page',style: TextStyle(color: h1,fontFamily: 'h3',fontSize: h * 0.03,fontWeight: FontWeight.w300),)),
                              Icon(isExpanded4 == true ? Icons.arrow_drop_down_outlined : Icons.arrow_drop_up_outlined)
                            ],
                          ),
                          isExpanded4 == false ? Padding(
                            padding: EdgeInsets.only(top: h*0.01),
                            child: Text(''' the profile page show you the progress of your advencement ( the percentage of tasks done compared to all tasks : to day , this week , this month ) . ''',style: TextStyle(color: h1,fontFamily: 'h3',fontSize: h * 0.02,fontWeight: FontWeight.w300),),
                          ) : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.only(left: 15,right: 15),
            child: ClipRRect(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded5 = !isExpanded5;
                  });
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(h*0.015),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      height: isExpanded5 == true ? h * 0.04 : h * 0.22,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text('Manage Your Projects',style: TextStyle(color: h1,fontFamily: 'h3',fontSize: h * 0.03,fontWeight: FontWeight.w300),)),
                              Icon(isExpanded5 == true ? Icons.arrow_drop_down_outlined : Icons.arrow_drop_up_outlined)
                            ],
                          ),
                          isExpanded5 == false ? Padding(
                            padding: EdgeInsets.only(top: h*0.01),
                            child: Text(''' We provide you with the opportunity to follow the progress of your projects in all its details , Since this version of the application is a trial version, in the future we will add the feature of forming teams, monitoring team projects, and dividing roles with your team ''',style: TextStyle(color: h1,fontFamily: 'h3',fontSize: h * 0.02,fontWeight: FontWeight.w300),),
                          ) : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.only(left: 15,right: 15),
            child: ClipRRect(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded6 = !isExpanded6;
                  });
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(h*0.015),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      height: isExpanded6 == true ? h * 0.04 : h * 0.11,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text('When You Have An Account',style: TextStyle(color: h1,fontFamily: 'h3',fontSize: h * 0.03,fontWeight: FontWeight.w300),)),
                              Icon(isExpanded6 == true ? Icons.arrow_drop_down_outlined : Icons.arrow_drop_up_outlined)
                            ],
                          ),
                          isExpanded6 == false ? Padding(
                            padding: EdgeInsets.only(top: h*0.01),
                            child: Text('COMING SOON..',style: TextStyle(color: h1,fontFamily: 'h3',fontSize: h * 0.025,fontWeight: FontWeight.w300),),
                          ) : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          
        ],
      ),
    );
  }
}
