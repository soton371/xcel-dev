import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/pages/navbar_patient/home/components/drawer/drawer_menu.dart';
import 'package:xcel_medical_center/pages/navbar_patient/home/components/sliding_images.dart';
import 'package:xcel_medical_center/services/doctor_category_service.dart';
import 'package:xcel_medical_center/pages/navbar_patient/home/view/speciality/doctor_list_page.dart';
import 'package:xcel_medical_center/services/video_service.dart';
import '../../../model/dept_doctor.dart';
import '../../../model/video.dart';
import '../../../model/video_param.dart';
import 'components/title_widget.dart';
import 'view/speciality/doctor_speciality.dart';
import 'view/tips_and_tricks.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  DeptDoctor doctorCategoryData = DeptDoctor();
  bool isLoadingDoctorCategory = true;

  Video videoData = Video();
  bool isLoadingVideo = true;

  @override
  void initState() {
    VideoParam body = VideoParam();
    body.pTOPICUID = "TIP";
    body.pROLEACID = "P";
    body.pPATIENTID = "";
    VideoService().fetchVideoInfo(body).then((video) {
      setState(() {
        videoData = video;
        isLoadingVideo = false;
      });
    });
    DoctorCategoryService().getDeptWiseDoctorList().then((category) {
      setState(() {
        doctorCategoryData = category;
        isLoadingDoctorCategory = false;
      });
    });
    super.initState();
  }

  List<Doctor> getAllDrList() {
    List<Doctor> allDoctor = [];
    for (int i = 0; i < (doctorCategoryData.items ?? []).length; i++) {
      var item = (doctorCategoryData.items ?? [])[i];
      var doctor2 = item.doctor;
      for (int j = 0; j < (doctor2 ?? []).length; j++) {
        var doc = (doctor2 ?? [])[j];
        doc.deptNM = item.deptName;
        doc.deptN0 = item.deptNo;
        allDoctor.add(doc);
      }
    }
    return allDoctor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Xcel Medical Centre'),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(CupertinoIcons.bell_fill)
          )
        ],
      ),
      drawer: const DrawerMenu(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* ::::::::::::::::::::::::::::::::: SLIDING IMAGES ::::::::::::::::::::::::::::::::: */
            const SlidingImages(),
            /* ::::::::::::::::::::::::::::::::: DOCTOR SPECIALITY ::::::::::::::::::::::::::::::::: */
            const SizedBox(height: 8),
            const TitleWidget(
              // title: 'homePage.title3'.tr().toString(),
              title:"Doctor Speciality",
            ),
            isLoadingDoctorCategory
                ? Center(
                    child: Image.asset(
                      'assets/images/loader.gif',
                      height: 100,
                    ),
                  )
                : SizedBox(
                    height: 195,
                    child: ListView.builder(
                        itemCount: (doctorCategoryData.items ?? []).length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 10, bottom: 5),
                        itemBuilder: (context, index) {
                          var info = (doctorCategoryData.items ?? [])[index];
                          var doctors = info.doctor;
                          for (int i = 0; i < (doctors ?? []).length; i++) {
                            var doctor = (doctors ?? [])[i];
                            doctor.deptNM = info.deptName;
                            doctor.deptN0 = info.deptNo;
                          }

                          return InkWell(
                            child: DoctorSpeciality(
                              speciallityNo: info.deptNo.toString(),
                              title: info.deptName,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorListPage(
                                    doctorListByCategory:
                                        doctors, //getAllDrList()
                                    allDoctorList: getAllDrList(), //
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ),

            /* ::::::::::::::::::::::::::::::::: TIPS AND TRICKS ::::::::::::::::::::::::::::::::: */
            const SizedBox(height: 10),
            const TitleWidget(title: 'Health Education'),
            isLoadingVideo
                ? Center(
                    child: Image.asset('assets/images/loader.gif', height: 100))
                : SizedBox(
                    height: 170,
                    child: ListView.builder(
                        itemCount: (videoData.pRETRNMSG1 ?? []).length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 10),
                        itemBuilder: (context, index) {
                          var videoInfo = (videoData.pRETRNMSG1 ?? [])[index];
                          return TipsAndTricks(
                            videoUrl: videoInfo.vidUrl,
                            videoTitle: videoInfo.vidTitle,
                            videoDuration: videoInfo.vidDuration,
                          );
                        }),
                  ),
          const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

}
