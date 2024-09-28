import 'package:campus/models/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../api/user_controller.dart';

class TodoService {
  final UserController userController = Get.find<UserController>();
  final todoCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(Get.find<UserController>().email.value)
      .collection('todolist');
  void addNewTask(TodoModel model) {
    todoCollection.add(model.toMap());
  }

  // UPDATE
  void updateTask(String? docID, bool? valueUpdate) {
    todoCollection.doc(docID).update({
      'isDone': valueUpdate,
    });
  }

// DELETE
  void deleteTask(String? docID) {
    todoCollection.doc(docID).delete();
  }
}
