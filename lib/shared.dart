import 'package:blockchain_node/models/blockchain.dart';
import 'package:uuid/uuid.dart';

String nodeIdentifier = Uuid().v4().replaceAll('-', '');

// # Instantiate the Blockchain
late Blockchain blockchain;
