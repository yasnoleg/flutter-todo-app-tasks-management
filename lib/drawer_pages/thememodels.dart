import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/background_provider.dart';
import 'package:todo/data_base/databasehive.dart';

class ThemeModel extends StatefulWidget {
  const ThemeModel({super.key});

  @override
  State<ThemeModel> createState() => _ThemeModelState();
}

class _ThemeModelState extends State<ThemeModel> {

  //Data Base
  DataBase db = DataBase();

  //Vars
  String backpath = '';

  //Lists
  List<String> backgroundimageslist = [
    'icons/background/background1.jpg',
    'icons/background/background2.jpg',
    'icons/background/background4.jpg',
    'icons/background/background5.jpg',
    'icons/background/background10.jpg',
  ];
  List<String> backgroundscenerylist = [
    'icons/background/background.jpg',
    'icons/background/bcakground7.jpg',
    'icons/background/background8.jpg',
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

  //Change background
  ChangeBackgroundTexture(int Index) {
    setState(() {
      db.background = backgroundimageslist[Index];
    });
    db.BackUpdateData();
    context.read<BackProvider>().ReadBackgroundPath(backgroundimageslist[Index]);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  //Change background
  ChangeBackgroundScenery(int Index) {
    setState(() {
      db.background = backgroundscenerylist[Index];
    });
    db.BackUpdateData();
    context.read<BackProvider>().ReadBackgroundPath(backgroundscenerylist[Index]);
    print(BackProvider().background);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    
    if(db.bx.get("background") == null){
      db.BackInitData();
    }else{
      db.BackLoadData();
    }

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    //Size
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(backgroundColor: backgroundcolor),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Title
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      setState(() {
                        db.background = '';
                      });
                      db.BackUpdateData();
                      context.read<BackProvider>().ReadBackgroundPath('');
                    });
                  },
                  child: Row(
                    children: [
                      Text('Default  ',style: TextStyle(color: h1,fontSize: 18,fontFamily: 'h3',fontWeight: FontWeight.w400),),
                      Image.asset('icons/background/crown.png',height: 24,width: 24),
                    ],
                  ),
                ),
              ),      
              //Texture
              SizedBox(
                height: h * 0.2,
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1.3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ), 
                    itemCount: 1, 
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          db.background = '';
                        });
                        db.BackUpdateData();
                        context.read<BackProvider>().ReadBackgroundPath('empty');
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: backgroundcolor,
                          boxShadow: [
                            BoxShadow(
                              color: h1.withOpacity(0.3),
                              blurRadius: 3,
                              spreadRadius: 1
                            )
                          ]
                        ),
                      ),
                    );
                  })
                ),
              ),

              //Title
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Text('Texture  ',style: TextStyle(color: h1,fontSize: 18,fontFamily: 'h3',fontWeight: FontWeight.w400),),
                    Image.asset('icons/background/crown.png',height: 24,width: 24),
                  ],
                ),
              ),
      
              //Texture
              SizedBox(
                height: h * 0.6,
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1.3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ), 
                    itemCount: backgroundimageslist.length, 
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        ChangeBackgroundTexture(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(image: AssetImage(backgroundimageslist[index]),fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(
                              color: h1.withOpacity(0.25),
                              blurRadius: 3,
                              spreadRadius: 1
                            )
                          ]
                        ),
                      ),
                    );
                  })
                ),
              ),

              //Title
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Text('Scenery  ',style: TextStyle(color: h1,fontSize: 18,fontFamily: 'h3',fontWeight: FontWeight.w400),),
                    Image.asset('icons/background/crown.png',height: 24,width: 24),
                  ],
                ),
              ),
      
              //Scenery
              SizedBox(
                height: h * 0.4,
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1.3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ), 
                    itemCount: backgroundscenerylist.length, 
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        ChangeBackgroundScenery(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(image: AssetImage(backgroundscenerylist[index]),fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(
                              color: h1.withOpacity(0.25),
                              blurRadius: 3,
                              spreadRadius: 1
                            )
                          ]
                        ),
                      ),
                    );
                  })
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}