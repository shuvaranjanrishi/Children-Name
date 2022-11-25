import 'package:children_name/database/db_helper.dart';

class NameModel {
  int? id;
  String? name;
  String? meaning;
  bool? isFavorite;
  bool expanded = false;

  NameModel(this.id, this.name, this.meaning, isFavorite, this.expanded);

  NameModel.fromMap(Map<String, dynamic> map) {
    id = map[DBHelper.colId];
    name = map[DBHelper.colName];
    meaning = map[DBHelper.colMeaning];
    isFavorite = map[DBHelper.colFavorite] == 0 ? false : true;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (id != null) {
      map[DBHelper.colId] = id;
    }

    map[DBHelper.colName] = name;
    map[DBHelper.colMeaning] = meaning;
    map[DBHelper.colFavorite] = isFavorite;

    return map;
  }
}
