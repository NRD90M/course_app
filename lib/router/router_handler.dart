import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:course_app/data/Attendance_vo.dart';
import 'package:course_app/model/Course.dart';
import 'package:course_app/pages/about_page.dart';
import 'package:course_app/pages/admin_account_page.dart';
import 'package:course_app/pages/announcement_content_page.dart';
import 'package:course_app/pages/announcement_page.dart';
import 'package:course_app/pages/chat/chat_home.dart';
import 'package:course_app/pages/chat/pic_view.dart';
import 'package:course_app/pages/chat/search_friend.dart';
import 'package:course_app/pages/chat/video_view_page.dart';
import 'package:course_app/pages/classroom_page.dart';
import 'package:course_app/pages/classwork_page.dart';
import 'package:course_app/pages/classwork_stu_page.dart';
import 'package:course_app/pages/create_test_page.dart';
import 'package:course_app/pages/doucument_list_page.dart';
import 'package:course_app/pages/file_opt_page.dart';
import 'package:course_app/pages/home_page.dart';
import 'package:course_app/pages/join_course_page.dart';
import 'package:course_app/pages/login_page.dart';
import 'package:course_app/pages/pwd_change_page.dart';
import 'package:course_app/pages/qrcode_page.dart';
import 'package:course_app/pages/register_page/final_registe_page.dart';
import 'package:course_app/pages/register_page/next_pegist_page.dart';
import 'package:course_app/pages/register_page/register_user_page.dart';
import 'package:course_app/pages/register_page/result_registe_page.dart';
import 'package:course_app/pages/soft/software_page.dart';
import 'package:course_app/pages/student/attendance_check_page.dart';
import 'package:course_app/pages/teacher/attendance_detail_page.dart';
import 'package:course_app/pages/teacher/attendance_page.dart';
import 'package:course_app/pages/teacher/create_announce_page.dart';
import 'package:course_app/pages/teacher/create_course_page.dart';
import 'package:course_app/pages/test_detail_page.dart';
import 'package:course_app/pages/test_page.dart';
import 'package:course_app/pages/topic_page.dart';
import 'package:course_app/pages/upload_question_page.dart';
import 'package:course_app/pages/user_info_page.dart';
import 'package:course_app/pages/student/attendance_stu_page.dart';
import 'package:course_app/provide/course_provide.dart';
import 'package:course_app/provide/reply_list_provide.dart';
import 'package:course_app/provide/user_provider.dart';
import 'package:course_app/provide/websocket_provide.dart';
import 'package:course_app/service/user_method.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

Handler JoinCourseHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return JoinCoursePage();
});

///首页
Handler homeHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  // Provide.value<CourseProvide>(context).student_getCoursePage(Provide.value<UserProvide>(context).userId);
  //打开websocket
  return HomePage();
});

///登录页
Handler loginHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var username = (ObjectUtil.isNotEmpty(params['username'])
      ? params['username'].first
      : '');
  var pwd = (ObjectUtil.isNotEmpty(params['pwd']) ? params['pwd'].first : '');
  return LoginPage(username: username, pwd: pwd);
});

///注册页面
Handler registerUserHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RegisterUserPage();
});

///注册第二页
Handler nextRegistPageHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//  var username = (ObjectUtil.isNotEmpty(params['username']))
//      ? params['username'].first
//      : '';
//  print('username ${username}');
  return NextRegistPage(
//    username: username,
      );
});

///注册确认页
Handler finalRegisteHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return FinalRegistePage();
});

///注册结果页
Handler ResultRegistHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  bool isSuccess = (ObjectUtil.isNotEmpty(params['isSuccess'])) ? true : false;
  var username = (ObjectUtil.isNotEmpty(params['username']))
      ? params['username'].first
      : '';
  return ResultRegistPage(isSuccess: isSuccess, username: username);
});

///课堂页
Handler classRoomHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  print('classRoomHanderl');
  var studentNums = int.parse(params['studentNums'].first);
  var classtitle = params['classtitle'].first;
  var joinCode = params['joinCode'].first;
  var teacherId = params['teacherId'].first;
  var courseId = params['courseId'].first;
  var courseNumber = params['courseNumber'].first;
  var cid = params['cid'].first;
  print(studentNums);

  return ClassRoomPage(
    courseId,
    studentNums: studentNums,
    classtitle: classtitle,
    joinCode: joinCode,
    teacherId: teacherId,
    courseNumber: courseNumber,
    cid: cid,
  );
});

///用户资料页
Handler userInfoHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UserInfoPage();
});

///账号与安全页
Handler adminAccoutHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AdminAccoutPage();
});

