import 'dart:convert';

FavoriteModel favoriteModelFromJson(String str) =>
    FavoriteModel.fromJson(json.decode(str));

String favoriteModelToJson(FavoriteModel data) => json.encode(data.toJson());

class FavoriteModel {
  bool success;
  String message;

  FavoriteModel({
    required this.success,
    required this.message,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
