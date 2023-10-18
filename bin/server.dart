import 'dart:io';
import 'dart:typed_data';

import 'package:blockchain_node/models/blockchain.dart';
import 'package:blockchain_node/router.dart';
import 'package:blockchain_node/services/mongo_db.dart';
import 'package:blockchain_node/shared.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

void main(List<String> args) async {
  service = MongoService(dbURI: 'mongodb://localhost:27017/batarina');
  await service.initial();
  db = service.db;

  blockchain = Blockchain();
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.fromRawAddress(Uint8List.fromList([0, 0, 0, 0]));

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8886');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