///密码管理页面
Handler pwdChangeHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var username = (params['username'] != null) ? params['username'].first : '';
  return PwdChangePage(
    username: username,
  );
});

///创建课程页
Handler createCourseHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var titlePage = params['titlePage'].first;
  //print("***********************${titlePage}");
  return CreateCoursePage(titlePage: titlePage.toString());
});

///公告页
Handler announcementHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var courseId = (params['courseId'] != null) ? params['courseId'].first : '';
  var teacherId =
      (params['teacherId'] != null) ? params['teacherId'].first : '';

  ///dio
  UserMethod.getAnnouncementPage(context,
          userId: Provide.value<UserProvide>(context).userId,
          courseId: courseId)
      .then((value) {
    if (value != null) {
      print("saveAnnouncement : ${value}");
      Provide.value<ReplyListProvide>(context).saveAnnouncement(value);
    }
  });
  return AnnouncementPage(
    courseId: courseId,
    teacherId: teacherId,
  );
});

///公告详情页
Handler announcementContentHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var announceId =
      (params['announceId'] != null) ? params['announceId'].first : '';
  var announceTitle = params['announceTitle'].first;
  var announceText = params['announceText'].first;
  var username = (params['username'] != null) ? params['username'].first : '';
  var annex =
      (params['annex'] != null && params['annex'].first.contains('http'))
          ? params['annex'].first
          : '';
  num readedNum =
      (params['readedNum'] != null && params['readedNum'].toString() != 'null')
          ? num.parse(params['readedNum'].first)
          : 0;
  num commentNum = (params['commentNum'] != null)
      ? num.parse(params['commentNum'].first)
      : 0;
  var date = (params['date'] != null) ? (params['date'].first) : '';
  return AnnouncementContentPage(
    announceId: announceId,
    announceTitle: announceTitle,
    username: username,
    announceText: announceText,
    annex: annex,
    readedNum: readedNum,
    commentNum: commentNum,
    date: date,
  );
});

///发布公告
Handler createAnnounceHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var courseId = (params['courseId'] != null) ? params['courseId'].first : '';
  var pageTitle =
      (params['pageTitle'] != null) ? params['pageTitle'].first : '创建公告';
  bool isCreatePage = (params['isCreatePage'] != null)
      ? bool.fromEnvironment(params['isCreatePage'].first)
      : true;
  var announceTitle =
      (params['announceTitle'] != null) ? params['announceTitle'].first : '';
  var announceBody =
      (params['announceBody'] != null) ? params['announceBody'].first : '';
  var announceId =
      (params['announceId'] != null) ? params['announceId'].first : '';
  var fujian = (params['fujian'] != null) ? params['fujian'].first : null;
  return CreateAnnouncePage(
    courseId: courseId,
    pageTitle: pageTitle,
    isCreatePage: isCreatePage,
    title: announceTitle,
    contextBody: announceBody,
    announceId: announceId,
    fujian: fujian,
  );
});

///二维码名片页
Handler qrcodeHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return QRcodePage();
});

///学生考勤页面
Handler attendanceStuHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AttendanceStuPage();
});

///教师考勤管理
Handler attendancePageHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  num nums = (ObjectUtil.isNotEmpty(params['studentNums']))
      ? num.parse(params['studentNums'].first)
      : 0;
  String courseId = (ObjectUtil.isNotEmpty(params['courseId']))
      ? params['courseId'].first
      : '';
  return AttendancePage(
    studentNums: nums,
    courseId: courseId,
  );
});

///
Handler attendanceCheckHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  int attendanceStudentId =
      (ObjectUtil.isNotEmpty(params['attendanceStudentId'].first))
          ? int.parse(params['attendanceStudentId'].first)
          : 0;
  int type = (ObjectUtil.isNotEmpty(params['type'].first))
      ? int.parse(params['type'].first)
      : 0;
  var address = (ObjectUtil.isNotEmpty(params['address'].first))
      ? params['address'].first
      : '';
  var time =
      (ObjectUtil.isNotEmpty(params['time'].first)) ? params['time'].first : '';
  var attendanceId = (ObjectUtil.isNotEmpty(params['attendanceId'].first))
      ? params['attendanceId'].first
      : '';
  return AttendanceCheckPage(
    type: type,
    attendanceStudentId: attendanceStudentId,
    attendanceId: attendanceId,
    address: address,
    time: time,
  );
});

Handler attendDetailHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  int index = (ObjectUtil.isNotEmpty(params['index'].first))
      ? int.parse(params['index'].first)
      : 0;
  return AttendDetailPage(
    index: index,
  );
});

///about
Handler aboutHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AboutPage();
});

///search
Handler searchFriendHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SearchFriendPage();
});

