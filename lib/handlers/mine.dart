import 'package:blockchain_node/models/blockchain.dart';
import 'package:blockchain_node/shared.dart';
import 'package:blockchain_node/utils/shelf_response_extentsion.dart';
import 'package:shelf/shelf.dart';

Response mine(Request req) {
  var privateKey = req.headers['privateKey'];
  var publicKey = req.headers['publicKey'];

  if (privateKey == null) {
    return FixedResp.badRequest('Please Provide You Private Key');
  }

  if (publicKey == null) {
    return FixedResp.badRequest('Please Provide You Private Key');
  }
  //  # We run the proof of work algorithm to get the next proof...
  Map<String, dynamic> lastBlock = blockchain.lastBlock;
  int lastProof = lastBlock['proof'];
  int proof = blockchain.proofOfWork(lastProof);

  //  # We must receive a reward for finding the proof.
  //  # The sender is "0" to signify that this node has mined a new coin.
  blockchain.newTransaction(privateKey, publicKey, nodeIdentifier, 1);

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
