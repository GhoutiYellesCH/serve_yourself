class CommentModel {
  final String user;
  final String image;
  final String comment;

  CommentModel({
    required this.user,
    required this.image,
    required this.comment,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      user: json['user'],
      image: json['image'],
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'image': image,
      'comment': comment,
    };
  }
}
