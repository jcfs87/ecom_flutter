class PostsWithUserAndTotalRating {
  const PostsWithUserAndTotalRating({
    this.title,
    this.description,
    this.total_puntos,
    this.name,
    this.photo,
    this.created_at,
  });
  final String? title;
  final String? total_puntos;
  final String? description;
  final String? name;
  final String? photo;
  final String? created_at;
}
