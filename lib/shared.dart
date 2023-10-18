import 'package:blockchain_node/models/blockchain.dart';
import 'package:blockchain_node/services/mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

String nodeIdentifier = Uuid().v4().replaceAll('-', '');

// # Instantiate the Blockchain
late Blockchain blockchain;

late Db db;
late MongoService service;
