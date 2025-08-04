class AppConfig {
  // GitHub API Configuration
  static const String baseUrl = 'https://api.github.com';
  static const String searchUsersEndpoint = '/search/users';
  static const String userDetailsEndpoint = '/users';
  static const String userReposEndpoint = '/repos';

  // TODO: Replace with your actual GitHub personal access token
  // Get your token from: https://github.com/settings/tokens
  static const String githubToken = 'PASTE_YOUR_PERSONAL_ACCESS_TOKEN_HERE';

  // Rate limiting
  static const int requestsPerHour = 60;

  // Database configuration
  static const String databaseName = 'github_accounts.db';
  static const int databaseVersion = 1;

  // Shared preferences keys
  static const String recentSearchesKey = 'recent_searches';
  static const int maxRecentSearches = 10;
}