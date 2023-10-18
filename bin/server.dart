import 'dart:io';
import 'dart:typed_data';

import 'package:blockchain_node/models/blockchain.dart';
import 'package:blockchain_node/utils/shelf_response_extentsion.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'package:shelf_web_socket/shelf_web_socket.dart' as sws;

String nodeIdentifier = Uuid().v4().replaceAll('-', '');

// # Instantiate the Blockchain
late Blockchain blockchain;

// Configure routes.
final _router = Router()
  ..all('/', sws.webSocketHandler)
  ..get('/mine', _mine)
  ..post('/transactions/new', _newTransaction)
  ..get('/chain', _chain)
  ..get('/echo/<message>', _echoHandler);

Response _mine(Request req) {
  //  # We run the proof of work algorithm to get the next proof...
  Map<String, dynamic> lastBlock = blockchain.lastBlock;
  int lastProof = lastBlock['proof'];
  int proof = blockchain.proofOfWork(lastProof);

  //  # We must receive a reward for finding the proof.
  //  # The sender is "0" to signify that this node has mined a new coin.
  blockchain.newTransaction("0", nodeIdentifier, 1);

  // # Forge the new Block by adding it to the chain
  String previousHash = Blockchain.hash(lastBlock);
  Map<String, dynamic> block = blockchain.newBlock(proof, previousHash);

  Map<String, dynamic> result = {
    'message': "New Block Forged",
    'index': block['index'],
    'transactions': block['transactions'],
    'proof': block['proof'],
    'previousHash': block['previousHash'],
  };

  return FixedResp.okM('OK', result);
}

Future<Response> _newTransaction(Request req) async {
  var data = (await req.getJsonBody()) as Map<String, dynamic>;

  // Check that the required fields are in the POST'ed data
  List<String> requiredData = ['sender', 'recipient', 'amount'];
  for (var k in requiredData) {
    if (!data.containsKey(k)) {
      return FixedResp.badRequest('Missing values');
    }
  }

  // Create a new Transaction
  int index = blockchain.newTransaction(
    data['sender'],
    data['recipient'],
    data['amount'],
  );

  return FixedResp.created('Transaction will be added to Block $index', index);
}

Response _chain(Request req) {
  Map<String, dynamic> chainData = {
    'chain': Blockchain.chain,
    'length': Blockchain.chain.length,
  };
  return FixedResp.okM('OK', chainData);
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

void main(List<String> args) async {
  blockchain = Blockchain();
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.fromRawAddress(Uint8List.fromList([0, 0, 0, 0]));

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8886');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
