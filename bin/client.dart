import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> main(List<String> args) async {
  Map<String, dynamic> newTrans = {
    "sender": "my address",
    "recipient": "someone else's address",
    "amount": 5
  };
  var res = await http.post(
    Uri.parse('http://localhost:8886/transactions/new'),
    body: json.encode(newTrans),
  );

  print(res.statusCode);
  print(res.body);
}
