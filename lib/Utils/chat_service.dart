import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> sendAndRetrieveMessage(
    {required String msg,
      required String tokin,
      required String username}) async {
  // Go to Firebase console -> Project settings -> Cloud Messaging -> copy Server key
  // the Server key will start "AAAAMEjC64Y..."

  final yourServerKey =
      "AAAAtV_0GR8:APA91bFG62X1_uZFDP7V8RK7q_UfvAuFu_fsCKksaRx3ewM95kDkrGsCHn-LYKolEqrFIcjZxiCzNfFzQ5ti18aHhQqizSOvjNuMHXGUgSbaE1jBLAK1Stj8IJZS4l98DSmkPDHSgJyf";
  await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'key=$yourServerKey',
    },
    body: jsonEncode(
      <String, dynamic>{
        'notification': <String, dynamic>{
          'body': "${msg}",
          'title': "${username}",
        },
        'priority': 'high',
        'data': <String, dynamic>{
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'id': '1',
          'status': 'done'
        },
        // FCM Token lists.
        // 'registration_ids': ["Your_FCM_Token_One", "Your_FCM_Token_Two"],
        'to': tokin
      },
    ),
  );
}