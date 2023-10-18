import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
// import 'package:elogger/elogger.dart';

class MongoService {
  MongoService({this.dbURI}) {
    dbURI ??= 'mongodb://localhost:27017/batarina';
  }

  late Db _db;
  Db get db => _db;

  late final String? dbURI;

  static MongoService instance = MongoService();

  Future<void> initial() async {
    await _initial();
  }

  /// an internal method will open the database
  Future<void> _initial() async {
    try {
      // creating new db (if not exists)
      _db = await Db.create(dbURI!);

      // opening the db
      await _db.open();
      // Elogger.log(r, scss: true);
    } catch (e) {
      // Elogger.log(e, err: true);
      // for test
      stderr.write(e.toString());

      // throwing a database exeption
      // DatabaseException(e);

      // rethrowing the error from this place
      rethrow;
    }
  }

  Future<void> close() async {
    try {
      // awaitin for db to close then return the Future
      await _db.close();
    } catch (e) {
      // Elogger.log(e, err: true);
      stderr.write(e.toString());
      // throwing a database exeption
      // DatabaseException(e);

      // rethrowing the error from this place
      rethrow;
    }
  }
}
