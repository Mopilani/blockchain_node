class Block {
  Block({
    required this.minedBy,
    required this.transactions,
    required this.height,
    required this.difficulty,
    required this.hash,
    required this.previousHash,
    required this.nonce,
    required this.timestamp,
  });

  String minedBy;
  String transactions;
  int height;
  String difficulty;
  String hash;
  String previousHash;
  String nonce;
  int timestamp;

  Map<String, dynamic> asMap() {
    return {
      'minedBy': minedBy,
      'transactions': transactions,
      'height': height,
      'difficulty': difficulty,
      'hash': hash,
      'previousHash': previousHash,
      'nonce': nonce,
      'timestamp': timestamp,
    };
  }

  static Block fromMap(Map<String, dynamic> data) {
    return Block(
      minedBy: data['minedBy'],
      transactions: data['transactions'],
      height: data['height'],
      difficulty: data['difficulty'],
      hash: data['hash'],
      previousHash: data['previousHash'],
      nonce: data['nonce'],
      timestamp: data['timestamp'],
    );
  }
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

  Map<String, dynamic> asMap() {
    return {
      'ip': ip,
      'port': port,
      'lastSeen': lastSeen,
    };
  }

  static Peer fromMap(Map<String, dynamic> data) {
    return Peer(
      data['ip'],
      data['port'],
      data['lastSeen'],
    );
  }
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

  Map<String, dynamic> asMap() {
    return {
      'blockHeight': blockHeight,
      'peerCount': peerCount,
      'isMiner': isMiner,
    };
  }

  static Ping fromMap(Map<String, dynamic> data) {
    return Ping(
      data['blockHeight'],
      data['peerCount'],
      data['isMiner'],
    );
  }
}

class Transaction {
  Transaction({
    required this.hash,
    required this.sender,
    required this.receiver,
    required this.signature,
    required this.timestamp,
    required this.amount,
  });

  String hash;
  String sender;
  String receiver;
  String signature;
  int timestamp;
  double amount;

  Map<String, dynamic> asMap() {
    return {
      'hash': hash,
      'sender': sender,
      'receiver': receiver,
      'signature': signature,
      'timestamp': timestamp,
      'amount': amount,
    };
  }

  static Transaction fromMap(Map<String, dynamic> data) {
    return Transaction(
      hash: data['hash'],
      sender: data['sender'],
      receiver: data['receiver'],
      signature: data['signature'],
      timestamp: data['timestamp'],
      amount: data['amount'],
    );
  }
}
