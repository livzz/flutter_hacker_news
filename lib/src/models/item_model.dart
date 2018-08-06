import 'dart:convert';

class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] ?? false,
        type = parsedJson['type'],
        by = parsedJson['by'],
        time = parsedJson['time'],
        text = parsedJson['text'] ?? '',
        dead = parsedJson['dead'] ?? false,
        parent = parsedJson['parent'],
        kids = parsedJson['kids'] ?? [],
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'];

  ItemModel.fromDb(Map<String, dynamic> dataSet)
      : id = dataSet['id'],
        deleted = dataSet['deleted'] == 1,
        type = dataSet['type'],
        by = dataSet['by'],
        time = dataSet['time'],
        text = dataSet['text'],
        dead = dataSet['dead'] == 1,
        parent = dataSet['parent'],
        kids = jsonDecode(dataSet['kids']),
        url = dataSet['url'],
        score = dataSet['score'],
        title = dataSet['title'],
        descendants = dataSet['descendants'];

  Map<String, dynamic> toMap() {
    return <String, dynamic> {
      "id": id,
      "type": type,
      "by" : by,
      "time": time,
      "text": text,
      "parent": parent,
      "url" : url,
      "score": score,
      "title": title,
      "descendants": descendants,
      "dead": dead ? 1 : 0,
      "deleted" : deleted ? 1 : 0,
      "kids" : jsonEncode(kids)
    };
  }
}
