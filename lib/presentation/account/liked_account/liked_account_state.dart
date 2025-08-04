// presentation/account/liked_account_state.dart
import 'package:equatable/equatable.dart';
import 'package:github_account_app/data/models/github_user.dart';

abstract class LikedAccountsState extends Equatable {
  const LikedAccountsState();

  @override
  List<Object?> get props => [];
}

class LikedAccountsInitial extends LikedAccountsState {}

class LikedAccountsLoading extends LikedAccountsState {}

class LikedAccountsLoaded extends LikedAccountsState {
  final List<GitHubUser> likedAccounts;

  const LikedAccountsLoaded(this.likedAccounts);

  @override
  List<Object?> get props => [likedAccounts];
}

class LikedAccountsError extends LikedAccountsState {
  final String message;

  const LikedAccountsError(this.message);

  @override
  List<Object?> get props => [message];
}

class AccountLikedStatus extends LikedAccountsState {
  final String login;
  final bool isLiked;

  const AccountLikedStatus({
    required this.login,
    required this.isLiked,
  });

  @override
  List<Object?> get props => [login, isLiked];
}