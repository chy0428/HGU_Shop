import 'package:firebase_database/firebase_database.dart';

class Post_favorite {
  String key;
  String store_name;
  String index;
  String userid;
  String isfavorite;

  Post_favorite(this.store_name, this.index, this.userid, this.isfavorite);

  Post_favorite.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        store_name = snapshot.value["store_name"],
        index = snapshot.value["index"],
        userid = snapshot.value["userid"],
        isfavorite = snapshot.value["isfavorite"];

  toJson() {
    return {"store_name": store_name,"index": index, "userid": userid, "isfavorite": isfavorite};
  }
}