// presentation/account/account_details_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_account_app/data/services/github_api_service.dart';
import 'account_details_event.dart';
import 'account_details_state.dart';

class AccountDetailsBloc extends Bloc<AccountDetailsEvent, AccountDetailsState> {
  final GitHubApiService _apiService = GitHubApiService();

  AccountDetailsBloc() : super(AccountDetailsInitial()) {
    on<LoadAccountDetails>(_onLoadAccountDetails);
    on<LoadAccountRepositories>(_onLoadAccountRepositories);
  }

  Future<void> _onLoadAccountDetails(LoadAccountDetails event, Emitter<AccountDetailsState> emit) async {
    emit(AccountDetailsLoading());

    try {
      final user = await _apiService.getUserDetails(event.username);
      emit(UserDetailsLoaded(user));
    } catch (e) {
      emit(AccountDetailsError(e.toString()));
    }
  }

  Future<void> _onLoadAccountRepositories(LoadAccountRepositories event, Emitter<AccountDetailsState> emit) async {
    try {
      final repositories = await _apiService.getUserRepositories(event.username);
      emit(RepositoriesLoaded(repositories));
    } catch (e) {
      emit(AccountDetailsError(e.toString()));
    }
  }
}