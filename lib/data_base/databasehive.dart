// ignore_for_file: unused_field, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:image_picker/image_picker.dart';

class DataBase {

  //list
  List taskinfos = [];
  double sizecount = 0;
  List notesdailyinfo = [];
  String? imagepath;
  String background = '';

  //reference
  final bx = Hive.box("mybox");

  //init Task data
  void InitData() {
    taskinfos = [];
  }

  //Task load 
  void LoadData() {
    taskinfos = bx.get("todo");
    sizecount = bx.get("size");
  }

  //Task update data
  void UpdateData() {
    bx.put("todo", taskinfos);
    bx.put("size", sizecount);
  }


  //Notes Init Data
  void NotesInitData() {
    notesdailyinfo = [];
  }

  //Notes Load Data
  void NotesLoadData() {
    notesdailyinfo = bx.get("dailynotes");
  }

  //Notes Update Data
  void NotesUpddateData() {
    bx.put("dailynotes", notesdailyinfo);
  }

  //Init Image Path
  void InitImagePath() {
    imagepath = null;
  }

  //Load Image Path
  void LoadImagePath() {
    imagepath = bx.get("path");
  }

  //Upload Image Path
  void UploadImagePath() {
    bx.put("path", imagepath);
  }


  //Background Init Data 
  void BackInitData() {
    background = '';
  }

  //Bcakground Load Data 
  void BackLoadData() {
    background = bx.get("background");
  }

  //Background Update Data
  void BackUpdateData() {
    bx.put("background", background);
  } 


  //Start Todo Tasks------------------------------------------
    List<dynamic> CheckTodoMap = [];
    //Init Data
    void CheckTodoInit() {
      CheckTodoMap = [];
    }

    //Load Data
    void CheckTodoLoad() {
      CheckTodoMap = bx.get("Check");
    }

    //Update Data
    void CheckTodoUpdate() {
      bx.put("Check", CheckTodoMap);
    }

  //End Todo Tasks------------------------------------------


  //Start Project DataBase----------------------------------
    List<dynamic> projectslist = [{
        'name': 'Complete the app',
        'note': 'Do it now',
        'icon': '',
        'image': '',
        'display_icon': true,
        'nbr_tasks': 5,
        'nbr_tasks_done': 3,
      }];

    //Init Data
    void ProjectInit() {
      projectslist = [];
    }

    //Load Data
    void ProjectsLoad() {
      projectslist = bx.get("projects");
    }

    //Update Data
    void ProjectUpdate() {
      bx.put("projects", projectslist);
    }
  //End Project DataBase----------------------------------
}