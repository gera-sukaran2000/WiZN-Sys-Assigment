import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:wizn_system/helper/dbHelper.dart';

class Item {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Item(
      {required this.albumId,
      required this.id,
      required this.title,
      required this.thumbnailUrl,
      required this.url});
}

class ModelList with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get allItems {
    return [..._items];
  }

  Future<void> FetchData() async {
    print('i am in api fetching');
    var url = Uri.parse('https://jsonplaceholder.typicode.com/photos');
    List<Item> fetchedData = [];
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as List<dynamic>;
    extractedData.forEach((element) {
      fetchedData.add(Item(
          albumId: element['albumId'],
          id: element['id'],
          title: element['title'],
          thumbnailUrl: element['thumbnailUrl'],
          url: element['url']));
    });
    _items = fetchedData;
    for (var singleItem in fetchedData) {
      DBHelper.insertData('WiZN_Data', {
        'albumId': singleItem.albumId,
        'id': singleItem.id,
        'title': singleItem.title,
        'url': singleItem.url,
        'thumbnailUrl': singleItem.thumbnailUrl,
      });
    }
  }

  Future<void> fetchDataFromDb() async {
    print('i am in db fetching');
    final dataList = await DBHelper.fetchingData('WiZN_Data');
    _items = dataList
        .map((singleItem) => Item(
            albumId: singleItem['albumId'],
            id: singleItem['id'],
            title: singleItem['title'],
            thumbnailUrl: singleItem['thumbnailUrl'],
            url: singleItem['url']))
        .toList();
    notifyListeners();
  }

  Item getsingleItem(int id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void removeItem(int id) async {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    final result = await DBHelper.deleteData(id);
    print(result);
  }
}
