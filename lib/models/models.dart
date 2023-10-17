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

  dynamic minedBy;
  dynamic transactions;
  dynamic height;
  dynamic difficulty;
  dynamic hash;
  dynamic previousHash;
  dynamic nonce;
  dynamic timestamp;
}

class Peer {
  Peer(
    this.ip,
    this.port,
    this.lastSeen,
  );

  dynamic ip;
  dynamic port;
  dynamic lastSeen;
}

class Ping {
  Ping(
    this.blockHeight,
    this.peerCount,
    this.isMiner,
  );

dynamic blockHeight;
dynamic peerCount;
dynamic isMiner;
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

  dynamic hash;
  dynamic sender;
  dynamic receiver;
  dynamic signature;
  dynamic timestamp;
  dynamic amount;
}
