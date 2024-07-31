import 'package:easy_localization/easy_localization.dart';
import 'package:home_challenger_for_flutter/common/common_functions/padding.dart';
import 'package:home_challenger_for_flutter/common/common_imports/apis_commons.dart';
import 'package:home_challenger_for_flutter/common/common_imports/common_libs.dart';
import 'package:home_challenger_for_flutter/common/common_provider/shared_pref_helper.dart';
import 'package:home_challenger_for_flutter/common/common_widgets/custom_button.dart';
import 'package:home_challenger_for_flutter/common/common_widgets/custom_text_fields.dart';
import 'package:home_challenger_for_flutter/core/extensions/color_extensions.dart';
import 'package:home_challenger_for_flutter/features/home/create_task/controller/add_task_controller.dart';
import 'package:home_challenger_for_flutter/generated/locale_keys.g.dart';
import 'package:home_challenger_for_flutter/models/task_model.dart';
import 'package:home_challenger_for_flutter/utils/constants/app_constants.dart';
import 'package:home_challenger_for_flutter/utils/constants/assets_manager.dart';
import 'package:home_challenger_for_flutter/utils/constants/font_manager.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  String color = '';
  getColor() async {
    color = await SharedPrefHelper.getColor();
    setState(() {});
  }

  @override
  void initState() {
    getColor();
    super.initState();
  }

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

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? context.scaffoldBackgroundColor
            : context.containerColor,
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
          LocaleKeys.createTask.tr(),
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
                        width: 66.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.r),
                          color: color == 'color1'
                              ? MyColors.primary1Color
                              : color == 'color2'
                                  ? MyColors.primary2Color
                                  : context.primary,
                        ),
                        child: Center(
                          child: Text(
                            LocaleKeys.add.tr(),
                            style: getSemiBoldStyle(
                                color: context.whiteColor,
                                fontSize: MyFonts.size12),
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
                onPressed: createTask,
                buttonText: LocaleKeys.createTask.tr(),
                buttonHeight: 60.h,
                borderRadius: 12.r,
                backColor: color == 'color1'
                    ? MyColors.primary1Color
                    : color == 'color2'
                        ? MyColors.primary2Color
                        : context.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  createTask() async {
    if (_formKey.currentState!.validate()) {
      TaskModel taskModel = TaskModel(
        content: taskNameController.text,
        description: taskDescriptionController.text,
        labels: labels,
      );
      await ref
          .read(addTaskControllerProvider.notifier)
          .createTask(formData: taskModel, context: context);
    }
  }
}
