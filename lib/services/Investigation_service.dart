
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../config/common_const.dart';
import '../model/investigation.dart';
class InvestigationService{

  Future<Investigation> getInvestigations(Map body) async {
    String extUrl = "investigation";
    Uri url = Uri.parse(baseUrl + extUrl);
    debugPrint('Investigation Url : $url');

    final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body)
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      log('Investigation data retrieved successful!!!');
      return investigationFromJson(response.body);
    } else {
      log('Investigation data retrieved failed!!!');
      log(response.statusCode.toString());
      return jsonDecode(response.body);
    }
  }

  Future<Map<String, dynamic>> submitAttachmentInfo(Map body) async {
    String extUrl = "upldfile";
    Uri url = Uri.parse(baseUrl + extUrl);
    debugPrint('Attachment Url : $url');

    final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body)
    );
    if (response.statusCode == 200) {
      debugPrint(response.body);
      log('File upload successful!!!');
      return json.decode(response.body);
    } else {
      log('File upload failed!!!');
      log(response.statusCode.toString());
      return jsonDecode(response.body);
    }
  }

  Future<Map<String, dynamic>> submitAttachment(String path) async {
    var request = http.MultipartRequest('POST', Uri.parse('http://gpst.billingdil.com:8088/tourplan_ws/file/uploadFile'));
    request.files.add(await http.MultipartFile.fromPath('file', path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      debugPrint(res);
      return jsonDecode(res);
    }
    else {
      debugPrint(response.reasonPhrase);
      return jsonDecode(response.reasonPhrase??'');
    }

  }






}