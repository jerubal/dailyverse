import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/verse_model.dart';

class BibleService {
  static const String _url = 'https://beta.ourmanna.com/api/v1/get/?format=json&order=daily';

  Future<BibleVerse> getDailyVerse() async {
    try {
      final response = await http.get(Uri.parse(_url));
      if (response.statusCode == 200) {
        return BibleVerse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load verse');
      }
    } catch (e) {
      // Fallback if internet is down
      return BibleVerse(
        text: "The Lord is my shepherd; I shall not want.",
        reference: "Psalm 23:1",
      );
    }
  }
}
