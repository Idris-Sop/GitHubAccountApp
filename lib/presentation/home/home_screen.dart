// presentation/home/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_account_app/presentation/account/liked_account/liked_account_bloc.dart';
import 'package:github_account_app/presentation/account/liked_account/liked_account_event.dart';
import 'package:github_account_app/presentation/account/liked_account/liked_account_state.dart';
import 'package:github_account_app/presentation/account/account_widget.dart';
import 'package:github_account_app/presentation/search/github_search_delegate.dart';
import 'package:github_account_app/presentation/account/account_details/account_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LikedAccountsBloc>().add(LoadLikedAccounts());
  }

  Future<void> _handleSearch() async {
    if (!mounted) return;
    final selectedUsername = await showSearch(
      context: context,
      delegate: GitHubSearchDelegate(),
    );
    if (selectedUsername != null && selectedUsername.isNotEmpty && mounted) {
      print("SHOW ACCOUNT DETAILS");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AccountDetailsScreen(
            username: selectedUsername,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Accounts'),
        backgroundColor: Colors.grey[100],
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _handleSearch,
          ),
        ],
      ),
      body: BlocBuilder<LikedAccountsBloc, LikedAccountsState>(
        builder: (context, state) {
          if (state is LikedAccountsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LikedAccountsLoaded) {
            if (state.likedAccounts.isEmpty) {
              return _buildEmptyState();
            }
            return _buildLikedAccountsList(state.likedAccounts);
          } else if (state is LikedAccountsError) {
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
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LikedAccountsBloc>().add(LoadLikedAccounts());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No liked accounts yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Search for GitHub accounts and like your favorites',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _handleSearch,
            icon: const Icon(Icons.search),
            label: const Text('Search Accounts'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLikedAccountsList(List<dynamic> likedAccounts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Your Liked Accounts',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: likedAccounts.length,
            itemBuilder: (context, index) {
              final user = likedAccounts[index];
              return AccountWidget(
                user: user,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountDetailsScreen(
                        username: user.login,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}