import 'package:campus/helper/todo_service.dart';
import 'package:campus/models/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../api/user_controller.dart';

final serviceProvider = StateProvider<TodoService>((ref) {
  return TodoService();
});

final UserController userController = Get.find<UserController>();
final fetchStreamProvider = StreamProvider<List<TodoModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection('users')
      .doc(Get.find<UserController>().email.value)
      .collection('todolist')
      .snapshots()
      .map((event) => event.docs
          .map((snapshot) => TodoModel.fromSnapshot(snapshot))
          .toList());
  yield* getData;
});
