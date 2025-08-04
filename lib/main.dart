// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_account_app/presentation/home/home_screen.dart';
import 'presentation/search/bloc/search_bloc.dart';
import 'package:github_account_app/presentation/account/liked_account/liked_account_bloc.dart';
import 'package:github_account_app/presentation/account/account_details/bloc/account_details_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
        BlocProvider<LikedAccountsBloc>(
          create: (context) => LikedAccountsBloc(),
        ),
        BlocProvider<AccountDetailsBloc>(
          create: (context) => AccountDetailsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'GitHub Accounts',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
