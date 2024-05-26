import 'dart:convert';

CommentsModel commentsModelFromJson(String str) =>
    CommentsModel.fromJson(json.decode(str));

String commentsModelToJson(CommentsModel data) => json.encode(data.toJson());

class CommentsModel {
  bool success;
  String message;
  List<Data> data;

  CommentsModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        success: json["success"],
        message: json["message"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  int id;
  String text;
  User user;
  String timeDiff;

  Data({
    required this.id,
    required this.text,
    required this.user,
    required this.timeDiff,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        text: json["text"],
        user: User.fromJson(json["user"]),
        timeDiff: json["timeDiff"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "user": user.toJson(),
        "timeDiff": timeDiff,
      };
}

class User {
  int id;
  String username;
  String email;
  String phone;
  dynamic image;
  int followerCount;
  int followCount;
  int postCount;
  dynamic thumbnailImage;
  bool followed;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.image,
    required this.followerCount,
    required this.followCount,
    required this.postCount,
    required this.thumbnailImage,
    required this.followed,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        followerCount: json["follower_count"],
        followCount: json["follow_count"],
        postCount: json["post_count"],
        thumbnailImage: json["thumbnail_image"],
        followed: json["followed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "phone": phone,
        "image": image,
        "follower_count": followerCount,
        "follow_count": followCount,
        "post_count": postCount,
        "thumbnail_image": thumbnailImage,
        "followed": followed,
      };
}
