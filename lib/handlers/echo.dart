
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Response echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}
