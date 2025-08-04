// presentation/search/github_search_delegate.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_account_app/presentation/search/bloc/search_bloc.dart';
import 'package:github_account_app/presentation/search/bloc/search_event.dart';
import 'package:github_account_app/presentation/search/bloc/search_state.dart';
import 'package:github_account_app/presentation/account/account_widget.dart';

class GitHubSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Text('Enter a search term to find GitHub users'),
      );
    }

    context.read<SearchBloc>().add(SearchUsers(query));

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchSuccess) {
          if (state.users.isEmpty) {
            return Center(
              child: Text('No users found for "$query"'),
            );
          }
          return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final user = state.users[index];
              return AccountWidget(
                user: user,
                onTap: () {
                  close(context, user.login);
                },
              );
            },
          );
        } else if (state is SearchError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Error: ${state.message}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      context.read<SearchBloc>().add(LoadRecentSearches());

      return BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is RecentSearchesLoaded) {
            if (state.recentSearches.isEmpty) {
              return const Center(
                child: Text('No recent searches'),
              );
            }
            return ListView.builder(
              itemCount: state.recentSearches.length,
              itemBuilder: (context, index) {
                final search = state.recentSearches[index];
                return ListTile(
                  leading: const Icon(Icons.history),
                  title: Text(search),
                  onTap: () {
                    query = search;
                    showResults(context);
                  },
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      );
    }

    // Show search suggestions based on query
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.search),
          title: Text('Search for "$query"'),
          onTap: () {
            showResults(context);
          },
        );
      },
    );
  }

  @override
  String get searchFieldLabel => 'Search GitHub users...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
    );
  }
}