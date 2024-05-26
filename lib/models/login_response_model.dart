class UserModel {
  final int id;
  final String username;
  final String email;
  final String phone;
  final String? image;
  final int followerCount;
  final int followCount;
  final int postCount;
  final String? thumbnailImage;
  final bool followed;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    this.image,
    required this.followerCount,
    required this.followCount,
    required this.postCount,
    this.thumbnailImage,
    required this.followed,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      followerCount: json['follower_count'],
      followCount: json['follow_count'],
      postCount: json['post_count'],
      thumbnailImage: json['thumbnail_image'],
      followed: json['followed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'image': image,
      'follower_count': followerCount,
      'follow_count': followCount,
      'post_count': postCount,
      'thumbnail_image': thumbnailImage,
      'followed': followed,
    };
  }
}

class LoginResponseModel {
  final bool success;
  final UserModel? user;
  final String? accessToken;
  final String? tokenType;
  final int? statusCode;
  final String? message;

  LoginResponseModel({
    required this.success,
    this.user,
    this.accessToken,
    this.tokenType,
    this.statusCode,
    this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      statusCode: json['statusCode'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'user': user?.toJson(),
      'access_token': accessToken,
      'token_type': tokenType,
      'statusCode': statusCode,
      'message': message,
    };
  }
}
