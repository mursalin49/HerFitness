import 'package:get/get.dart';

class TrainerListController extends GetxController {
  var selectedTab = "Near You".obs;
  var searchQuery = "".obs;

  void setTab(String tab) {
    selectedTab.value = tab;
  }

  void onSearch(String query) {
    searchQuery.value = query;
  }
}
