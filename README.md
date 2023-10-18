A Blockchain server app built using [Shelf](https://pub.dev/packages/shelf),
configured to enable running with [Docker](https://www.docker.com/).

This sample code handles HTTP GET requests to `/` and `/echo/<message>`

# Running the First Dart Blockchain Node/Server

## Running with the Dart SDK

You can run the example with the [Dart SDK](https://dart.dev/get-dart)
like this:

```
$ dart run bin/server.dart
Server listening on port 8886
```

And then from a second terminal:
```
$ dart run bin/client.dart


```
$ docker build . -t myserver
$ docker run -it -p 8886:8886 myserver
Server listening on port 8886
```

And then from a second terminal:
```
$ curl http://0.0.0.0:8886
Hello, World!
$ curl http://0.0.0.0:8886/echo/I_love_Dart
I_love_Dart
```

You should see the logging printed in the first terminal:
```
2021-05-06T15:47:04.620417  0:00:00.000158 GET     [200] /
2021-05-06T15:47:08.392928  0:00:00.001216 GET     [200] /echo/I_love_Dart
```
