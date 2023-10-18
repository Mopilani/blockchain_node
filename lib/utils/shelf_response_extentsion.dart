import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

import 'body_kvs.dart';

extension Body on Request {
  Future<String> getBody() async {
    var dataStream = read();
    List<int> bytes = [];
    await dataStream.listen((chunk) => bytes.addAll(chunk)).asFuture();
    return utf8.decode(bytes);
  }

  Future<dynamic> getJsonBody() async => json.decode(await readAsString());
}

class FixedResp {
  static Response okM(String message, Object? result,
      [bool isDataStream = false]) {
    return Response(
      HttpStatus.ok,
      body: json.encode({
        DbBodykvs.message: message,
        DbBodykvs.result: result,
      }),
    );
  }

  static Response okStream(String message, Stream<List<int>> result,
      [Map<String, String> headers = const {}]) {
    return Response(
      HttpStatus.ok,
      headers: headers,
      body: result,
    );
  }

  static Response response(int statusCode, String message, Object? result) {
    return Response(
      statusCode,
      body: json.encode({
        DbBodykvs.message: message,
        DbBodykvs.result: result,
      }),
    );
  }

  static Response badRequest(String message) {
    return Response(
      HttpStatus.badRequest,
      body: json.encode({
        DbBodykvs.message: message,
      }),
    );
  }

  static Response serverError(String message, [Object? error]) {
    return Response(
      HttpStatus.internalServerError,
      body: json.encode({
        DbBodykvs.message: message,
        DbBodykvs.error: error.toString(),
      }),
    );
  }

  static Response notFound(String message) {
    return Response(
      HttpStatus.notFound,
      body: json.encode({
        DbBodykvs.message: message,
      }),
    );
  }

  static Response unauthorized(String message) {
    return Response(
      HttpStatus.unauthorized,
      body: json.encode({
        DbBodykvs.message: message,
      }),
    );
  }
}
