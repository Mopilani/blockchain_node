import 'dart:convert';

import 'package:hash/hash.dart';
import 'package:hex/hex.dart';

abstract class Blockchain {
  factory Blockchain() => BlockchainImpl();

  static final List chain = [];
  static final List currentTransactions = [];

  /// Creates a new Block and adds it to the chain
  ///
  /// Create a new Block in the Blockchain
  /// param proof: <int> The proof given by the Proof of Work algorithm
  /// param previous_hash: (Optional) <str> Hash of previous Block
  /// return: <dict> New Block
  Map<String, dynamic> newBlock(proof, [previousHash]);

  /// Adds a new transaction to the list of transactions
  ///
  /// Creates a new transaction to go into the next mined Block
  /// param sender: <str> Address of the Sender
  /// param recipient: <str> Address of the Recipient
  /// param amount: <int> Amount
  /// return: <int> The index of the Block that will hold this transaction
  int newTransaction(sender, recipient, amount);

  /// """
  /// Simple Proof of Work Algorithm:
  ///  - Find a number p' such that hash(pp') contains leading 4 zeroes, where p is the previous p'
  ///  - p is the previous proof, and p' is the new proof
  /// :param last_proof: <int>
  /// :return: <int>
  /// """
  int proofOfWork(lastProof);

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
  dynamic get lastBlock;
}

class BlockchainImpl implements Blockchain {
  BlockchainImpl() {
    newBlock(100, 1);
  }

  @override
  get lastBlock => Blockchain.chain.last;

  @override
  Map<String, dynamic> newBlock(proof, [previousHash]) {
    Map<String, dynamic> block = {
      'index': Blockchain.chain.length + 1,
      'timestamp': DateTime.timestamp(),
      'transactions': Blockchain.currentTransactions,
      'proof': proof,
      'previous_hash': previousHash ?? Blockchain.hash(Blockchain.chain[-1]),
    };

    // Reset the current list of transactions
    Blockchain.currentTransactions.clear();

    Blockchain.chain.add(block);
    return block;
  }

  @override
  int newTransaction(sender, recipient, amount) {
    Blockchain.currentTransactions.add({
      'sender': sender,
      'recipient': recipient,
      'amount': amount,
    });

    return lastBlock['index'] + 1;
  }

  @override
  int proofOfWork(lastProof) {
    int proof = 0;
    while (validProof(lastProof, proof)) {
      proof += 1;
    }

    return proof;
  }
}