///chat home
Handler chatHomeHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ChatHome();
});

///ImageViewPage
Handler imageViewHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var urlPath = (ObjectUtil.isNotEmpty(params['urlPath'].first))
      ? params['urlPath'].first
      : '';
  String isNetUrl = (ObjectUtil.isNotEmpty(params['isNetUrl'].first))
      ? params['isNetUrl'].first
      : 'false';
  bool b = false;
  if (isNetUrl == 'false') {
  } else {
    b = true;
  }
  return ImageViewPage(
    isNetUrl: b,
    urlPath: urlPath,
  );
});

///video view
Handler videoViewHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var urlPath = (ObjectUtil.isNotEmpty(params['urlPath'].first))
      ? params['urlPath'].first
      : '';
  return VideoViewPage(
    urlPath: urlPath,
  );
});

///doucument
Handler doucumentListHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var courseId = (ObjectUtil.isNotEmpty(params['courseId'].first))
      ? params['courseId'].first
      : '';
  var teacherId = (ObjectUtil.isNotEmpty(params['teacherId'].first))
      ? params['teacherId'].first
      : '';
  return DoucumentListPage(
    courseId: courseId,
    teacherId: teacherId,
  );
});

///topic page

Handler topicHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var courseId = (ObjectUtil.isNotEmpty(params['courseId'].first))
      ? params['courseId'].first
      : '';
  var teacherId = (ObjectUtil.isNotEmpty(params['teacherId'].first))
      ? params['teacherId'].first
      : '';
  return TopicPage(
    courseId: courseId,
    teacherId: teacherId,
  );
});

///文件传输页面
Handler fileOptHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var initValue = (ObjectUtil.isNotEmpty(params['initValue'].first))
      ? num.parse(params['initValue'].first)
      : 0;
  return FileOptPage(
    initValue: initValue,
  );
});

///课堂测试页
Handler testPageHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var courseId = (ObjectUtil.isNotEmpty(params['courseId'].first))
      ? params['courseId'].first
      : '';
  var teacherId = (ObjectUtil.isNotEmpty(params['teacherId'].first))
      ? params['teacherId'].first
      : '';
  return TestPage(
    courseId: courseId,
    teacherId: teacherId,
  );
});

///课堂测试详情情况页
Handler testDetailPageHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var pageTitle = (ObjectUtil.isNotEmpty(params['pageTitle'].first))
      ? params['pageTitle'].first
      : '';
  var releaseTime = (ObjectUtil.isNotEmpty(params['releaseTime'].first))
      ? params['releaseTime'].first
      : '';
  var endTime = (ObjectUtil.isNotEmpty(params['endTime'].first))
      ? params['endTime'].first
      : '';
  num submitted = (ObjectUtil.isNotEmpty(params['submitted'].first))
      ? num.tryParse(params['submitted'].first)
      : 0;
  num unsubmitted = (ObjectUtil.isNotEmpty(params['unsubmitted'].first))
      ? num.tryParse(params['unsubmitted'].first)
      : 0;
  return TestDetailPage(
    pageTitle: pageTitle,
    releaseTime: releaseTime,
    endTime: endTime,
    submitted: submitted,
    unsubmitted: unsubmitted,
  );
});

///创建试题页面
Handler createTestHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var courseId = (ObjectUtil.isNotEmpty(params['courseId'].first))
      ? params['courseId'].first
      : '';
  return CreateTestPage(
    courseId: courseId,
  );
});

//Handler uploadQuestHanderl = Handler(
//    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//  var courseId = (ObjectUtil.isNotEmpty(params['courseId'].first))
//      ? params['questionList'].first
//      : '';
//  return UploadQuestPage(
//    questionList: questionList,
//  );
//});
///课堂作业
Handler classworkHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var courseId = (ObjectUtil.isNotEmpty(params['courseId'].first))
      ? params['courseId'].first
      : '';
  var teacherId = (ObjectUtil.isNotEmpty(params['teacherId'].first))
      ? params['teacherId'].first
      : '';
  return ClassworkPage(
    courseId: courseId,
    teacherId: teacherId,
  );
});

///学生作业界面

Handler classWorkStudentHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var courseId = (ObjectUtil.isNotEmpty(params['courseId'].first))
      ? params['courseId'].first
      : '';
  var teacherId = (ObjectUtil.isNotEmpty(params['teacherId'].first))
      ? params['teacherId'].first
      : '';
  var userId = (ObjectUtil.isNotEmpty(params['userId'].first))
      ? params['userId'].first
      : '';
  return ClassWorkStudentPage(
    courseId: courseId,
    teacherId: teacherId,
    userId: userId,
  );
});
