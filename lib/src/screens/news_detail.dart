import 'dart:async';

import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/comments_provider.dart';
import '../widgets/comment.dart';
import '../widgets/loading_container.dart';

class NewsDetail extends StatelessWidget {
  final int itemId;

  NewsDetail({@required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail View"),
      ),
      body: buildBody(CommentsProvider.of(context)),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final itemFuture = snapshot.data[itemId];

        return FutureBuilder(
          future: itemFuture,
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }

            return buildList(itemSnapshot.data, snapshot.data);
          },
        );
      },
    );
  }

  Widget buildTitle(ItemModel item) {
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> data) {
    final children = <Widget>[];
    children.add(buildTitle(item));
    final commentList = item.kids.map((kidId) {
      return Comment(
        itemId: kidId,
        indentBy: 16,
        itemMap: data,
      );
    }).toList();
    children.addAll(commentList);

    return ListView(
      children: children,
    );
  }
}
