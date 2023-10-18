
import 'package:blockchain_node/shared.dart';
import 'package:blockchain_node/utils/shelf_response_extentsion.dart';
import 'package:shelf/shelf.dart';

Future<Response> newTransaction(Request req) async {
  var data = (await req.getJsonBody()) as Map<String, dynamic>;

  // Check that the required fields are in the POST'ed data
  List<String> requiredData = ['privateKey', 'sender', 'recipient', 'amount'];
  for (var k in requiredData) {
    if (!data.containsKey(k)) {
      return FixedResp.badRequest('Missing values');
    }
  }

  // Create a new Transaction
  int index = blockchain.newTransaction(
    data['privateKey'],
    data['sender'],
    data['recipient'],
    data['amount'],
  );

  return FixedResp.created('Transaction will be added to Block $index', index);
}