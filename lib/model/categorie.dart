class Categorie {
  final int id;
  final String titre;
  final String description;

  Categorie({
    required this.id,
    required this.titre,
    this.description = '',
  });
}
