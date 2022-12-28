import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:todo/data_base/databasehive.dart';

class ControllerJsonProvider with ChangeNotifier {

  //Quill provider
  quill.QuillController _quillcontroller = quill.QuillController.basic();

  //DataBase
  DataBase db = DataBase();

  //Geter
  quill.QuillController get quillcontroller => _quillcontroller;

  //init data from database
  void InitController() {
    if(db.bx.get("dailynotes") == null){
      db.NotesInitData();
    }else{
      db.NotesLoadData();
    }
  }

  //Read quill controller
  void ReadQuillController(quill.QuillController value) {
    _quillcontroller = value;
    notifyListeners();
  }

}