import 'dart:async';
import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/quill_controller_json_provider.dart';
import 'package:todo/data_base/databasehive.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:todo/pages/drawerpage.dart';

class DailyNotes extends StatefulWidget {
  const DailyNotes({super.key});

  @override
  State<DailyNotes> createState() => _DailyNotesState();
}

class _DailyNotesState extends State<DailyNotes> {

  //Link database 
  DataBase db = DataBase();

  //Quill controller
  quill.QuillController _controller = quill.QuillController.basic();

  //Date / Time
  DateTime CurrentDate = DateTime.now();

  //Controllers
  TextEditingController Title = TextEditingController();
  TextEditingController Notes = TextEditingController();
  TextEditingController SpecialNotes = TextEditingController();
  TextEditingController Colorr = TextEditingController();
  TextEditingController Label = TextEditingController();
  TextEditingController Imagee = TextEditingController();
  TextEditingController DateOfNotes = TextEditingController();

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

  //Save New Note
  SaveNewNote() {
    _controller = Provider.of<ControllerJsonProvider>(context, listen: false).quillcontroller;
    var json = jsonEncode(_controller.document.toDelta().toJson());
    setState(() {
      db.notesdailyinfo.add([
        Title.text.trim(),
        _controller.document.toPlainText(),
        json,
        Label.text.trim(),
        Colorr.text.trim(),
        '${CurrentDate.year}/${CurrentDate.day}/${CurrentDate.month}',
        '',
      ]);
    });
    db.NotesUpddateData();
    Navigator.of(context).pop();
  }


  //Save Note
  SaveNote(int Index) {
    _controller = Provider.of<ControllerJsonProvider>(context, listen: false).quillcontroller;
    var json = jsonEncode(_controller.document.toDelta().toJson());
    setState(() {
      db.notesdailyinfo[Index] = [
        Title.text.trim(),
        _controller.document.toPlainText(),
        json,
        Label.text.trim(),
        Colorr.text.trim(),
        db.notesdailyinfo[Index][5],
        '',
      ];
    });
    db.NotesUpddateData();
    Navigator.of(context).pop();
  }

  //Delete Note
  DeleteNote(int Index) {
    setState(() {
      db.notesdailyinfo.removeAt(Index);
    });
    db.NotesUpddateData();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    Title.dispose();
    Notes.dispose();
    Colorr.dispose();
    SpecialNotes.dispose();
    Label.dispose();
    Imagee.dispose();
    DateOfNotes.dispose();
    super.dispose();
  }

  @override
  void initState() {

    //db.notesdailyinfo.clear();
    if(db.bx.get("dailynotes") == null){
      db.NotesInitData();
    }else{
      db.NotesLoadData();
    }
    
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      drawer: DrawerPage(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: Text('Notes',style: TextStyle(color: h1,fontFamily: 'h1',fontSize: 20),textAlign: TextAlign.center,)),
              Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5,color: h1),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddNotePage(Title: Title, Notes: Notes, SpecialNotes: SpecialNotes, Color: Colorr, Label: Label, Image: Imagee, Date: '${CurrentDate.year}/${CurrentDate.day}/${CurrentDate.month}', onSaveNote: (() {
                    SaveNewNote();
                  })))
                );
                  },
                  child: Icon(Icons.add,size: 20,)),
              ),
            ],
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
        child: GridView.builder(
          physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.9,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ), 
          itemCount: db.notesdailyinfo.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  Title.text = db.notesdailyinfo[index][0];
                  Colorr.text = db.notesdailyinfo[index][4];
                  Label.text = db.notesdailyinfo[index][3];
                  Imagee.text = db.notesdailyinfo[index][6];
                  DateOfNotes.text = db.notesdailyinfo[index][5];
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DisplayThisNotesPage(Title: Title, Notes: Notes, SpecialNotes: SpecialNotes, Color: Colorr, Label: Label, Image: Imagee, Index: index, onSaveNote: (() {
                    SaveNote(index);
                  }), Date: DateOfNotes.text, onDeleteNote: () { DeleteNote(index); },))
                );
              },
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  color: HexColor('${db.notesdailyinfo[index][4]}'),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text('${db.notesdailyinfo[index][0]}',style: TextStyle(fontSize: 20,fontFamily: 'h1',fontWeight: FontWeight.bold,color: h1),maxLines: 2,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text('${db.notesdailyinfo[index][1]}',style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 15,fontFamily: 'h3',fontWeight: FontWeight.w500),maxLines: 3,),
                            ),
                          ],
                        ),
                      ),
                      db.notesdailyinfo[index][6] != '' ? 
                        Container(
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network('${db.notesdailyinfo[index][6]}',height: 30,width: 30,fit: BoxFit.cover,)),
                            ],
                          ),
                        ) : Container(),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            Expanded(child: Text('${db.notesdailyinfo[index][3]}',style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 15,fontFamily: 'h3',fontWeight: FontWeight.w300),)),
                            Text('${db.notesdailyinfo[index][5]}',style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 15,fontFamily: 'h3',fontWeight: FontWeight.w300),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}



