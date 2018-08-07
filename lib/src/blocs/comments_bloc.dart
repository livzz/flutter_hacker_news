import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../models/item_model.dart';
import '../resources/repository.dart';

class CommentsBloc {
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _repo = Repository();

  // Stream
  Observable<Map<int, Future<ItemModel>>> get itemWithComments =>
      _commentsOutput.stream;

  // Sink
  Function(int) get fetchItemWithComment => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }

  StreamTransformer<int, Map<int, Future<ItemModel>>> _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (cache, int id, index) {
        print(index);
        cache[id] = _repo.fetchItem(id);
        cache[id].then((ItemModel item){
          item.kids.forEach((kidId) => fetchItemWithComment(kidId));
        });
        return cache;
      },
      <int, Future<ItemModel>>{},
    );
  }



}
