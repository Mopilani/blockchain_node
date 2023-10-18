abstract class Blockchain {
  Blockchain();
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
