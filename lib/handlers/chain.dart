

import 'package:blockchain_node/models/blockchain.dart';
import 'package:blockchain_node/utils/shelf_response_extentsion.dart';
import 'package:shelf/shelf.dart';

Response chain(Request req) {
  Map<String, dynamic> chainData = {
    'chain': Blockchain.chain,
    'length': Blockchain.chain.length,
  };
  return FixedResp.okM('OK', chainData);
}
