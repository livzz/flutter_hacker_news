import 'dart:async';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'repository.dart';

import '../models/item_model.dart';

const String root_url = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source {

  Client client = Client();

  Future<List<int>> fetchTopIds() async {
    final response = await client.get('$root_url/topstories.json');
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async {
    final response = await client.get('$root_url/item/$id.json');
    final ItemModel model = ItemModel.fromJson(json.decode(response.body));
    return model;
  }
}