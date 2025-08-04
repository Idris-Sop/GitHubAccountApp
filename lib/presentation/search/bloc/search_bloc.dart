// presentation/search/bloc/search_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_account_app/data/services/github_api_service.dart';
import 'package:github_account_app/data/services/shared_preferences_service.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GitHubApiService _apiService = GitHubApiService();
  final SharedPreferencesService _prefsService = SharedPreferencesService();

  SearchBloc() : super(SearchInitial()) {
    on<SearchUsers>(_onSearchUsers);
    on<LoadRecentSearches>(_onLoadRecentSearches);
    on<ClearRecentSearches>(_onClearRecentSearches);
  }

  Future<void> _onSearchUsers(SearchUsers event, Emitter<SearchState> emit) async {
    emit(SearchLoading());

    try {
      final users = await _apiService.searchUsers(event.query);
      await _prefsService.addRecentSearch(event.query);
      final recentSearches = await _prefsService.getRecentSearches();

      emit(SearchSuccess(users: users, recentSearches: recentSearches));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  Future<void> _onLoadRecentSearches(LoadRecentSearches event, Emitter<SearchState> emit) async {
    try {
      final recentSearches = await _prefsService.getRecentSearches();
      emit(RecentSearchesLoaded(recentSearches));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  Future<void> _onClearRecentSearches(ClearRecentSearches event, Emitter<SearchState> emit) async {
    try {
      await _prefsService.clearRecentSearches();
      emit(RecentSearchesLoaded([]));
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }
}