class Media {
  String path;
  String extension;
  String mimeType;
  String fileSize;
  String width;
  String height;

  Media({
    required this.path,
    required this.extension,
    required this.mimeType,
    required this.fileSize,
    required this.width,
    required this.height,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      path: json['path'],
      extension: json['extension'],
      mimeType: json['mime_type'],
      fileSize: json['file_size'],
      width: json['width'],
      height: json['height'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'extension': extension,
      'mime_type': mimeType,
      'file_size': fileSize,
      'width': width,
      'height': height,
    };
  }
}

class User {
  int id;
  String username;
  String email;
  String phone;
  String? image;
  int followerCount;
  int followCount;
  int postCount;
  String? thumbnailImage;
  bool followed;

  User({
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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

class Post {
  int id;
  String description;
  int likes;
  int comments;
  bool liked;

  User user;
  List<Media> media;

  Post({
    required this.id,
    required this.description,
    required this.likes,
    required this.comments,
    required this.liked,
    required this.user,
    required this.media,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    var mediaList = json['media'] as List;
    List<Media> mediaListItems =
        mediaList.map((i) => Media.fromJson(i)).toList();

    return Post(
      id: json['id'],
      description: json['description'],
      likes: json['likes'],
      comments: json['comments'],
      liked: json['liked'],
      user: User.fromJson(json['user']),
      media: mediaListItems,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'likes': likes,
      'comments': comments,
      'liked': liked,
      'user': user.toJson(),
      'media': media.map((e) => e.toJson()).toList(),
    };
  }
}
