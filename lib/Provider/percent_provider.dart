import 'package:flutter/material.dart';
import 'package:todo/data_base/databasehive.dart';

class PercentUp with ChangeNotifier {

  double _percent = 0;
  double get percent => _percent;

  List _TasksTasksList = [];
  List get TasksTasksList => _TasksTasksList;

  DataBase d_b = DataBase();


  void initpercent() {
    //db.taskinfos.clear();
    //db.bx.clear();
    if(d_b.bx.get("todo") == null) {
      d_b.InitData();
    }else{
      d_b.LoadData();
    }
    _TasksTasksList = d_b.taskinfos;
    notifyListeners();
  }

  void readpercent(double value) {
    _percent = value;
    notifyListeners();
  }

  void donepercent(double value) {
    _percent = value;
    notifyListeners();
  }

  void readTasksList(int once,double value) {
    _TasksTasksList[once][10] = value;
    d_b.taskinfos[once][10] = value;
    notifyListeners();
    d_b.UpdateData();
  }
  
  void ProTesto() {
    print(d_b.taskinfos);
    print('==========================================');
    print(_TasksTasksList);
    print('==========================================');
  }
}