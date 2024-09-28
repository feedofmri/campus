import 'package:campus/models/todo_model.dart';
import 'package:campus/utils/Style/Todolists/provider/date_time_provider.dart';
import 'package:campus/utils/Style/Todolists/provider/radio_provider.dart';
import 'package:campus/utils/Style/Todolists/provider/service_provider.dart';
import 'package:campus/utils/Style/Todolists/widget/date_time_widget.dart';
import 'package:campus/utils/Style/Todolists/widget/radio_widget.dart';
import 'package:campus/utils/Style/Todolists/widget/textfieldwidget.dart';
import 'package:campus/utils/constants/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class AddNewTaskModal extends ConsumerStatefulWidget {
  const AddNewTaskModal({super.key});

  @override
  _AddNewTaskModalState createState() => _AddNewTaskModalState();
}

class _AddNewTaskModalState extends ConsumerState<AddNewTaskModal> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final dateProv = ref.watch(dateProvider);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text(
                'New Task Todo',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Divider(
              thickness: 1.2,
              color: Colors.grey.shade200,
            ),
            const Gap(12),
            const Text(
              'Title Task',
              style: AppStyle.headingOne,
            ),
            const Gap(6),
            TextFieldWidget(
              maxLine: 1,
              hintText: "Add Task Name",
              txtController: titleController,
              focusNode: titleFocusNode,
            ),
            const Gap(12),
            const Text(
              'Description',
              style: AppStyle.headingOne,
            ),
            Gap(6),
            TextFieldWidget(
              maxLine: 5,
              hintText: "Add Descriptions",
              txtController: descriptionController,
              focusNode: descriptionFocusNode,
            ),
            Gap(12),
            const Text("Category", style: AppStyle.headingOne),
            Row(
              children: [
                Expanded(
                    child: RadioWidget(
                  titleRadio: "LRN",
                  categColor: Colors.green,
                  valueInput: 1,
                )),
                Expanded(
                    child: RadioWidget(
                  titleRadio: "WRK",
                  categColor: Colors.blue.shade700,
                  valueInput: 2,
                )),
                Expanded(
                    child: RadioWidget(
                  titleRadio: "GEN",
                  categColor: Colors.amberAccent.shade700,
                  valueInput: 3,
                ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateTimeWidget(
                  titleText: 'Date',
                  valueText: dateProv,
                  iconSection: CupertinoIcons.calendar,
                  onTap: () async {
                    final getValue = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2029),
                    );
                    if (getValue != null) {
                      final format = DateFormat.yMd();
                      ref
                          .read(dateProvider.notifier)
                          .update((state) => format.format(getValue));
                    }
                  },
                ),
                Gap(22),
                DateTimeWidget(
                    titleText: 'Time',
                    valueText: ref.watch(timeProvider),
                    iconSection: CupertinoIcons.clock,
                    onTap: () async {
                      final getTime = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());

                      if (getTime != null) {
                        final format = DateFormat.yMd();
                        ref
                            .read(timeProvider.notifier)
                            .update((state) => getTime.format(context));
                      }
                    }),
              ],
            ),
            Gap(20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue.shade800,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(
                        color: Colors.blue.shade800,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const Gap(20),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(
                        color: Colors.blue.shade800,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      final getRadioValue = ref.read(radioProvider);
                      String category = '';

                      switch (getRadioValue) {
                        case 1:
                          category = 'Learning';
                          break;
                        case 2:
                          category = 'Working';
                          break;
                        case 3:
                          category = 'General';
                          break;
                      }

                      ref.read(serviceProvider).addNewTask(TodoModel(
                            titleTask: titleController.text,
                            description: descriptionController.text,
                            Category: category,
                            dateTask: ref.read(dateProvider),
                            timeTask: ref.read(timeProvider),
                            isDone: false,
                          ));

                      titleController.clear();
                      descriptionController.clear();
                      ref.read(radioProvider.notifier).update((state) => 0);
                      Navigator.pop(context);
                    },
                    child: const Text('Create'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    titleFocusNode.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }
}
