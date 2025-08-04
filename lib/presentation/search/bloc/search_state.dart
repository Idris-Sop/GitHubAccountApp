// presentation/search/bloc/search_state.dart
import 'package:equatable/equatable.dart';
import 'package:github_account_app/data/models/github_user.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<GitHubUser> users;
  final List<String> recentSearches;

  const SearchSuccess({
    required this.users,
    required this.recentSearches,
  });

  @override
  List<Object?> get props => [users, recentSearches];

  SearchSuccess copyWith({
    List<GitHubUser>? users,
    List<String>? recentSearches,
  }) {
    return SearchSuccess(
      users: users ?? this.users,
      recentSearches: recentSearches ?? this.recentSearches,
    );
  }
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}

class RecentSearchesLoaded extends SearchState {
  final List<String> recentSearches;

  const RecentSearchesLoaded(this.recentSearches);

  @override
  List<Object?> get props => [recentSearches];
}