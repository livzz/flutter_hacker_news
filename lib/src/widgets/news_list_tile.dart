import 'dart:async';

import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/stories_provide.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;
  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return StreamBuilder(
      stream: bloc.items,
      builder: (context,AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot){
        if(!snapshot.hasData){
          return Text("Stream sill Loading");
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel>itemSnapshot){
            if(!itemSnapshot.hasData){
              return Text("Still loading item $itemId");
            }
            return Text("The item is ${itemSnapshot.data.title}");
          },
        );

      },
    );
  }
}