//ADD NOTE PAGE 
class AddNotePage extends StatefulWidget {
  TextEditingController Title;
  TextEditingController Notes;
  TextEditingController SpecialNotes;
  TextEditingController Color;
  TextEditingController Label;
  TextEditingController Image;
  String Date;
  VoidCallback onSaveNote;
  AddNotePage({super.key,
  required this.Title,
  required this.Notes,
  required this.SpecialNotes,
  required this.Color,
  required this.Label,
  required this.Image,
  required this.Date,
  required this.onSaveNote,
  });

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> with SingleTickerProviderStateMixin  {

  DataBase db = DataBase();

  //HighLight Words
  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.w700,
      ),
    ),
    'yassine': HighlightedWord(
      onTap: () => print('yassine'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.w700,
      ),
    ),
  };

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
  String PageColor = '#FFB9B9';

  //vars
  String _selectedlabel = 'Work';
  int selectedIndex = 0;
  bool _chooseColor = false;

  //Controllers
  quill.QuillController _Quillcontroller = quill.QuillController.basic();

  //Speech to text
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = 'press to start recording';
  double _confidence = 1.0;

  //Lists
  List<String> repeat = [
    'Work',
    'Business',
    'Study',
    'hobbies',
    'WorkOut',
    'Sport',
    'Games',
  ];

  List<String> data = [
    'icons/nav_bar/gallery.png',
    'icons/nav_bar/voice.png',
    'icons/nav_bar/text-format.png',
  ];

  //Functions
  void Listen() async {
    if(!_isListening){
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if(available){
        setState(() {
          _speech.listen(
            onResult: (val) => setState(() {
              _Quillcontroller.document.insert(_Quillcontroller.document.length -1, val.recognizedWords);
              if(val.hasConfidenceRating && val.confidence > 0){
                _confidence = val.confidence;
              }
            }),
          );
        });
      }
    }else{
      setState(() {
        _isListening = false;
      });
      _speech.stop();
    }
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    //db.notesdailyinfo.clear();
    if(db.bx.get("dailynotes") == null){
      db.NotesInitData();
    }else{
      db.NotesLoadData();
    }

    //Future.delayed(Duration.zero, () {
    //  var myJSON = jsonDecode(db.notesdailyinfo[widget.Index][2]);
    //  _Quillcontroller = quill.QuillController(document: quill.Document.fromJson(myJSON),selection: TextSelection.collapsed(offset: 0));
    //});
    //Timer(Duration(milliseconds: 1000), (() {
    //  _Animationcontroller.forward();
    //}));
    //
//
    //_selectedlabel = db.notesdailyinfo[widget.Index][3];
    //widget.Notes.text = db.notesdailyinfo[widget.Index][1][0];
    //widget.SpecialNotes.text = db.notesdailyinfo[widget.Index][2][0];

    print(_Quillcontroller.document.toPlainText());
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(PageColor),
      appBar: AppBar(
        backgroundColor: HexColor(PageColor),
        elevation: 0,
        title: Row(
          children: [
            Expanded(child: Text('Add Note',style: TextStyle(color: h1,fontFamily: 'h1',fontSize: 20),textAlign: TextAlign.center,)),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0,right: 5),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _chooseColor = true;
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('icons/nav_bar/fill.png',height: 25,width: 25,color: h1,)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        context.read<ControllerJsonProvider>().ReadQuillController(_Quillcontroller);
                      });
                      widget.onSaveNote();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('icons/nav_bar/more.png',height: 22,width: 22,color: h1,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 0,left: 2),
                child: TextField(
                  controller: widget.Title,
                  style: TextStyle(color: h1,fontSize: 20,fontFamily: 'h1',fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    hintText: 'Edit Note Title',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13,top: 0,right: 15,bottom: 0),
                child: Row(
                  children: [
                    Text('Edit Label : ',style: TextStyle(color: h1.withOpacity(0.5),fontFamily: 'h3',fontSize: 14,fontWeight: FontWeight.w600)),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: DropdownButton(
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                            elevation: 4,
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(10),
                            dropdownColor: HexColor(PageColor).withOpacity(0.9),
                            focusColor: per,
                            hint: Text(_selectedlabel),
                            underline: Container(),
                            style: TextStyle(color: h1,fontFamily: 'h3',fontSize: 14,fontWeight: FontWeight.w300),
                            items: repeat.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: ((String? newValue) {
                              setState(() {
                                _selectedlabel = newValue!;
                                widget.Label.text = _selectedlabel;
                              });
                            })
                          ),
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15,left: 12),
                child: Text('${widget.Date}  |  ${_Quillcontroller.document.length} word',style: TextStyle(color: h1.withOpacity(0.5),fontFamily: 'h3',fontSize: 12,fontWeight: FontWeight.w300),),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0,left: 15,right: 15),
                child: quill.QuillEditor.basic(
                  keyboardAppearance: Brightness.light,
                  controller: _Quillcontroller, 
                  readOnly: false,
                ),
              ),
              //Padding(
              //  padding: const EdgeInsets.only(bottom: 0),
              //  child: TextField(
              //    controller: widget.Notes,
              //    style: TextStyle(color: h1,fontSize: 18,fontFamily: 'h3',fontWeight: FontWeight.w400,),
              //    maxLines: 300,
              //    minLines: 1,
              //    decoration: InputDecoration(
              //      hintText: 'Edit Note Description',
              //      border: OutlineInputBorder(
              //        borderSide: BorderSide.none,
              //      )
              //    ),
              //  ),
              //),
              //TextHighlight(
              //  text: _text, 
              //  words: _highlights,
              //  textStyle: TextStyle(
              //    fontSize: 20,
              //    fontFamily: 'h3',
              //    fontWeight: FontWeight.w500,
              //    color: h1,
              //  ),
              //),
            ],
          ),
        ),
      ),
      floatingActionButton: _chooseColor == false ? GestureDetector(
        onTap: () {
          Listen();
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: AvatarGlow(
            glowColor: h1,
            endRadius: 50,
            startDelay: Duration(milliseconds: 0),
            duration: Duration(milliseconds: 1500),
            repeatPauseDuration: Duration(milliseconds: 0),
            repeat: true,
            showTwoGlows: true,
            curve: Curves.easeInOut,
            animate: _isListening == true ? true : false,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: buttoncolor, 
                borderRadius: BorderRadius.circular(99)
              ),
              child: Icon(
                Icons.mic,
                color: h1,
                size: 20,
              ),
            ),
          ),
        ),
      ) : Container(),
      bottomNavigationBar: _chooseColor == false ? Padding(
        padding: EdgeInsets.only(left: 10,right: 10,bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(10),
            color: backgroundcolor,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.065,
              width: double.infinity,
              child: 
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: quill.QuillToolbar.basic(
                    controller: _Quillcontroller,
                    showListCheck: false,
                    showCodeBlock: false,
                    showSearchButton: false,
                    showFontFamily: false,
                    showClearFormat: true,
                    showStrikeThrough: true,
                    showIndent: false,
                    showAlignmentButtons: false,
                    showFontSize: false,
                    iconTheme: quill.QuillIconTheme(
                      borderRadius: 5,
                      iconSelectedFillColor: buttoncolor,
                      iconUnselectedFillColor: Colors.transparent,
                    ),
                    toolbarSectionSpacing: 2,
                    toolbarIconAlignment: WrapAlignment.start,
                    multiRowsDisplay: false,
                    toolbarIconSize: 20,
                  ),
                ),
            ),
          ),
        ),
      ) : Padding(
        padding: EdgeInsets.only(left: 0,right: 0,bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Material(
            elevation: 0,
            borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
            color: backgroundcolor,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.275,
                width: double.infinity,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(0, 0),
                      child: SizedBox(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () {
                                if(index == 0){
                                  setState(() {
                                    widget.Color.text = '#FFB9B9';
                                    PageColor = widget.Color.text.trim();
                                  });
                                }
                                if(index == 1){
                                  setState(() {
                                    widget.Color.text = '#81C6E8';
                                    PageColor = widget.Color.text.trim();
                                  });
                                }
                                if(index == 2){
                                  setState(() {
                                    widget.Color.text = '#FFCA83';
                                    PageColor = widget.Color.text.trim();
                                  });
                                }
                                if(index == 3){
                                  setState(() {
                                    widget.Color.text = '#4AD991';
                                    PageColor = widget.Color.text.trim();
                                  });
                                }
                                if(index == 4){
                                  setState(() {
                                    widget.Color.text = '#FF7285';
                                    PageColor = widget.Color.text.trim();
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 30,bottom: 10),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.1,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    color: index == 2 ? tasksyelcolor : index == 3 ? tasksgrecolor : index == 0 ? HexColor('#FFB9B9') : index == 1 ? HexColor('#81C6E8') : tasksredcolor,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Icon(Icons.format_list_numbered_sharp,size: 40,color: h1.withOpacity(0.5),),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _chooseColor = false;
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 5,top: 5),
                        child: Align(
                          alignment: Alignment(1, -1),
                          child: Icon(Icons.cancel_outlined),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}


//NOTE PAGE : DISPLAY NOTE INFORMATIONS 
class DisplayThisNotesPage extends StatefulWidget {
  TextEditingController Title;
  TextEditingController Notes;
  TextEditingController SpecialNotes;
  TextEditingController Color;
  TextEditingController Label;
  TextEditingController Image;
  String Date;
  int Index;
  VoidCallback onSaveNote;
  VoidCallback onDeleteNote;
  DisplayThisNotesPage({super.key,
  required this.Title,
  required this.Notes,
  required this.SpecialNotes,
  required this.Color,
  required this.Label,
  required this.Image,
  required this.Date,
  required this.Index,
  required this.onSaveNote,
  required this.onDeleteNote,
  });

  @override
  State<DisplayThisNotesPage> createState() => _DisplayThisNotesPageState();
}

class _DisplayThisNotesPageState extends State<DisplayThisNotesPage> with SingleTickerProviderStateMixin  {

  DataBase db = DataBase();

  //HighLight Words
  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.w700,
      ),
    ),
    'yassine': HighlightedWord(
      onTap: () => print('yassine'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.w700,
      ),
    ),
  };

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
  String PageColor = '#FFB9B9';

  //vars
  String _selectedlabel = 'Work';
  int selectedIndex = 0;
  bool _chooseColor = false;
  bool _displaynote_info = true;

  //Controllers
  quill.QuillController _Quillcontroller = quill.QuillController.basic();
  late AnimationController _Animationcontroller;

  //Speech to text
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = 'press to start recording';
  double _confidence = 1.0;

  //Lists
  List<String> repeat = [
    'Work',
    'Business',
    'Study',
    'hobbies',
    'WorkOut',
    'Sport',
    'Games',
  ];

  List<String> data = [
    'icons/nav_bar/gallery.png',
    'icons/nav_bar/voice.png',
    'icons/nav_bar/text-format.png',
  ];

  //Functions
  void Listen() async {
    if(!_isListening){
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if(available){
        setState(() {
          _speech.listen(
            onResult: (val) => setState(() {
              _Quillcontroller.document.insert(_Quillcontroller.document.length -1, val.recognizedWords);
              if(val.hasConfidenceRating && val.confidence > 0){
                _confidence = val.confidence;
              }
            }),
          );
        });
      }
    }else{
      setState(() {
        _isListening = false;
      });
      _speech.stop();
    }
  }
  @override
  void dispose() {
    _Animationcontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {

    //Animation Controller
    _Animationcontroller = AnimationController(vsync: this, duration: Duration(milliseconds: 6000));
    //db.notesdailyinfo.clear();
    if(db.bx.get("dailynotes") == null){
      db.NotesInitData();
    }else{
      db.NotesLoadData();
    }

    Future.delayed(Duration.zero, () {
      var myJSON = jsonDecode(db.notesdailyinfo[widget.Index][2]);
      _Quillcontroller = quill.QuillController(document: quill.Document.fromJson(myJSON),selection: TextSelection.collapsed(offset: 0));
    });
    Timer(Duration(milliseconds: 1000), (() {
      _Animationcontroller.forward();
    }));
    

    _selectedlabel = db.notesdailyinfo[widget.Index][3];
    PageColor = widget.Color.text.trim();
    //widget.Notes.text = db.notesdailyinfo[widget.Index][1][0];
    //widget.SpecialNotes.text = db.notesdailyinfo[widget.Index][2][0];

    print(_Quillcontroller.document.toPlainText());
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(PageColor),
      appBar: AppBar(
        backgroundColor: HexColor(PageColor),
        elevation: 0,
        title: Row(
          children: [
            Expanded(child: Text('Edit Note',style: TextStyle(color: h1,fontFamily: 'h1',fontSize: 20),textAlign: TextAlign.center,)),
            Row(
              children: [
                //Padding(
                //  padding: const EdgeInsets.only(left: 0,right: 10),
                //  child: GestureDetector(
                //    onTap: () {
                //      setState(() {
                //        _chooseColor = true;
                //      });
                //    },
                //    child: Column(
                //      crossAxisAlignment: CrossAxisAlignment.center,
                //      mainAxisAlignment: MainAxisAlignment.center,
                //      children: [
                //        Image.asset('icons/nav_bar/fill.png',height: 25,width: 25,color: h1,)
                //      ],
                //    ),
                //  ),
                //),
                //Padding(
                //  padding: const EdgeInsets.only(left: 10,right: 10),
                //  child: GestureDetector(
                //    onTap: () {
                //      setState(() {
                //        _chooseColor = true;
                //      });
                //    },
                //    child: Column(
                //      crossAxisAlignment: CrossAxisAlignment.center,
                //      mainAxisAlignment: MainAxisAlignment.center,
                //      children: [
                //        Image.asset('icons/delete.png',height: 25,width: 25,color: h1,)
                //      ],
                //    ),
                //  ),
                //),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        context.read<ControllerJsonProvider>().ReadQuillController(_Quillcontroller);
                      });
                      widget.onSaveNote();
                    },
                    child: Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.5,color: h1),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Icon(Icons.done,size: 20,),
                      ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 0),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context, 
                        builder: ((context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)
                            ),
                            backgroundColor: HexColor(PageColor),
                            alignment: Alignment.topRight,
                            content: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.12,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _chooseColor = true;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 15),
                                      child: Text('Change Theme',style: TextStyle(color: h1,fontFamily: 'h3',fontWeight: FontWeight.w500,fontSize: 18),),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _displaynote_info == true ?_displaynote_info = false :_displaynote_info = true;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 15),
                                      child: Text('Display Note Information',style: TextStyle(color: h1,fontFamily: 'h3',fontWeight: FontWeight.w500,fontSize: 18),),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      widget.onDeleteNote();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 0),
                                      child: Text('Delete',style: TextStyle(color: h1,fontFamily: 'h3',fontWeight: FontWeight.w500,fontSize: 18),),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('icons/nav_bar/application.png',height: 27,width: 27,color: h1,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 0,left: 2),
                child: TextField(
                  controller: widget.Title,
                  style: TextStyle(color: h1,fontSize: 20,fontFamily: 'h1',fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    hintText: 'Edit Note Title',
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13,top: 0,right: 15,bottom: 0),
                child: Row(
                  children: [
                    Text('Edit Label : ',style: TextStyle(color: h1.withOpacity(0.5),fontFamily: 'h3',fontSize: 14,fontWeight: FontWeight.w600)),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: DropdownButton(
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                            elevation: 4,
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(10),
                            dropdownColor: HexColor(PageColor).withOpacity(0.9),
                            focusColor: per,
                            hint: Text(_selectedlabel),
                            underline: Container(),
                            style: TextStyle(color: h1,fontFamily: 'h3',fontSize: 14,fontWeight: FontWeight.w300),
                            items: repeat.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: ((String? newValue) {
                              setState(() {
                                _selectedlabel = newValue!;
                                widget.Label.text = _selectedlabel;
                              });
                            })
                          ),
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
              _displaynote_info == true ? Padding(
                padding: const EdgeInsets.only(bottom: 15,left: 12),
                child: Text('${widget.Date}  |  ${_Quillcontroller.document.length} word',style: TextStyle(color: h1.withOpacity(0.5),fontFamily: 'h3',fontSize: 12,fontWeight: FontWeight.w300),),
              ) : Container(),
              FadeTransition(
                opacity: Tween<double>(begin: -1.0, end: 1.0).animate(CurvedAnimation(
                  curve: Curves.elasticOut,
                  parent: _Animationcontroller,
                )),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0,left: 15,right: 15),
                  child: quill.QuillEditor.basic(
                    controller: _Quillcontroller, 
                    readOnly: false,
                  ),
                ),
              ),
              //Padding(
              //  padding: const EdgeInsets.only(bottom: 0),
              //  child: TextField(
              //    controller: widget.Notes,
              //    style: TextStyle(color: h1,fontSize: 18,fontFamily: 'h3',fontWeight: FontWeight.w400,),
              //    maxLines: 300,
              //    minLines: 1,
              //    decoration: InputDecoration(
              //      hintText: 'Edit Note Description',
              //      border: OutlineInputBorder(
              //        borderSide: BorderSide.none,
              //      )
              //    ),
              //  ),
              //),
              //TextHighlight(
              //  text: _text, 
              //  words: _highlights,
              //  textStyle: TextStyle(
              //    fontSize: 20,
              //    fontFamily: 'h3',
              //    fontWeight: FontWeight.w500,
              //    color: h1,
              //  ),
              //),
            ],
          ),
        ),
      ),
      
      floatingActionButton: _chooseColor == false ? GestureDetector(
        onTap: () {
          Listen();
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: AvatarGlow(
            glowColor: h1,
            endRadius: 50,
            startDelay: Duration(milliseconds: 0),
            duration: Duration(milliseconds: 1500),
            repeatPauseDuration: Duration(milliseconds: 0),
            repeat: true,
            showTwoGlows: true,
            curve: Curves.easeInOut,
            animate: _isListening == true ? true : false,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: buttoncolor, 
                borderRadius: BorderRadius.circular(99)
              ),
              child: Icon(
                Icons.mic,
                color: h1,
                size: 20,
              ),
            ),
          ),
        ),
      ) : Container(),
      bottomNavigationBar: _chooseColor == false ? Padding(
        padding: EdgeInsets.only(left: 10,right: 10,bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Material(
            elevation: 0,
            borderRadius: BorderRadius.circular(10),
            color: backgroundcolor,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.065,
              width: double.infinity,
              child: 
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: quill.QuillToolbar.basic(
                    controller: _Quillcontroller,
                    showListCheck: false,
                    showCodeBlock: false,
                    showSearchButton: false,
                    showFontFamily: false,
                    showClearFormat: true,
                    showStrikeThrough: true,
                    showIndent: false,
                    showAlignmentButtons: false,
                    showFontSize: false,
                    iconTheme: quill.QuillIconTheme(
                      borderRadius: 5,
                      iconSelectedFillColor: buttoncolor,
                      iconUnselectedFillColor: Colors.transparent,
                    ),
                    toolbarSectionSpacing: 2,
                    toolbarIconAlignment: WrapAlignment.start,
                    multiRowsDisplay: false,
                    toolbarIconSize: 20,
                  ),
                ),
            ),
          ),
        ),
      ) : Padding(
        padding: EdgeInsets.only(left: 0,right: 0,bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Material(
            elevation: 0,
            borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
            color: backgroundcolor,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.275,
                width: double.infinity,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(0, 0),
                      child: SizedBox(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: ((context, index) {
                            return GestureDetector(
                              onTap: () {
                                if(index == 0){
                                  setState(() {
                                    widget.Color.text = '#FFB9B9';
                                    PageColor = widget.Color.text.trim();
                                  });
                                }
                                if(index == 1){
                                  setState(() {
                                    widget.Color.text = '#81C6E8';
                                    PageColor = widget.Color.text.trim();
                                  });
                                }
                                if(index == 2){
                                  setState(() {
                                    widget.Color.text = '#FFCA83';
                                    PageColor = widget.Color.text.trim();
                                  });
                                }
                                if(index == 3){
                                  setState(() {
                                    widget.Color.text = '#4AD991';
                                    PageColor = widget.Color.text.trim();
                                  });
                                }
                                if(index == 4){
                                  setState(() {
                                    widget.Color.text = '#FF7285';
                                    PageColor = widget.Color.text.trim();
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10,right: 10,top: 30,bottom: 10),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.1,
                                  width: 110,
                                  decoration: BoxDecoration(
                                    color: index == 2 ? tasksyelcolor : index == 3 ? tasksgrecolor : index == 0 ? HexColor('#FFB9B9') : index == 1 ? HexColor('#81C6E8') : tasksredcolor,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Icon(Icons.format_list_numbered_sharp,size: 40,color: h1.withOpacity(0.5),),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _chooseColor = false;
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 5,top: 5),
                        child: Align(
                          alignment: Alignment(1, -1),
                          child: Icon(Icons.cancel_outlined),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}