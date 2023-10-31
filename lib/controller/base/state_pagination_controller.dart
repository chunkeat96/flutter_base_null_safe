import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'state_controller.dart';
import 'state_list_controller.dart';

abstract class StatePaginationController<T> extends StateListController<T> {

  RefreshController refreshController = RefreshController(initialRefresh: false);

  int _currentPageNum = 1;

  bool _lastPage = false;

  bool get lastPage => _lastPage;

  @override
  refreshList() async {
    if (!refreshState) {
      refreshState = true;
      list.clear();
      _lastPage = false;
      _currentPageNum = 1;
      await _getAllList();
      refreshController.refreshCompleted();
      refreshState = false;
    }
  }

  Future<void> _getAllList() async {
    try {
      final list = await loadData(pageNum: _currentPageNum);
      if (list.isEmpty) {
        if (viewState != ViewState.error) {
          _lastPage = true;
          if (_currentPageNum == 1) {
            viewState = ViewState.empty;
          } else {
            refreshController.loadNoData();
          }
        } else {
          _handleError();
        }
      } else {
        this.list.addAll(list);
      }

      if (busy) {
        setBusy(false);
      } else {
        update();
      }
    } catch(e, s) {
      _handleError();
      Get.find<Logger>().e(e, e, s);
    }
  }

  void loadNextPage() async {
    _currentPageNum++;
    await _getAllList();
    refreshController.loadComplete();
  }

  _handleError() {
    if (_currentPageNum != 1) {
      viewState = ViewState.idle;
      refreshController.loadFailed();
    } else {
      refreshController.refreshFailed();
    }
    _currentPageNum--;
  }

  @override
  Future<List<T>> loadData({int pageNum});
}