import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import '../models/verse_model.dart';
import '../services/bible_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<BibleVerse> _verseFuture;

  @override
  void initState() {
    super.initState();
    _verseFuture = BibleService().getDailyVerse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFDFCFB), Color(0xFFE2D1C3)],
          ),
        ),
        child: FutureBuilder<BibleVerse>(
          future: _verseFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(color: Colors.brown));
            }

            final verse = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.format_quote_rounded, size: 60, color: Color(0xFF8D6E63)),
                  const SizedBox(height: 20),
                  Text(
                    "“${verse.text}”",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lora(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF3E2723),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    verse.reference.toUpperCase(),
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: const Color(0xFF795548),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _iconButton(Icons.share_outlined, "Share", () {
                        Share.share("${verse.text}\n— ${verse.reference}");
                      }),
                      const SizedBox(width: 40),
                      _iconButton(Icons.refresh, "New", () {
                        setState(() { _verseFuture = BibleService().getDailyVerse(); });
                      }),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon, String label, VoidCallback action) {
    return Column(
      children: [
        IconButton.filledTonal(
          onPressed: action,
          icon: Icon(icon),
          style: IconButton.styleFrom(backgroundColor: Colors.white60),
        ),
        Text(label, style: GoogleFonts.montserrat(fontSize: 10, fontWeight: FontWeight.w600)),
      ],
    );
  }
}