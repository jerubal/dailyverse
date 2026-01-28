class BibleVerse {
  final String text;
  final String reference;

  BibleVerse({required this.text, required this.reference});

  factory BibleVerse.fromJson(Map<String, dynamic> json) {
    return BibleVerse(
      text: json['verse']['details']['text'],
      reference: json['verse']['details']['reference'],
    );
  }
}
