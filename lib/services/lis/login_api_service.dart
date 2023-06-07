import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/config/sp_utils.dart';
import 'package:xcel_medical_center/model/lis/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class APIService {
  /*-------------------------------- LIS LOGIN --------------------------------*/
  Future lisLogin(LoginRequestModelLIS requestModel) async {
    try {
      String extUrl = 'login';
      Uri url = Uri.parse(baseUrl + extUrl);
      // String url = "http://192.168.0.54:8088/ords/ordstest/user/login";
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestModel.toJson()),
      );
      //debugPrint('body: [${response.body}]');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        log('body: [${response.body}]');
        prefs.setString('apiresp', response.body);
        return json.decode(response.body);
      } else {
        debugPrint('Invalid credentials or connection problem');
      }
    } catch (e) {
      debugPrint("e: $e");
      //return null;
    }
  }

  /*-------------------------------- HLBD DOCTOR LOGIN --------------------------------*/
  Future loginHLBDDoctor(LoginRequestModelHLBD requestModel) async {
    try {
      String extUrl = 'user/login';
      Uri url = Uri.parse(baseUrl + extUrl);
      // String url = "https://bdhealthline.net/health-line-bd-ws/api/user/login";
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestModel.toJson()),
      );
      //debugPrint('body: [${response.body}]');
      debugPrint('status code: ${response.statusCode}');
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        log('body: [${response.body}]');
        var jsonResponse = json.decode(response.body);
        SharedPref().setLoginResp(response.body);
        SharedPref().setDrName(jsonResponse['listResponse'][0]['doctorName']);
        SharedPref().setDrEmail(jsonResponse['objResponse']['userEmail']);
        SharedPref().setDrMobileNo(jsonResponse['objResponse']['mobileNo']);
        SharedPref().setDrRegNo(jsonResponse['listResponse'][0]['bmdcRegNo']);
        SharedPref().setDrDegree(jsonResponse['listResponse'][0]['degree']);
        SharedPref().setDrDept(jsonResponse['listResponse'][0]['specialityName']);
        SharedPref().setDrProfileImg(jsonResponse['listResponse'][0]['imgPath']);
        SharedPref().setDrSignImg(jsonResponse['listResponse'][0]['sigImgPath']);
        return json.decode(response.body);
      } else {
        //throw Exception('Failed to load data!');
        debugPrint('Invalid credentials or connection problem');
      }
    } catch (e) {
      debugPrint("e: $e");
      //return null;
    }
  }

  /*-------------------------------- HLBD PATIENT LOGIN --------------------------------*/
  Future loginHLBDPatient(LoginRequestModelHLBD requestModel) async {
    try {
      String extUrl = 'login';
      Uri url = Uri.parse(baseUrl + extUrl);
      // String url = "http://192.168.0.17:8888/ords/ordstest/xcel/login";
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestModel.toJson()),
      );
      //debugPrint('body: [${response.body}]');
      debugPrint('status code: ${response.statusCode}');
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        log('body: [${response.body}]');
        // var jsonResponse = json.decode(response.body);
        SharedPref().setPatientLoginResp(response.body);
        return json.decode(response.body);
      } else {
        //throw Exception('Failed to load data!');
        debugPrint('Invalid credentials or connection problem');
      }
    } catch (e) {
      debugPrint("e: $e");
      //return null;
    }
  }
}
