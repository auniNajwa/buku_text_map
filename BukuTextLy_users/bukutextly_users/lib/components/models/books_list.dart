class Books {
  final String name;
  final String description;
  final String imagePath;
  final String condition;
  final double price;
  final BookCategory category;

  Books({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.condition,
  });
}

enum BookCategory {
  computerscience,
  maths,
  science,
  engineering,
  mechanical,
}
