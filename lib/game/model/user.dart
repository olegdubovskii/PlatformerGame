class User {
  
  String username;
  int score;

  User({required this.username, this.score = 0});

  Map toJson() => {
    'username': username,
    'score': score,
  };

  factory User.fromJson(dynamic json) {
    return User(username: json['username'], score: json['score']);
  }
}