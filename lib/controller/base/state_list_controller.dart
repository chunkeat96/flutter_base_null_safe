import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'state_controller.dart';

abstract class StateListController<T> extends StateController {

  List<T> list = <T>[];

  bool refreshState = false;

  @override
  initData() async {
    setBusy(true);
    await refreshList();
  }

  refreshList() async {
    if (!refreshState) {
      refreshState = true;
      try {
        list = await loadData();
        if (list.isEmpty && viewState != ViewState.error) {
          setEmpty();
        } else {
          if (busy) {
            setBusy(false);
          } else {
            update();
          }
        }
      } catch(e, s) {
        Get.find<Logger>().e(e, e, s);
      }
      refreshState = false;
    }
  }

  // call this function no need to call update()
  Future<List<T>> loadData();
}