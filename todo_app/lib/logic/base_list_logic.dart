abstract class BaseTaskListLogic {
  Future<void> createList(String uid, String listName);

  Future<void> removeList(String uid, String listName);

  Future<int> listLength(String uid, String listName);
}
