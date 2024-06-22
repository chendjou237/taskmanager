import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LocalDataSource{

  final  _box = Hive.box<String>('tasks');
  final boxLength = Hive.box<String>('tasks').length;
  Future<void> addTask(String task) async {
    try {
      
    await _box.add(task);
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Error adding task, try again later');
    }
  }

  Future<void> deleteTask(int index) async {
    try {
    await _box.deleteAt(index);
       
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Error deleting task, try again later'); 
    }
  }

  List<String> getTasks() {
    try {
    return _box.values.cast<String>().toList();
    } catch (e) {
      debugPrint(e.toString()); 
      throw Exception('Error getting tasks, try again later');
    }
  }

  Future<void> updateTask(int index, String task) async {
    try {
    await _box.putAt(index, task);
      
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Error updating task, try again later');
    }
  }


  void clearTasks() {
    try {
    _box.clear();
      
    } catch (e) {
        debugPrint(e.toString());
      throw Exception('Error clearing task, try again later'); 
    }
  }  
}