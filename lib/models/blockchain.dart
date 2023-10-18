abstract class Blockchain {
  factory Blockchain() => BlockchainImpl();

  static final List chain = [];
  static final List currentTransactions = [];

  /// Creates a new Block and adds it to the chain
  newBlock();

  /// Adds a new transaction to the list of transactions
  ///
  /// Creates a new transaction to go into the next mined Block
  /// param sender: <str> Address of the Sender
  /// param recipient: <str> Address of the Recipient
  /// param amount: <int> Amount
  /// return: <int> The index of the Block that will hold this transaction
  int newTransaction(sender, recipient, amount);

  /// Hashes a Block
  static hash(block) {}

  /// Returns the last Block in the chain
  dynamic get lastBlock;
}

class BlockchainImpl implements Blockchain {
  @override
  // TODO: implement lastBlock
  get lastBlock => throw UnimplementedError();

  @override
  newBlock() {
    // TODO: implement newBlock
    throw UnimplementedError();
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
}
