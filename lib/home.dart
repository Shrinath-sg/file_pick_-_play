import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/country_screen.dart';
import 'package:flutter_task/rate_exchange_screen.dart';
import 'package:open_file/open_file.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  openFile() async {
    try {
      setState(() {
        isLoading = true;
      });

      final file = await pickFile();
      setState(() {
        isLoading = false;
      });
      if (file == null) return;
      log('Path--> ${file.path}');
      OpenFile.open(file.path);
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      log(err.toString());
    }
  }

  Future<File?> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['mp4'],
        type: FileType.custom,
      );
      if (result == null) return null;
      return File(result.files.first.path!);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
          centerTitle: true,
        ),
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: (() => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CountryListScreen(),
                        ))),
                    child: const Text('Countries'),
                    style: TextButton.styleFrom(
                        elevation: 10,
                        backgroundColor: Colors.blue,
                        primary: Colors.white)),
                const SizedBox(
                  height: 50,
                ),
                TextButton(
                    onPressed: (() => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ExchangeRateScreen(),
                        ))),
                    child: const Text('Currency rates'),
                    style: TextButton.styleFrom(
                        elevation: 10,
                        backgroundColor: Colors.blue,
                        primary: Colors.white))
              ],
            ),
          ),
        )
        // Center(
        //   child: isLoading
        //       ? Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: const [
        //             CircularProgressIndicator(),
        //             SizedBox(
        //               width: 20,
        //             ),
        //             Text('Please wait...')
        //           ],
        //         )
        //       : IconButton(
        //           iconSize: 38,
        //           onPressed: (() => openFile()),
        //           icon: const Icon(
        //             Icons.filter,
        //             color: Colors.blue,
        //           )),
        // ),
        );
  }
}
