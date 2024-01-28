import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../utils/local_storage.dart';
import '../utils/notification_util.dart';

class WebSocketProvider extends ChangeNotifier {
  late WebSocketChannel _channel;

  WebSocketProvider() {
    init();
  }

  WebSocketChannel get channel => _channel;

  void sendMessage(String message) {
    _channel.sink.add(message);
  }

  init() async {
    var id = await showId();
    print(id);
    var wsUrl = 'wss://casmara-request-app-api.onrender.com/ws?id=$id';
    var headers = {'Authorization': 'Ayoseun'};
    _channel = IOWebSocketChannel.connect(wsUrl, headers: headers);
    _channel.stream.listen((message) {
      print(message);

      if (message == "Connected") {
      } else if (message == "Delivered.✔️") {
        notify("Request", "Request is being $message");
      } else if (message == "Delivered.✔️✔️") {
        notify("Request", "Your Request has been $message");
      } else {
          var msg = Map<String,dynamic>.from(jsonDecode(message));

        notify("New Request from ${msg["fullName"]}", "${msg["agent"]} is needed at ${msg["propertyName"]} on ${msg["day"]} between ${msg["period"]}");
      }
    });
  }

  void closeChannel() {
    _channel.sink.close(status.goingAway);
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
