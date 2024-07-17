class PolicePost {
  final String name;
  final double latitude;
  final double longitude;

  PolicePost({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory PolicePost.fromJson(String name, Map<String, dynamic> json) {
    return PolicePost(
      name: name,
      latitude: json['lat'].toDouble(),
      longitude: json['lng'].toDouble(),
    );
  }

  static List<PolicePost> fromJsonList(String name, List<dynamic> jsonList) {
    return jsonList.map((json) => PolicePost.fromJson(name, json)).toList();
  }
}
