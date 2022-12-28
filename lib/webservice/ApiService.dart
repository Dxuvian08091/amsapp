// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

import 'package:amsapp/myutils/logger.dart';
import 'package:amsapp/webservice/ResponseWrapper.dart';

class ApiProvider {
  static const String _baseUrl = "http://192.168.1.7:8000";
  static const String _apiController = "$_baseUrl/api/";

  //APIs
  static const String loginApi = "${_apiController}token/";
  static const String refreshTokenApi = "${_apiController}token/refresh/";
  static const String usersApi = "${_apiController}users/";
  static const String personsApi = "${_apiController}persons/";
  static const String createPersonApi = "${_apiController}persons/create/";
  static const String rolesApi = "${_apiController}roles/";

  static const String attendancesApi = "${_apiController}attendances/";
  static const String profileApi = "${_apiController}profile/";
  static const String presentApi = "${attendancesApi}present/";
  static const String absentApi = "${attendancesApi}leave/";

  Future<dynamic> get(String url) async {
    Logger.printLog("API : GET $url");
    ResponseWrapper responseJson;
    try {
      final response = await http.get(Uri.parse(url));
      responseJson = _response(response);
    } on SocketException {
      return ResponseWrapper(
          ResponseWrapper.ERROR, null, 'No Internet connection');
    }
    return responseJson;
  }

  Future<ResponseWrapper> post(String url, Map<String, dynamic> body) async {
    Logger.printLog("API: POST $url\nPOST: ${json.encode(body)}");
    ResponseWrapper responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "accept": "application/json",
        },
        encoding: Encoding.getByName("utf-8"),
      );
      responseJson = _response(response);
    } on Exception catch (e) {
      Logger.printLog("API RESPONSE ex: $url\n$e");
      return ResponseWrapper(ResponseWrapper.ERROR, null, e.toString());
    }
    return responseJson;
  }

  Future<ResponseWrapper> postUpdate(
      String url, Map<String, dynamic> body, String token) async {
    Logger.printLog("API: POST $url\nPOST: ${json.encode(body)}");
    ResponseWrapper responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json; charset=UTF-8",
          "accept": "application/json",
        },
        encoding: Encoding.getByName("utf-8"),
      );
      responseJson = _response(response);
    } on Exception catch (e) {
      Logger.printLog("API RESPONSE ex: $url\n$e");
      return ResponseWrapper(ResponseWrapper.ERROR, null, e.toString());
    }
    return responseJson;
  }

  Future<ResponseWrapper> put(
      String url, int id, Map<String, dynamic> body, String token) async {
    Logger.printLog("API: PUT $url\nPUT: ${json.encode(body)}");
    ResponseWrapper responseJson;
    try {
      final response = await http.put(
        Uri.parse(url + id.toString()),
        body: json.encode(body),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json; charset=UTF-8",
          "accept": "application/json",
        },
        encoding: Encoding.getByName("utf-8"),
      );
      responseJson = _response(response);
    } on Exception catch (e) {
      Logger.printLog("API RESPONSE ex: $url\n$e");
      return ResponseWrapper(ResponseWrapper.ERROR, null, e.toString());
    }
    return responseJson;
  }

  Future<ResponseWrapper> multiPartRequest(
      String url,
      Map<String, dynamic> formData,
      Map<String, String> filePartMap,
      String token) async {
    Logger.printLog(
        "API: POST $url\nPOST: ${json.encode(formData)}\nFILE: ${json.encode(filePartMap)}");
    var postUri = Uri.parse(url);
    var request = http.MultipartRequest("POST", postUri);
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json; charset=UTF-8",
      "accept": "application/json",
    };
    Logger.printLog(headers["Authorization"].toString());
    request.headers.addEntries(headers.entries);
    for (String data in formData.keys) {
      request.fields[data] = '${formData[data]}';
    }
    for (String fileName in filePartMap.keys) {
      String filePath = '${filePartMap[fileName]}';
      if (filePath.isNotEmpty) {
        Logger.printLog("---------------------------------");
        Logger.printLog("File Name: $fileName");
        Logger.printLog("Basename: ${basename(filePath)}");
        Logger.printLog(
            "Extension: ${extension(filePath).replaceFirst(".", "").replaceFirst("jpg", "jpeg")}");
        Logger.printLog("File Size: ${File(filePath).lengthSync()}");
        Logger.printLog("---------------------------------");

        request.files.add(http.MultipartFile.fromBytes(
            fileName, File(filePath).readAsBytesSync(),
            filename: basename(filePath),
            contentType: MediaType(
                'image',
                extension(filePath)
                    .replaceFirst(".", "")
                    .replaceFirst("jpg", "jpeg"))));
      }
    }

    http.Response response =
        await http.Response.fromStream(await request.send());
    return _response(response);
  }

  ResponseWrapper _response(http.Response response) {
    Logger.printLog(
        "API RESPONSE: ${response.statusCode} -> ${response.request!.url}\n${response.body}");
    Map resMap = json.decode(response.body.toString());
    switch (response.statusCode) {
      case 200:
        if (resMap['status'].toString() == "error") {
          return ResponseWrapper(
              ResponseWrapper.ERROR, null, resMap['message']);
        } else {
          return ResponseWrapper(
              ResponseWrapper.COMPLETED, jsonEncode(resMap), "");
        }
      default:
        if (resMap.containsKey("errors")) {
          String allError = "";
          for (dynamic val in resMap['errors'].values) {
            allError = "$allError$val\n";
          }
          allError = allError.trim();
          return ResponseWrapper(
              ResponseWrapper.ERROR, response.body.toString(), allError);
        } else {
          return ResponseWrapper(ResponseWrapper.ERROR,
              response.body.toString(), resMap['message']);
        }
    }
  }
}
