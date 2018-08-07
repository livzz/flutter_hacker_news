import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provide.dart';
import 'screens/news_detail.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'News!',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {

          final storiesBloc = StoriesProvider.of(context);
          storiesBloc.fetchTopIds();

          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (context) {
          final commentsBloc = CommentsProvider.of(context);
          final int itemId = int.parse(settings.name.split('/')[1]);
          commentsBloc.fetchItemWithComment(itemId);
          return NewsDetail(
            itemId: itemId,
          );
        },
      );
    }
  }
}
