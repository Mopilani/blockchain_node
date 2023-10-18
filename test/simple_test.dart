import 'package:blockchain_node/models/blockchain.dart';
import 'package:hash/hash.dart';
import 'package:hex/hex.dart';

void main() {
  var input = SHA256().update('1'.codeUnits).digest();
  var hash = HEX.encode(input);
  var r = Blockchain.validBlock({
    'hash': hash,
  });

  print(r);
}
