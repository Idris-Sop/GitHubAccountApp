// presentation/account/account_state_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:github_account_app/data/models/github_user.dart';
import 'package:github_account_app/data/models/github_repository.dart';

abstract class AccountDetailsState extends Equatable {
  const AccountDetailsState();

  @override
  List<Object?> get props => [];
}

class AccountDetailsInitial extends AccountDetailsState {}

class AccountDetailsLoading extends AccountDetailsState {}

class AccountDetailsLoaded extends AccountDetailsState {
  final GitHubUser user;
  final List<GitHubRepository> repositories;

  const AccountDetailsLoaded({
    required this.user,
    required this.repositories,
  });

  @override
  List<Object?> get props => [user, repositories];

  AccountDetailsLoaded copyWith({
    GitHubUser? user,
    List<GitHubRepository>? repositories,
  }) {
    return AccountDetailsLoaded(
      user: user ?? this.user,
      repositories: repositories ?? this.repositories,
    );
  }
}

class AccountDetailsError extends AccountDetailsState {
  final String message;

  const AccountDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

class UserDetailsLoaded extends AccountDetailsState {
  final GitHubUser user;

  const UserDetailsLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class RepositoriesLoaded extends AccountDetailsState {
  final List<GitHubRepository> repositories;

  const RepositoriesLoaded(this.repositories);

  @override
  List<Object?> get props => [repositories];
}