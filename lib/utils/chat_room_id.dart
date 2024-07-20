String chatRoomId({required String id1, required String id2}) {
  List ids = [id1, id2];
  ids.sort();
  String roomId = ids.fold(
    "",
    (id, uid) => "$id$uid",
  );
  return roomId;
}
