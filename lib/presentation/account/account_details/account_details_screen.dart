// presentation/account/account_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_account_app/presentation/account/account_details/bloc/account_details_bloc.dart';
import 'package:github_account_app/presentation/account/account_details/bloc/account_details_event.dart';
import 'package:github_account_app/presentation/account/account_details/bloc/account_details_state.dart';
import 'package:github_account_app/data/models/github_user.dart';
import 'package:github_account_app/data/models/github_repository.dart';

class AccountDetailsScreen extends StatefulWidget {
  final String username;

  const AccountDetailsScreen({
    super.key,
    required this.username,
  });

  @override
  State<AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<AccountDetailsScreen> {
  GitHubUser? user;
  List<GitHubRepository> repositories = [];

  @override
  void initState() {
    super.initState();
    context.read<AccountDetailsBloc>().add(LoadAccountDetails(widget.username));
    context.read<AccountDetailsBloc>().add(LoadAccountRepositories(widget.username));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
        backgroundColor: Colors.grey[100],
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: BlocListener<AccountDetailsBloc, AccountDetailsState>(
        listener: (context, state) {
          if (state is UserDetailsLoaded) {
            setState(() {
              user = state.user;
            });
          } else if (state is RepositoriesLoaded) {
            setState(() {
              repositories = state.repositories;
            });
          }
        },
        child: BlocBuilder<AccountDetailsBloc, AccountDetailsState>(
          builder: (context, state) {
            if (state is AccountDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AccountDetailsError) {
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
                        context.read<AccountDetailsBloc>().add(LoadAccountDetails(widget.username));
                        context.read<AccountDetailsBloc>().add(LoadAccountRepositories(widget.username));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  if (user != null) _buildUserInfo(user!),
                  const SizedBox(height: 16),
                  _buildRepositoriesSection(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserInfo(GitHubUser user) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: user.avatar_url != null
                      ? NetworkImage(user.avatar_url!)
                      : null,
                  child: user.avatar_url == null
                      ? Text(
                    user.login[0].toUpperCase(),
                    style: const TextStyle(fontSize: 24),
                  )
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.login,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (user.login != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          user.login.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: user.type == 'User' ? Colors.blue : Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          user.type.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (user.created_at != null) ...[
              const SizedBox(height: 16),
              Text(
                'Member since ${_formatDate(user.created_at!)}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildRepositoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Repositories (${repositories.length})',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}