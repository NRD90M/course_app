import 'package:course_app/provide/user_provider.dart';
import 'package:course_app/widget/bottomTabBar_widget.dart';
import 'package:course_app/widget/class_room_title_widget.dart';
import 'package:course_app/widget/classroom_top_navigator_widget.dart';
import 'package:course_app/widget/teacher_image_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:tip_dialog/tip_dialog.dart';

///课堂主界面

class ClassRoomPage extends StatefulWidget {
  final String courseId;
  final int studentNums;
  final courseNumber;
  final classtitle;
  final joinCode;
  final teacherId;
  final cid;

  ClassRoomPage(
    this.courseId, {
    Key key,
    @required this.studentNums,
    @required this.classtitle,
    @required this.joinCode,
    @required this.teacherId,
    @required this.cid,
    this.courseNumber,
  }) : super(key: key);

  @override
  _ClassRoomPageState createState() => _ClassRoomPageState();
}

class _ClassRoomPageState extends State<ClassRoomPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provide.value<UserProvide>(context)
        .getTeacherInfo(context, teacherId: widget.teacherId);
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: true,
        body: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(top: ScreenUtil.textScaleFactory * 25),
                  child: Container(
                    height: ScreenUtil.textScaleFactory * 220,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor.withGreen(222),
                            Theme.of(context).primaryColor.withOpacity(0.50),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                  ),
                  //Image.asset("assets/bg_swiper.png")
                ), // Image.asset("assets/brg/head.jpg")
              ],
            ),
            Positioned(
              child: TeacherImageInfoWidget(
                teacherId: widget.teacherId,
              ),
              top: 40,
              right: 10,
            ),
            ClassRoomTitleWidget(
              studentNums: widget.studentNums,
              classtitle: (widget.courseNumber != null &&
                      widget.courseNumber.toString().isNotEmpty)
                  ? '${widget.classtitle}(${widget.courseNumber})'
                  : widget.classtitle,
              joinCode: widget.joinCode,
              teacherId: widget.teacherId,
              courseId: widget.courseId,
              courseCid: widget.cid,
            ),

            ClassRoomTopNavigatorWidget(
              courseId: widget.courseId,
              teacherId: widget.teacherId,
              studentNums: widget.studentNums,
            ),

            BottomTabBarWidget(),

            ///tip
            TipDialogContainer(duration: const Duration(seconds: 2))
          ],
        ));
  }
}
