import 'dart:convert';
import 'dart:io';

import 'package:blockchain_node/shared.dart';
import 'package:hash/hash.dart';
import 'package:hex/hex.dart';
import 'package:pinenacl/ed25519.dart';

abstract class Blockchain {
  factory Blockchain() => BlockchainImpl();

  static final List chain = [];
  static final List currentTransactions = [];

  static late String target =
      'e509ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff';
  static late String firstBlockHash =
      'e509000000000000000000000000000000000000000000000000000000000000';

  /// Creates a new Block and adds it to the chain
  ///
  /// Create a new Block in the Blockchain
  /// param proof: <int> The proof given by the Proof of Work algorithm
  /// param previous_hash: (Optional) <str> Hash of previous Block
  /// return: <dict> New Block
  Map<String, dynamic> newBlock(int proof, String previousHash);

  /// Adds a new transaction to the list of transactions
  ///
  /// Creates a new transaction to go into the next mined Block
  /// param sender: <str> Address of the Sender
  /// param recipient: <str> Address of the Recipient
  /// param amount: <double> Amount
  /// return: <int> The index of the Block that will hold this transaction
  int newTransaction(
      String privateKey, String publikKey, String recipient, double amount);

  /// Verifies that a given transaction was sent from the sender
  /// param tx: The transaction dict
  /// return: <bool>
  bool validateTransaction(Map<String, dynamic> transaction);

  /// Simple Proof of Work Algorithm:
  ///  - Find a number p' such that hash(pp') contains leading 4 zeroes, where p is the previous p'
  ///  - p is the previous proof, and p' is the new proof
  /// param last_proof: <int>
  /// return: <int>
  int proofOfWork(int lastProof);

  /// Validates the Proof: Does hash(last_proof, proof) contain 4 leading zeroes?
  /// param last_proof: <int> Previous Proof
  /// param proof: <int> Current Proof
  /// return: <bool> True if correct, False if not.
  static bool validProof(int lastProof, int proof) {
    List<int> guessBytes = '$lastProof$proof'.codeUnits;
    String guessHash = HEX.encode(SHA256().update(guessBytes).digest());
    // print(guessHash);
    return guessHash.substring(0, 4) == "e509";
  }

  /// Hashes a Block
  ///
  // Creates a SHA-256 hash of a Block
  // param block: <dict> Block
  // return: <str>
  static String hash(Map<String, dynamic> block) {
    // # We must make sure that the Dictionary is Ordered, or we'll have inconsistent hashes
    List<int> blockStringBytes = json
        .encode(
          block, /*sort_keys = True*/
        )
        .codeUnits;
    return HEX.encode(SHA256().update(blockStringBytes).digest());
  }

  /// Returns the last Block in the chain
  Map<String, dynamic> get lastBlock;

  static Future<void> loadBlocks() async {
    var ds = db.collection(BlockchainImpl.collectionName).find();
    await ds.listen((block) {
      Blockchain.chain.add(block..remove('_id'));
    }).asFuture();
  }

  /// Check if a block's hash is less than the target...
  static bool validBlock(block) {
    if (BigInt.parse(block["hash"], radix: 16) <
        BigInt.parse(target, radix: 16)) {
      return true;
    }
    return false;
  }
}

class BlockchainImpl implements Blockchain {
  BlockchainImpl() {
    stdout.writeln('Creating genesis block');
    newBlock(100, '1');
  }

  static String collectionName = 'blocks';

  @override
  Map<String, dynamic> get lastBlock => Blockchain.chain.last;

  @override
  Map<String, dynamic> newBlock(int proof, String previousHash) {
    Map<String, dynamic> block = {
      'index': Blockchain.chain.length + 1,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'transactions': [...Blockchain.currentTransactions],
      'proof': proof,
      'previousHash': previousHash,
    };

    // Reset the current list of transactions
    Blockchain.currentTransactions.clear();

    Blockchain.chain.add(block);

    db.collection(collectionName).insert(block);
    return block;
  }

  @override
  int newTransaction(String privateKey, String senderPublicKey,
      String recipientPublicKey, double amount) {
    var transaction = {
      'sender': senderPublicKey,
      'recipient': recipientPublicKey,
      'amount': amount,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    };

    Blockchain.currentTransactions.add(transaction);

    List<int> transBytes = ascii.encode(json.encode(
      transaction, /*sort_keys=True*/
    ));

    // Generate a signing key from the private key
    final signingKey = SigningKey.generate();

    // Now add the signature to the original transaction
    var signature = signingKey.sign(Uint8List.fromList(transBytes));
    transaction["signature"] = HEX.encode(signature.message.toList());

    print('Transaction: $transaction');

    // return transaction;
    return lastBlock['index'] + 1;
  }

  @override
  int proofOfWork(int lastProof) {
    int proof = 0;
    while (!Blockchain.validProof(lastProof, proof)) {
      proof += 1;
    }

    return proof;
  }

  @override
  bool validateTransaction(Map<String, dynamic> transaction) {
    String publicKey = transaction["sender"];

    // We need to strip the "ignature" key from the tx
    String signature = transaction.remove("signature");
    // String signatureBytes = HEX.encode(signature.codeUnits);

    Uint8List transactionBytes = ascii.encode(json.encode(transaction));

    // Generate a verifying key from the public key
    var verifyKey = VerifyKey(Uint8List.fromList(HEX.decode(publicKey)));

    // Attempt to verify the signature
    try {
      verifyKey.verify(
        message: transactionBytes,
        signature: SignedMessage.fromList(
          signedMessage: Uint8List.fromList(signature.codeUnits),
        ).signature,
      );
    } catch (e) {
      print(e);
      return false;
    }
    // except BadSignatureError:
    return true;
  }
}
