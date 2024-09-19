import 'dart:io';

String read(String filename) {
  return File('test/fixtures/$filename').readAsStringSync();
}
