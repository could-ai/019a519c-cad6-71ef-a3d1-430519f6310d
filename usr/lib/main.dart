import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlight/languages/python.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Python IDE',
      theme: ThemeData.dark(),
      home: const PythonIDEScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PythonIDEScreen extends StatefulWidget {
  const PythonIDEScreen({super.key});

  @override
  State<PythonIDEScreen> createState() => _PythonIDEScreenState();
}

class _PythonIDEScreenState extends State<PythonIDEScreen> {
  CodeController? _codeController;
  String _output = '';

  @override
  void initState() {
    super.initState();
    const source =
        "def greet(name):\n    print(f'Hello, {name}!')\n\ngreet('Flutter Developer')";
    _codeController = CodeController(
      text: source,
      language: python,
      theme: monokaiSublimeTheme,
    );
  }

  @override
  void dispose() {
    _codeController?.dispose();
    super.dispose();
  }

  void _runCode() {
    final code = _codeController?.text ?? '';
    setState(() {
      _output =
          "--- Running code ---\n$code\n\n--- Output ---\n> Execution backend is not connected.\n> This is a UI demonstration of a Python IDE.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Python IDE'),
        backgroundColor: const Color(0xFF1E1E1E),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: CodeField(
              controller: _codeController!,
              textStyle: GoogleFonts.firaMono(fontSize: 14),
              expands: true,
              lineNumberStyle: const LineNumberStyle(
                width: 50,
                margin: 10,
              ),
            ),
          ),
          Container(
            color: const Color(0xFF1E1E1E),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Output Console",
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: _runCode,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Run"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black.withOpacity(0.8),
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Text(
                  _output,
                  style:
                      GoogleFonts.firaMono(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
