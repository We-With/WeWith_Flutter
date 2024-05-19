import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maeum_ga_gym_flutter/config/maeumgagym_color.dart';
import 'package:maeum_ga_gym_flutter/core/component/text/pretendard/ptd_text_widget.dart';
import 'package:maeum_ga_gym_flutter/self_care/presentation/provider/my_routine/self_care_my_routine_all_me_routine_provider.dart';
import 'package:maeum_ga_gym_flutter/self_care/presentation/provider/waka/self_care_waka_total_waka_provider.dart';
import 'package:maeum_ga_gym_flutter/self_care/presentation/view/profile/self_care_profile_main_screen.dart';

class SelfCareMainProfileContainer extends ConsumerStatefulWidget {
  const SelfCareMainProfileContainer({Key? key}) : super(key: key);

  @override
  ConsumerState<SelfCareMainProfileContainer> createState() =>
      _SelfCareMainProfileContainerState();
}

class _SelfCareMainProfileContainerState
    extends ConsumerState<SelfCareMainProfileContainer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(selfCareMyRoutineAllMeRoutineProvider.notifier).getRoutineAllMe(index: 0);
      ref.read(selfCareWakaTotalWakaProvider.notifier).totalWaka();
    });
  }

  @override
  Widget build(BuildContext context) {
    final routineAllMeState = ref.watch(selfCareMyRoutineAllMeRoutineProvider);
    final totalWakaState = ref.watch(selfCareWakaTotalWakaProvider);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelfCareProfileMainScreen(nickname: routineAllMeState.userInfo!.nickname.toString()),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: routineAllMeState.statusCode.when(
          data: (data) {
            if (data == 200) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          routineAllMeState.userInfo!.profileImage.toString(),
                          width: 48,
                          height: 48,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              PtdTextWidget.labelLarge(
                                routineAllMeState.userInfo!.nickname.toString(),
                                MaeumgagymColor.black,
                              ),
                              const SizedBox(width: 8),
                              SvgPicture.asset(
                                "assets/image/self_care_icon/profile_icon.svg",
                                // 뱃지
                                height: 16,
                                width: 16,
                              )
                            ],
                          ),
                          const SizedBox(height: 2),
                          PtdTextWidget.bodyMedium(
                            "${totalWakaState.totalSeconds}시간",
                            MaeumgagymColor.gray400,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    "assets/image/core_icon/right_arrow_icon.svg",
                    width: 24,
                    height: 24,
                  ),
                ],
              );
            } else {
              return Text(
                "${routineAllMeState.statusCode}",
              );
            }
          },
          error: (error, stack) {
            return const Text("에러");
          },
          loading: () {
            return Center(
                child: CircularProgressIndicator(
              color: MaeumgagymColor.blue500,
            ));
          },
        ),
      ),
    );
  }
}
