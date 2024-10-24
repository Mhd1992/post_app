class PostEntity {
  final String id;
  final String title;
  final String desc;
  final String? email;

  PostEntity(
      {required this.id, required this.title, required this.desc, this.email});
}
