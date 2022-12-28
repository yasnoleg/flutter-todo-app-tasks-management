import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/background_provider.dart';
import 'package:todo/data_base/databasehive.dart';
import 'package:todo/pages/homepage.dart';
import 'package:todo/pages/notespage.dart';
import 'package:todo/pages/profilepage.dart';
import 'package:todo/pages/projectspage.dart';
import 'package:todo/pages/todo.dart';
import 'package:todo/servecis/apinot.dart';

class HomeMainPage extends StatefulWidget {
  const HomeMainPage({super.key});

  @override
  State<HomeMainPage> createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {

  //Data Base
  DataBase db = DataBase();

  int selectedIndex = 0;
  List<String> data = [    
    'icons/nav_bar/home.png',
    'icons/nav_bar/writing.png',
    'icons/nav_bar/user.png',
  ];

  bool _showdrawer = false;

  List<Widget> display_pages = [
    DailyHomePage(),
    ProjectsPage(),
    DisProfileP(),
  ];
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

  //Notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  

  @override
  void initState() {
    if(db.bx.get("background") == null){
      db.BackInitData();
    }else{
      db.BackLoadData();
    }

    Noti.initialize(flutterLocalNotificationsPlugin);
    
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: context.watch<BackProvider>().background == 'empty' ? db.background == '' ? const AssetImage('icons/background/background2.jpg') :  AssetImage(db.background,) : AssetImage(context.watch<BackProvider>().background),fit: BoxFit.cover)
        ),
        child: Scaffold(
        backgroundColor: context.watch<BackProvider>().background == 'empty' ? db.background == '' ? backgroundcolor : db.background == 'icons/background/background4.jpg' || db.background == 'icons/background/background5.jpg' || db.background == 'icons/background/background2.jpg' ? backgroundcolor.withOpacity(0.7) :  db.background == 'icons/background/background8.jpg' ? backgroundcolor.withOpacity(0.6) : db.background == '' ? backgroundcolor : backgroundcolor.withOpacity(0.5) : context.watch<BackProvider>().background == 'icons/background/background4.jpg' || context.watch<BackProvider>().background == 'icons/background/background5.jpg' || context.watch<BackProvider>().background == 'icons/background/background2.jpg' || context.watch<BackProvider>().background == 'icons/background/background8.jpg' ? context.watch<BackProvider>().background == 'icons/background/background8.jpg' ? backgroundcolor.withOpacity(0.6) : context.watch<BackProvider>().background == 'empty' ? backgroundcolor : backgroundcolor.withOpacity(0.7) : backgroundcolor.withOpacity(0.5),
        body: display_pages[selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.grey.withOpacity(0.05),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey.shade800,
                color: Colors.white,
                tabs: [
                  GButton(
                    leading: Image.asset('icons/nav_bar/home.png',height: MediaQuery.of(context).size.height*0.025,width: MediaQuery.of(context).size.height*0.025,color: h1,),
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    leading: Image.asset('icons/nav_bar/application.png',height: MediaQuery.of(context).size.height*0.025,width: MediaQuery.of(context).size.height*0.025,color: h1,),
                    icon: Icons.add_circle_outline,
                    text: 'Add',
                  ),
                  GButton(
                    leading: Image.asset('icons/nav_bar/user.png',height: MediaQuery.of(context).size.height*0.025,width: MediaQuery.of(context).size.height*0.025,color: h1,),
                    icon: Icons.account_circle_outlined,
                    text: 'profile',
                  ),
                ],
                selectedIndex: selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ),
          ),
      ),

      ),
    );
  }
}


class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}