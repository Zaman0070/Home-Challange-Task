import 'package:easy_localization/easy_localization.dart';
import 'package:home_challenger_for_flutter/common/common_functions/padding.dart';
import 'package:home_challenger_for_flutter/common/common_imports/apis_commons.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_widgets/custom_button.dart';
import 'package:home_challenger_for_flutter/common/common_widgets/custom_text_fields.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';
import 'package:home_challenger_for_flutter/features/home/create_task/controller/add_task_controller.dart';
import 'package:home_challenger_for_flutter/generated/locale_keys.g.dart';
import 'package:home_challenger_for_flutter/models/task_model.dart';
import 'package:home_challenger_for_flutter/utils/constants/app_constants.dart';
import 'package:home_challenger_for_flutter/utils/constants/assets_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/font_manager.dart';

class EditTaskScreen extends ConsumerStatefulWidget {
  const EditTaskScreen({super.key, required this.model});
  final TaskModel model;

  @override
  ConsumerState<EditTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<EditTaskScreen> {
  var taskNameController = TextEditingController();
  var taskDescriptionController = TextEditingController();
  var dueController = TextEditingController();
  var labelsController = TextEditingController();
  DateTime dob = DateTime.now();
  DateTime now = DateTime.now();
  List<String> labels = [];
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime(1970, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != now) {
      setState(() {
        dob = picked;
        dueController.text = DateFormat('EE-MM-dd').format(picked);
      });
    }
  }

  @override
  void initState() {
    taskNameController = TextEditingController(text: widget.model.content);
    taskDescriptionController =
        TextEditingController(text: widget.model.description);
    labels = widget.model.labels!;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            AppAssets.backArrowIcon,
            width: 20.w,
            height: 20.h,
            color: context.blackColor,
          ),
        ),
        title: Text(
          LocaleKeys.editTask.tr(),
          style: getSemiBoldStyle(
              color: context.blackColor, fontSize: MyFonts.size18),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppConstants.padding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: taskNameController,
                hintText: LocaleKeys.taskName.tr(),
                label: LocaleKeys.taskName.tr(),
                validatorFn: (val) {
                  if (val!.isEmpty) {
                    return 'Task Name is required';
                  }
                  return null;
                },
              ),
              // CustomTextField(
              //   label: 'Due Date',
              //   onTap: () {
              //     _selectDate(context);
              //   },
              //   enabled: false,
              //   controller: dueController,
              //   hintText: 'Select Due Date',
              //   leadingIcon: Padding(
              //     padding: const EdgeInsets.all(14.0),
              //     child: SvgPicture.asset(AppAssets.calenderSvgIcon),
              //   ),
              // ),
              CustomTextField(
                controller: labelsController,
                hintText: LocaleKeys.lables.tr(),
                label: LocaleKeys.lables.tr(),
                tailingIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        labels.add(labelsController.text);
                        labelsController.clear();
                      });
                    },
                    child: Container(
                        width: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.r),
                          color: context.primary,
                        ),
                        child: Center(
                          child: Text(
                            'Add',
                            style: getSemiBoldStyle(
                                color: context.whiteColor,
                                fontSize: MyFonts.size14),
                          ),
                        )),
                  ),
                ),
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                children: List.generate(
                  labels.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Chip(
                      label: Text(labels[index]),
                      onDeleted: () {
                        setState(() {
                          labels.removeAt(index);
                        });
                      },
                    ),
                  ),
                ),
              ),
              CustomTextField(
                controller: taskDescriptionController,
                hintText: LocaleKeys.taskDescription.tr(),
                label: LocaleKeys.taskDescription.tr(),
                maxLines: 4,
              ),
              padding24,
              CustomButton(
                isLoading: ref.watch(addTaskControllerProvider),
                onPressed: updateTask,
                buttonText: LocaleKeys.updateTask.tr(),
                buttonHeight: 60.h,
                borderRadius: 12.r,
                backColor: context.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateTask() async {
    if (_formKey.currentState!.validate()) {
      TaskModel taskModel = widget.model.copyWith(
        content: taskNameController.text,
        description: taskDescriptionController.text,
        labels: labels,
      );
      await ref
          .read(addTaskControllerProvider.notifier)
          .updateTask(formData: taskModel, context: context);
    }
  }
}
