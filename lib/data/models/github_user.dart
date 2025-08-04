// data/models/github_user.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'github_user.extension.dart';

@JsonSerializable()
class GitHubUser extends Equatable {
  final String login;
  final int id;
  final String? node_id;
  final String? avatar_url;
  final String? gravatar_id;
  final String? url;
  final String? html_url;
  final String? followers_url;
  final String? following_url;
  final String? gists_url;
  final String? starred_url;
  final String? subscriptions_url;
  final String? organizations_url;
  final String? repos_url;
  final String? events_url;
  final String? received_events_url;
  final String? type;
  final String? user_view_type;
  final bool? site_admin;
  final double? score;
  final String? name;
  final String? company;
  final String? blog;
  final String? location;
  final String? email;
  final bool? hireable;
  final String? bio;
  final String? twitter_username;
  final int? public_repos;
  final int? public_gists;
  final int? followers;
  final int? following;
  final DateTime? created_at;
  final DateTime? updated_at;


  const GitHubUser({
    required this.login,
    required this.id,
    this.node_id,
    this.avatar_url,
    required this.gravatar_id,
    required this.url,
    this.html_url,
    this.followers_url,
    this.following_url,
    this.gists_url,
    this.starred_url,
    this.subscriptions_url,
    required this.organizations_url,
    required this.repos_url,
    required this.events_url,
    required this.received_events_url,
    required this.type,
    this.user_view_type,
    this.site_admin,
    this.score,
    this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.hireable,
    this.bio,
    this.twitter_username,
    this.public_repos,
    this.public_gists,
    this.followers,
    this.following,
    this.created_at,
    this.updated_at,
  });

  factory GitHubUser.fromJson(Map<String, dynamic> json) =>
      _$GitHubUserFromJson(json);
  Map<String, dynamic> toJson() => _$GitHubUserToJson(this);

  @override
  List<Object?> get props => [
    login,
    id,
    node_id,
    avatar_url,
    gravatar_id,
    url,
    html_url,
    followers_url,
    following_url,
    gists_url,
    starred_url,
    subscriptions_url,
    organizations_url,
    repos_url,
    events_url,
    received_events_url,
    type,
    user_view_type,
    site_admin,
    score,
    name,
    company,
    blog,
    location,
    email,
    hireable,
    bio,
    twitter_username,
    public_repos,
    public_gists,
    followers,
    following,
    created_at,
    updated_at,
  ];

  GitHubUser copyWith({
    String? login,
    int? id,
    String? node_id,
    String? avatar_url,
    String? gravatar_id,
    String? url,
    String? html_url,
    String? followers_url,
    String? following_url,
    String? gists_url,
    String? starred_url,
    String? subscriptions_url,
    String? organizations_url,
    String? repos_url,
    String? events_url,
    String? received_events_url,
    String? type,
    String? user_view_type,
    bool? site_admin,
    double? score,
    String? name,
    String? company,
    String? blog,
    String? location,
    String? email,
    bool? hireable,
    String? twitter_username,
    int? public_repos,
    int? public_gists,
    int? followers,
    int? following,
    DateTime? created_at,
    DateTime? updated_at,
  }) {
    return GitHubUser(
      login: login ?? this.login,
      id: id ?? this.id,
      node_id: node_id ?? this.node_id,
      avatar_url: avatar_url ?? this.avatar_url,
      gravatar_id: gravatar_id ?? this.gravatar_id,
      url: url ?? this.url,
      html_url: html_url ?? this.html_url,
      followers_url: followers_url ?? this.followers_url,
      following_url: following_url ?? this.following_url,
      gists_url: gists_url ?? this.gists_url,
      starred_url: starred_url ?? this.starred_url,
      subscriptions_url: subscriptions_url ?? this.subscriptions_url,
      organizations_url: organizations_url ?? this.organizations_url,
      repos_url: repos_url ?? this.repos_url,
      events_url: events_url ?? this.events_url,
      received_events_url: received_events_url ?? this.received_events_url,
      type: type ?? this.type,
      user_view_type: user_view_type ?? this.user_view_type,
      site_admin: site_admin ?? this.site_admin,
      score: score ?? this.score,
      name: name ?? this.name,
      company: company ?? this.company,
      blog: blog ?? this.blog,
      location: location ?? this.location,
      email: email ?? this.email,
      hireable: hireable ?? this.hireable,
      bio: bio ?? this.bio,
      twitter_username: twitter_username ?? this.twitter_username,
      public_repos: public_repos ?? this.public_repos,
      public_gists: public_gists ?? this.public_gists,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
    );
  }
}
