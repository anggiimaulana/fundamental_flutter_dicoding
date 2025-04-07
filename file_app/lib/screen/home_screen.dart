import 'package:file_app/provider/file_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _fileNameController = TextEditingController();
  final _contentsController = TextEditingController();

  final _textStyle = const TextStyle(fontSize: 14);

  @override
  void dispose() {
    _fileNameController.dispose();
    _contentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Read-Write File'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: _createNewFile,
                      child: Text('New File', style: _textStyle),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: _openFile,
                      child: Text('Open File', style: _textStyle),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: _saveFile,
                      child: Text('Save File', style: _textStyle),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _fileNameController,
                      style: _textStyle,
                      decoration: const InputDecoration(
                        hintText: "File name.txt",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox.square(dimension: 16),
              TextField(
                controller: _contentsController,
                maxLines: null,
                minLines: 6,
                keyboardType: TextInputType.multiline,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  hintText: "Input your text here.",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackBar(String text) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger.showSnackBar(SnackBar(content: Text(text)));
  }

  void _createNewFile() {
    _fileNameController.clear();
    _contentsController.clear();
  }

  void _saveFile() async {
    final filename = _fileNameController.text;
    final contents = _contentsController.text;

    if (filename.isEmpty || contents.isEmpty) {
      showSnackBar("Filename or content is empty");
      return;
    }

    final fileProvider = context.read<FileProvider>();
    await fileProvider
        .saveFile(filename, contents)
        .then((value) => showSnackBar(fileProvider.message ?? ""))
        .catchError((e) => showSnackBar(fileProvider.message ?? ""))
        .whenComplete(() {
          _fileNameController.clear();
          _contentsController.clear();
        });
  }

  void _openFile() async {
    final fileProvider = context.read<FileProvider>();
    final filename = (await openListOfFileName()) ?? "";

    if (filename.isNotEmpty) {
      await fileProvider.readFile(filename);

      _fileNameController.text = filename;
      _contentsController.text = fileProvider.contents ?? "";
      showSnackBar(fileProvider.message ?? "");
    }
  }

  Future<String?> openListOfFileName() async {
    final fileProvider = context.read<FileProvider>();
    await fileProvider.getAllFilesInDirectory();
    final listOfFile = fileProvider.fileName;

    String? result;
    if (mounted) {
      result = await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Select the file'),
            children:
                listOfFile
                    .map(
                      (file) => SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context, file);
                        },
                        child: Text(file),
                      ),
                    )
                    .toList(),
          );
        },
      );
    }
    return result;
  }
}
