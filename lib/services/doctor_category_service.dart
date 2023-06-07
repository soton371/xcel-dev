import 'dart:convert';
import 'dart:developer';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:http/http.dart' as http;
import '../model/dept_doctor.dart';
import '../model/doctor_category_model.dart';

class DoctorCategoryService {
  Future<DoctorCategoryModel> fetchDoctorCategory() async {
    // String extUrl = 'doctor/get-all/EN';
    // Uri url = Uri.parse(baseUrl + extUrl);
    Uri url = Uri.parse("https://bdhealthline.net/health-line-bd-ws/api/doctor/get-all/EN");

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    // log(response.body);
    // log(body);
    if (response.statusCode == 200) {
      // log(response.body);
      log('Doctor category data retrived successful!!!');
      return doctorCategoryModelFromJson(response.body);
    } else {
      log('Doctor category data retrived failed!!!');
      // log(response.statusCode.toString());
      return jsonDecode(response.body);
    }
  }

  Future<DeptDoctor> getDeptWiseDoctorList() async {
    Uri url = Uri.parse('${baseUrl}deptdoctor');
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
     log(response.body);
    // log(body);
    if (response.statusCode == 200) {
      // log(response.body);
      log('Doctor category data retrived successful!!!');
      return decodeDepDoctorDataFromJson(response.body);
    } else {
      log('Doctor category data retrived failed!!!');
      // log(response.statusCode.toString());
      return jsonDecode(response.body);
    }
  }
}
