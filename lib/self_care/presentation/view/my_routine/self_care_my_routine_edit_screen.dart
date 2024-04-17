import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maeum_ga_gym_flutter/config/maeumgagym_color.dart';
import 'package:maeum_ga_gym_flutter/self_care/domain/model/exercise_info_edit_routine_pose_model.dart';
import 'package:maeum_ga_gym_flutter/self_care/domain/model/exercise_info_response_model.dart';
import 'package:maeum_ga_gym_flutter/self_care/presentation/provider/my_routine/self_care_my_routine_all_me_routine_provider.dart';
import 'package:maeum_ga_gym_flutter/self_care/presentation/provider/my_routine/self_care_my_routine_edit_routine_provider.dart';
import 'package:maeum_ga_gym_flutter/self_care/presentation/provider/my_routine/self_care_my_routine_pose_list_provider.dart';
import 'package:maeum_ga_gym_flutter/self_care/presentation/view/my_routine/self_care_my_routine_pose_add_screen.dart';
import 'package:maeum_ga_gym_flutter/self_care/presentation/widget/my_routine/widget/self_care_my_routine_button.dart';
import 'package:maeum_ga_gym_flutter/self_care/presentation/widget/my_routine/widget/self_care_my_routine_days_select_widget.dart';
import 'package:maeum_ga_gym_flutter/self_care/presentation/widget/my_routine/widget/self_care_my_routine_pose_item_widget.dart';
import 'package:maeum_ga_gym_flutter/self_care/presentation/widget/self_care_default_app_bar.dart';
import 'package:maeum_ga_gym_flutter/self_care/presentation/widget/self_care_text_field.dart';

class SelfCareMyRoutineEditScreen extends ConsumerStatefulWidget {
  final int listIndex;
  final String routineName;

  const SelfCareMyRoutineEditScreen({
    Key? key,
    required this.listIndex,
    required this.routineName,
  }) : super(key: key);

  @override
  ConsumerState<SelfCareMyRoutineEditScreen> createState() =>
      _SelfCareMyRoutineEditScreenState();
}

class _SelfCareMyRoutineEditScreenState
    extends ConsumerState<SelfCareMyRoutineEditScreen> {
  late TextEditingController titleController;
  late FocusNode titleNode;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.routineName);
    titleNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final routineAllMeState =
          ref.watch(selfCareMyRoutineAllMeRoutineProvider);
      final item = routineAllMeState.routineList[widget.listIndex];
      ref.read(selfCareMyRoutineEditProvider.notifier).init(
            List<ExerciseInfoEditRoutinePoseModel>.generate(
              item.exerciseInfoResponseList.length,
              (index) => ExerciseInfoEditRoutinePoseModel(
                  poseModel: item.exerciseInfoResponseList[index],
                repetitionsController: TextEditingController(text: item.exerciseInfoResponseList[index].repetitions.toString()),
                setsController: TextEditingController(text: item.exerciseInfoResponseList[index].sets.toString()),
              ),
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ExerciseInfoEditRoutinePoseModel> editPoseListState = ref.watch(selfCareMyRoutineEditProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MaeumgagymColor.white,
      appBar: SelfCareDefaultAppBar(
        iconPath: "assets/image/core_icon/left_arrow_icon.svg",
        title: widget.routineName,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              children: [
                /// 제목 입력 text field
                SelfCareTextField(
                  title: "제목",
                  focusNode: titleNode,
                  controller: titleController,
                  inputAction: TextInputAction.done,
                  maxLengths: 12,
                  hintText: "제목을 입력해주세요.",
                ),
                const SizedBox(height: 32),

                SelfCareMyRoutineDaysSelectWidget(listIndex: widget.listIndex),

                const SizedBox(height: 32),

                /// item 리스트
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: editPoseListState.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SelfCareMyRoutinePoseItemWidget(
                          listIndex: widget.listIndex,
                          poseIndex: index,
                        ),

                        /// 마지막 item이라면 간격 x
                        SizedBox(
                          height:
                              index == editPoseListState.length - 1 ? 0 : 40,
                        ),
                      ],
                    );
                  },
                ),

                /// 디자인 보고 간격 넣었습니다.
                /// 안 넣으니깐 아이템이 밑에 씹히더라구용
                const SizedBox(height: 98),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: MaeumgagymColor.white,

          /// 디자인보면 위쪽에 색있음
          border: Border(
            top: BorderSide(
              color: MaeumgagymColor.gray50,
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SelfCareMyRoutinePoseAddScreen(),
                      ),
                    ),
                    child: SelfCareMyRoutineButton(
                      width: MediaQuery.of(context).size.width,
                      height: 58,
                      title: "자세 추가",
                      imagePath: "assets/image/self_care_icon/add_icon.svg",
                      buttonColor: MaeumgagymColor.gray50,
                      textColor: MaeumgagymColor.gray800,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SelfCareMyRoutineButton(
                    width: MediaQuery.of(context).size.width,
                    height: 58,
                    title: "수정하기",
                    buttonColor: MaeumgagymColor.blue500,
                    textColor: MaeumgagymColor.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
