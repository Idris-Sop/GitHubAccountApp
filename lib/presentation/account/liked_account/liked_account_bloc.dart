// presentation/account/liked_account_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'liked_account_event.dart';
import 'liked_account_state.dart';
import 'package:github_account_app/data/database/database_helper.dart';

class LikedAccountsBloc extends Bloc<LikedAccountsEvent, LikedAccountsState> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  LikedAccountsBloc() : super(LikedAccountsInitial()) {
    on<LoadLikedAccounts>(_onLoadLikedAccounts);
    on<AddLikedAccount>(_onAddLikedAccount);
    on<RemoveLikedAccount>(_onRemoveLikedAccount);
    on<CheckIfLiked>(_onCheckIfLiked);
  }

  Future<void> _onLoadLikedAccounts(LoadLikedAccounts event, Emitter<LikedAccountsState> emit) async {
    emit(LikedAccountsLoading());

    try {
      final likedAccounts = await _databaseHelper.getLikedAccounts();
      emit(LikedAccountsLoaded(likedAccounts));
    } catch (e) {
      emit(LikedAccountsError(e.toString()));
    }
  }

  Future<void> _onAddLikedAccount(AddLikedAccount event, Emitter<LikedAccountsState> emit) async {
    try {
      await _databaseHelper.insertLikedAccount(event.user);
      final likedAccounts = await _databaseHelper.getLikedAccounts();
      emit(LikedAccountsLoaded(likedAccounts));
    } catch (e) {
      emit(LikedAccountsError(e.toString()));
    }
  }

  Future<void> _onRemoveLikedAccount(RemoveLikedAccount event, Emitter<LikedAccountsState> emit) async {
    try {
      await _databaseHelper.removeLikedAccount(event.login);
      final likedAccounts = await _databaseHelper.getLikedAccounts();
      emit(LikedAccountsLoaded(likedAccounts));
    } catch (e) {
      emit(LikedAccountsError(e.toString()));
    }
  }

  Future<void> _onCheckIfLiked(CheckIfLiked event, Emitter<LikedAccountsState> emit) async {
    try {
      final isLiked = await _databaseHelper.isAccountLiked(event.login);
      emit(AccountLikedStatus(login: event.login, isLiked: isLiked));
    } catch (e) {
      emit(LikedAccountsError(e.toString()));
    }
  }
}