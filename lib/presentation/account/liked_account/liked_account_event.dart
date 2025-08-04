// presentation/account/liked_account_event.dart
import 'package:equatable/equatable.dart';
import 'package:github_account_app/data/models/github_user.dart';

abstract class LikedAccountsEvent extends Equatable {
  const LikedAccountsEvent();

  @override
  List<Object?> get props => [];
}

class LoadLikedAccounts extends LikedAccountsEvent {}

class AddLikedAccount extends LikedAccountsEvent {
  final GitHubUser user;

  const AddLikedAccount(this.user);

  @override
  List<Object?> get props => [user];
}

class RemoveLikedAccount extends LikedAccountsEvent {
  final String login;

  const RemoveLikedAccount(this.login);

  @override
  List<Object?> get props => [login];
}

class CheckIfLiked extends LikedAccountsEvent {
  final String login;

  const CheckIfLiked(this.login);

  @override
  List<Object?> get props => [login];
}