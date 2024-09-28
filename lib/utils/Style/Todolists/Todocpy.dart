import 'package:campus/utils/Style/Todolists/common/showmodel_task.dart';
import 'package:campus/utils/Style/Todolists/provider/service_provider.dart';
import 'package:campus/utils/Style/Todolists/widget/card_todo_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:campus/api/user_controller.dart';
import 'package:intl/intl.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userController = Get.find<UserController>();
    final todoData = ref.watch(fetchStreamProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 229, 229),
        foregroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false, // Removes the back arrow
        title: Row(
          children: [
            Obx(() {
              final imageUrl = userController.imageLink.value;
              ImageProvider imageProvider;
              if (imageUrl.isNotEmpty) {
                imageProvider = NetworkImage(imageUrl);
              } else {
                imageProvider =
                    const AssetImage('assets/images/content/avatar.jpg');
              }
              return CircleAvatar(
                radius: 25,
                backgroundImage: imageProvider,
              );
            }),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                      userController.name.value.isEmpty
                          ? 'Name'
                          : userController.name.value,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'AutumnFlowers-9YVZK.otf',
                      ),
                    )),
                Obx(() => Text(
                      userController.desig.value.isEmpty
                          ? 'Designation'
                          : userController.desig.value,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[700],
                      ),
                    )),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              print("Calendar icon pressed");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Today's Task",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'AutumnFlowers-9YVZK.otf',
                      ),
                    ),
                    Text(
                      DateFormat('EEEE, d MMMM').format(DateTime.now()),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD5E8FA),
                    foregroundColor: Colors.blue[700],
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    context: context,
                    builder: (context) => AddNewTaskModal(),
                  ),
                  child: const Text(
                    "+ Add Task",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(20),
            Expanded(
              child: ListView.builder(
                itemCount: todoData.value?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) => CardTodoListWidget(
                  getIndex: index,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
