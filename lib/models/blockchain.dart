abstract class Blockchain {
  factory Blockchain() => BlockchainImpl();

  static final List chain = [];
  static final List currentTransactions = [];

  /// Creates a new Block and adds it to the chain
  newBlock();

  /// Adds a new transaction to the list of transactions
  newTransaction();

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
  newTransaction() {
    // TODO: implement newTransaction
    throw UnimplementedError();
  }
}
