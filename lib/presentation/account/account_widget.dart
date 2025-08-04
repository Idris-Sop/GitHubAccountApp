// presentation/account/account_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_account_app/data/models/github_user.dart';
import 'liked_account/liked_account_bloc.dart';
import 'liked_account/liked_account_event.dart';
import 'liked_account/liked_account_state.dart';

class AccountWidget extends StatefulWidget {
  final GitHubUser user;
  final VoidCallback? onTap;

  const AccountWidget({
    super.key,
    required this.user,
    this.onTap,
  });

  @override
  State<AccountWidget> createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  bool? _isLiked;

  @override
  void initState() {
    super.initState();
    _checkLikedStatus();
  }

  void _checkLikedStatus() {
    context.read<LikedAccountsBloc>().add(CheckIfLiked(widget.user.login));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LikedAccountsBloc, LikedAccountsState>(
      listener: (context, state) {
        if (state is AccountLikedStatus && state.login == widget.user.login) {
          setState(() {
            _isLiked = state.isLiked;
          });
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: widget.user.avatar_url != null
                ? NetworkImage(widget.user.avatar_url!)
                : null,
            child: widget.user.avatar_url == null
                ? Text(widget.user.login[0].toUpperCase())
                : null,
          ),
          title: Text(
            widget.user.login,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.user.login != null)
                Text(widget.user.login!),
              Text(
                'Type: ${widget.user.type}',
                style: TextStyle(
                  color: widget.user.type == 'User' ? Colors.blue : Colors.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  _isLiked == true ? Icons.favorite : Icons.favorite_border,
                  color: _isLiked == true ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  if (_isLiked == true) {
                    context.read<LikedAccountsBloc>().add(
                      RemoveLikedAccount(widget.user.login),
                    );
                  } else {
                    context.read<LikedAccountsBloc>().add(
                      AddLikedAccount(widget.user),
                    );
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: widget.onTap,
              ),
            ],
          ),
          onTap: widget.onTap,
        ),
      ),
    );
  }
}