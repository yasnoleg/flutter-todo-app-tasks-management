import 'package:flutter/material.dart';
import 'package:todo/drawer_pages/FAQ.dart';
import 'package:todo/drawer_pages/testoo.dart';
import 'package:todo/drawer_pages/thememodels.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {

  Header() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('icons/background/backgrounddrawer.jpg'),fit: BoxFit.cover),
      ),
    );
  }
  Content() {
    return Wrap(
      runSpacing: 15,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThemeModel(),
              ));
            },
            child: ListTile(
              title: Text('Theme',style: TextStyle(color: Colors.white,fontFamily: 'h3',fontWeight: FontWeight.w400,fontSize: 18),),
              leading: Icon(Icons.color_lens_outlined),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: ListTile(
            title: Text('Remove Ads',style: TextStyle(color: Colors.white,fontFamily: 'h3',fontWeight: FontWeight.w400,fontSize: 18),),
            leading: Image.asset('icons/background/crown.png',height: 24,width: 24),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FAQPage(),
              ));
            },
            child: ListTile(
              title: Text('FAQ',style: TextStyle(color: Colors.white,fontFamily: 'h3',fontWeight: FontWeight.w400,fontSize: 18),),
              leading: Icon(Icons.question_mark_outlined),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestNotification(),
              ));
            },
            child: ListTile(
              title: Text('Abut Ous',style: TextStyle(color: Colors.white,fontFamily: 'h3',fontWeight: FontWeight.w400,fontSize: 18),),
              leading: Icon(Icons.info_outline),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Header(),
              Content(),
            ],
          ),
        ),
      ),
    );
  }
}