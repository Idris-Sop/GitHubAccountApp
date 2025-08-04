// data/services/github_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:github_account_app/config/app_config.dart';
import 'package:github_account_app/data/models/github_user.dart';
import 'package:github_account_app/data/models/github_repository.dart';

class GitHubApiService {
  static final GitHubApiService _instance = GitHubApiService._internal();
  factory GitHubApiService() => _instance;
  GitHubApiService._internal();

  final http.Client _client = http.Client();

  Map<String, String> get _headers {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/vnd.github.v3+json',
    };

    headers['Authorization'] = 'token ${AppConfig.githubToken}';

    return headers;
  }

  Future<List<GitHubUser>> searchUsers(String query) async {
    try {
      final response = await _client.get(
        Uri.parse('${AppConfig.baseUrl}${AppConfig.searchUsersEndpoint}?q=$query'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> items = data['items'] ?? [];
        return items.map((item) => GitHubUser.fromJson(item)).toList();
      } else if (response.statusCode == 403) {
        throw Exception('Rate limit exceeded. Please try again later.');
      } else {
        throw Exception('Failed to search users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching users: $e');
    }
  }

  Future<GitHubUser> getUserDetails(String username) async {
    try {
      final response = await _client.get(
        Uri.parse('${AppConfig.baseUrl}${AppConfig.userDetailsEndpoint}/$username'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return GitHubUser.fromJson(data);
      } else if (response.statusCode == 404) {
        throw Exception('User not found');
      } else if (response.statusCode == 403) {
        throw Exception('Rate limit exceeded. Please try again later.');
      } else {
        throw Exception('Failed to get user details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting user details: $e');
    }
  }

  Future<List<GitHubRepository>> getUserRepositories(String username) async {
    try {
      final response = await _client.get(
        Uri.parse('${AppConfig.baseUrl}${AppConfig.userDetailsEndpoint}/$username${AppConfig.userReposEndpoint}'),
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => GitHubRepository.fromJson(item)).toList();
      } else if (response.statusCode == 404) {
        throw Exception('User repositories not found');
      } else if (response.statusCode == 403) {
        throw Exception('Rate limit exceeded. Please try again later.');
      } else {
        throw Exception('Failed to get user repositories: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting user repositories: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}