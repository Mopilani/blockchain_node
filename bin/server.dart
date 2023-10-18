import 'dart:io';

import 'package:blockchain_node/models/blockchain.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'package:shelf_web_socket/shelf_web_socket.dart' as sws;

// Configure routes.
final _router = Router()
  ..all('/', sws.webSocketHandler)
  ..get('/mine', _mine)
  ..post('/transactions/new', _newTransaction)
  ..get('/chain', _chain)
  ..get('/echo/<message>', _echoHandler);

Response _mine(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _newTransaction(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _chain(Request req) {
  
  return Response.ok('Hello, World!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  String nodeIdentifier = Uuid().v4().replaceAll('-', '');

// # Instantiate the Blockchain
  var blockchain = Blockchain();

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
