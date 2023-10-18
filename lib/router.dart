// Configure routes.
import 'package:blockchain_node/handlers/chain.dart';
import 'package:blockchain_node/handlers/echo.dart';
import 'package:blockchain_node/handlers/mine.dart';
import 'package:blockchain_node/handlers/transactions.dart';

import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart' as sws;

final router = Router()
  ..all('/', sws.webSocketHandler)
  ..get('/mine', mine)
  ..post('/transactions/new', newTransaction)
  ..get('/chain', chain)
  ..get('/echo/<message>', echoHandler);
