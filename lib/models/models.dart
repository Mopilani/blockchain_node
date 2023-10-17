class Block {
  Block(
    this.minedBy,
    this.transactions,
    this.height,
    this.difficulty,
    this.hash,
    this.previousHash,
    this.nonce,
    this.timestamp,
  );

  String minedBy;
  String transactions;
  int height;
  String difficulty;
  String hash;
  String previousHash;
  String nonce;
  int timestamp;
}

class Peer {
  Peer(
    this.ip,
    this.port,
    this.lastSeen,
  );

  String ip;
  int port;
  int lastSeen;
}

class Ping {
  Ping(
    this.blockHeight,
    this.peerCount,
    this.isMiner,
  );

  int blockHeight;
  int peerCount;
  bool isMiner;
}

class Transaction {
  Transaction(
    this.hash,
    this.sender,
    this.receiver,
    this.signature,
    this.timestamp,
    this.amount,
  );

  String hash;
  String sender;
  String receiver;
  String signature;
  int timestamp;
  double amount;
}
