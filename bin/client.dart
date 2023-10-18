import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

Future<void> main(List<String> args) async {
  Future<void> newTransaction() async {
    Map<String, dynamic> newTrans = {
      "sender": "my address",
      "recipient": "someone else's address",
      "amount": 5.0,
    };
    var res = await http.post(
      Uri.parse('http://localhost:8886/transactions/new'),
      body: json.encode(newTrans),
    );

    print(res.statusCode);
    print(res.body);
  }

  Future<void> mine() async {
    var res = await http.get(
      Uri.parse('http://localhost:8886/mine'),
    );

    print(res.statusCode);
    print(res.body);
  }

  Future<void> chain() async {
    var res = await http.get(
      Uri.parse('http://localhost:8886/chain'),
    );

    print(res.statusCode);
    print(res.body);
  }

  print('Blockchain Node Client Running');
  while (true) {
    var command = stdin.readLineSync();
    if (command != null) {
      switch (command.toLowerCase()) {
        case 'newt':
          await newTransaction();
          break;
        case 'mine':
          await mine();
          break;
        case 'chain':
          await chain();
          break;
        default:
      }
    }
  }
}
