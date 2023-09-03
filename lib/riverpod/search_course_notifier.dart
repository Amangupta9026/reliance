import '../utils/file_collection.dart';

final searchNotifierProvider =
    AsyncNotifierProvider.autoDispose<SearchNotifier, SearchMode>(() {
  return SearchNotifier();
});

class SearchMode {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
}

class SearchCourseNotifier extends AutoDisposeAsyncNotifier<SearchMode> {
  final SearchMode _onSearchMode = SearchMode();

  Future<void> searchCourse(String query) async {
    state = AsyncData(_onSearchMode);
  }

  @override
  build() {
    return _onSearchMode;
  }
}
