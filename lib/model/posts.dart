class Posts {
  const Posts({
    required this.pk_id_publicacion,
    required this.title,
    required this.description,
    required this.fk_user_id,
    required this.type,
    required this.created_at,
    required this.updated_at,
  });

  final int pk_id_publicacion;
  final String title;
  final String description;
  final int fk_user_id;
  final String type;
  final DateTime created_at;
  final DateTime updated_at;
}
