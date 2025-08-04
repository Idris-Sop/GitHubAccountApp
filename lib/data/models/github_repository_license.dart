// data/models/github_repository_license.dart
class License {
  String key;
  String name;
  String spdxId;
  String url;
  String nodeId;

  License({
    required this.key,
    required this.name,
    required this.spdxId,
    required this.url,
    required this.nodeId,
  });

  factory License.fromJson(Map<String, dynamic> json) => License(
    key: json["key"],
    name: json["name"],
    spdxId: json["spdx_id"],
    url: json["url"],
    nodeId: json["node_id"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "name": name,
    "spdx_id": spdxId,
    "url": url,
    "node_id": nodeId,
  };
}