import 'package:flutter/material.dart';
import 'package:maeum_ga_gym_flutter/config/maeumgagym_color.dart';
import 'package:maeum_ga_gym_flutter/core/component/text/pretendard/ptd_text_widget.dart';

class SelfCareTextField extends StatefulWidget {
  final String title;
  final FocusNode focusNode;
  final TextEditingController controller;
  final TextInputAction inputAction;
  final double? height;
  final int? maxLines;
  final TextInputType? keyboardType;

  final String? suffixText;
  final String? hintText;

  const SelfCareTextField({
    super.key,
    required this.title,
    required this.focusNode,
    required this.controller,
    required this.inputAction,
    this.keyboardType,
    this.maxLines,
    this.height,
    this.suffixText,
    this.hintText,
  });

  @override
  State<SelfCareTextField> createState() => _SelfCareTextFieldState();
}

class _SelfCareTextFieldState extends State<SelfCareTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PtdTextWidget.bodyMedium(
          widget.title,
          widget.focusNode.hasFocus
              ? MaeumgagymColor.blue500
              : MaeumgagymColor.black,
        ),
        const SizedBox(height: 8),
        Container(
          width: MediaQuery.of(context).size.width,
          height: widget.height ?? 48,
          decoration: BoxDecoration(
            color: widget.focusNode.hasFocus
                ? MaeumgagymColor.blue50
                : MaeumgagymColor.gray25,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color: widget.focusNode.hasFocus
                  ? MaeumgagymColor.blue100
                  : MaeumgagymColor.gray50,
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            textInputAction: widget.inputAction,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            style: TextStyle(
              color: MaeumgagymColor.black,
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontFamily: "Pretendard",
              overflow: TextOverflow.visible,
              decorationThickness: 0,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              isCollapsed: true,

              /// TextField 커서가 위로 올라가요
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              suffixText: widget.suffixText,
              hintText: widget.hintText,

              /// 텍스트 필드 오른쪽에 뜨는 텍스트 (cm, kg),
              /// 근데 suffixText는 controller에 값이 있을 때만 뜨더라구요.. 고칠려했지만 고칠 수 없다.
              suffixStyle: TextStyle(
                color: MaeumgagymColor.gray600,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontFamily: pretendard,
                overflow: TextOverflow.visible,
                decorationThickness: 0,
              ),
              hintStyle: TextStyle(
                color: MaeumgagymColor.gray400,
                fontSize: 20,
                fontWeight: FontWeight.w400,
                fontFamily: pretendard,
                overflow: TextOverflow.visible,
                decorationThickness: 0,
              )
            ),

            cursorColor: MaeumgagymColor.blue600,

            /// 커서 색상 변경
          ),
        ),
      ],
    );
  }
}
