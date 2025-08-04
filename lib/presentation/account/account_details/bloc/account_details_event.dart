// presentation/account/account_event_bloc.dart
import 'package:equatable/equatable.dart';

abstract class AccountDetailsEvent extends Equatable {
  const AccountDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadAccountDetails extends AccountDetailsEvent {
  final String username;

  const LoadAccountDetails(this.username);

  @override
  List<Object?> get props => [username];
}

class LoadAccountRepositories extends AccountDetailsEvent {
  final String username;

  const LoadAccountRepositories(this.username);

  @override
  List<Object?> get props => [username];
}