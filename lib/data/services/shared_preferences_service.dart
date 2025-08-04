// data/services/shared_preferences
import 'package:shared_preferences/shared_preferences.dart';
import 'package:github_account_app/config/app_config.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instance = SharedPreferencesService._internal();
  factory SharedPreferencesService() => _instance;
  SharedPreferencesService._internal();

  Future<void> addRecentSearch(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final recentSearches = await getRecentSearches();

    // Remove if already exists to avoid duplicates
    recentSearches.remove(query);

    // Add to the beginning
    recentSearches.insert(0, query);

    // Keep only the most recent searches
    if (recentSearches.length > AppConfig.maxRecentSearches) {
      recentSearches.removeRange(AppConfig.maxRecentSearches, recentSearches.length);
    }

    await prefs.setStringList(AppConfig.recentSearchesKey, recentSearches);
  }

  Future<List<String>> getRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(AppConfig.recentSearchesKey) ?? [];
  }

  Future<void> clearRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConfig.recentSearchesKey);
  }
}