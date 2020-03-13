import './Storage.dart';

class SearchServices {
  static setSearchData(String value) async {
    final list = await Storage.getArr('searchList');
    if (list == null) {
      List<String> tempList = [];
      tempList.insert(0, value);
      await Storage.setArr('searchList', tempList);
    } else {
      final has = list.any((v) {
        return v == value;
      });
      if (!has) {
        List<String> tempList = list;
        if (tempList.length >= 10) {
          int len = list.length;
          tempList.removeAt(len - 1);
        }
        tempList.insert(0, value);
        await Storage.setArr('searchList', tempList);
      }
    }
  }

  static getSearchData() async {
    List<String> list = await Storage.getArr('searchList') == null
        ? []
        : await Storage.getArr('searchList');
    return list;
  }

  static clearSearchData() async {
    await Storage.remove('searchList');
  }

  static clearSearchRemove(String value) async {
    List<String> tempList = await Storage.getArr('searchList');
    int index = tempList.indexOf(value);
    tempList.removeAt(index);
    await Storage.setArr('searchList', tempList);
  }
}
