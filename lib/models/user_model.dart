import 'package:patient_app/models/post_model.dart';

class User {
  final String profileImageUrl;
  final String backgroundImageUrl;
  final String name;
  final int following;
  final int followers;
  final List<Post> posts;
  final List<Post> favorites;

  User({
    this.profileImageUrl,
    this.backgroundImageUrl,
    this.name,
    this.following,
    this.followers,
    this.posts,
    this.favorites,
  });
}
