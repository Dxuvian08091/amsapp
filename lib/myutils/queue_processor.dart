import 'dart:convert';

import "package:amsapp/models/Queue.dart";
import 'package:amsapp/myutils/constant.dart';
import 'package:amsapp/myutils/preference.dart';
import "package:amsapp/webservice/ApiService.dart";
import 'package:amsapp/webservice/ResponseWrapper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'logger.dart';

class QueueProcessor {
  static bool processor() {
    List<Queue> q = [
      Queue(
          method: "POST",
          url: "",
          id: 0,
          data: "{name: 'Dikshyanta'}",
          status: "Pending"),
      Queue(
          method: "GET",
          url: "",
          id: 1,
          data: "{name: 'Dikshyanta1'}",
          status: "Pending"),
      Queue(
          method: "UPDATE",
          url: "",
          id: 2,
          data: "{name: 'Dikshyanta2'}",
          status: "Pending"),
      Queue(
          method: "DELETE",
          url: "",
          id: 3,
          data: "{name: 'Dikshyanta3'}",
          status: "Pending"),
      Queue(
          method: "PUT",
          url: "",
          id: 4,
          data: "{name: 'Dikshyanta4'}",
          status: "Pending")
    ];

    String queueLogs = Queue.encode(q);

    Preference.setString('queueLogs', queueLogs);

    Logger.printLog(Preference.getString('queueLogs'));

    List<Queue> queue = Queue.decode(queueLogs);

    queue.map((item) => Logger.printLog(item.toString()));
    String token = Preference.getString(Constant.spAccessToken);

    for (Queue item in queue) {
      Map<String, dynamic> body = jsonDecode(item.data);
      if (item.method == "POST" && item.status == "Pending") {
        ApiProvider().post(item.url, body).then((reswrapper) => {
              if (reswrapper.status == ResponseWrapper.COMPLETED)
                {
                  item.status = "Success",
                }
            });
      } else if (item.method == "PUT" && item.status == "Pending") {
        ApiProvider().put(item.url, item.id, body, token).then((reswrapper) => {
              if (reswrapper.status == ResponseWrapper.COMPLETED)
                {
                  item.status = "Success",
                }
            });
      } else if (item.method == "DELETE" && item.status == "Pending") {
        ApiProvider().put(item.url, item.id, body, token).then((reswrapper) => {
              if (reswrapper.status == ResponseWrapper.COMPLETED)
                {
                  item.status = "Success",
                }
            });
      }
      if (item.status == "Success") {
        queue.remove(item);
      }
    }
    String qPendingLogs = Queue.encode(queue);
    Preference.setString('queueLogs', qPendingLogs);
    return true;
  }
}
