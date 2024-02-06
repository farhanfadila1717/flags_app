import 'dart:convert';
import 'dart:io';

import 'package:recase/recase.dart';

void main() {
  final dir = Directory('lib/ui');

  final dirList = dir.listSync(recursive: true);

  List<String> paths = [];
  for (var i in dirList) {
    final path = i.path;
    if (path.contains('.dart')) {
      paths.add(path);
    }
  }

  String listing = '';

  List<Listing> temp = List.generate(
    paths.length,
    (index) => Listing(
      paths[index],
    ),
  );

  temp.sort((a, b) => a.name.compareTo(b.name));

  for (var i in temp) {
    final file = File(i.path);

    listing += '### ${i.name}\n\n';

    final text = file.readAsStringSync();

    final lines = const LineSplitter().convert(text);

    for (var line in lines) {
      listing += line.trim();
      listing += '\n';
    }

    listing += '\n\n';
  }

  File('listing.txt').writeAsStringSync(listing);
}

class Listing {
  final String path;

  const Listing(this.path);

  String get name => ReCase(
        path.replaceAll('.dart', '').split('/').last,
      ).titleCase;
}
