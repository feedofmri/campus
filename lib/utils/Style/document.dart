import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:campus/utils/Style/nvigation.datr.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class DocumentPage extends StatefulWidget {
  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  List<Map<String, String>> importantFiles = [];
  List<Map<String, String>> savedVideos = [];
  List<Map<String, String>> enrolledCourses = [];
  String searchQuery = '';
  bool isSearching = false;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> pdfData = [];

  @override
  void initState() {
    super.initState();
    getPdf();
  }

  Future<String> uploadFile(String filename, File file, String folder) async {
    final reference = FirebaseStorage.instance.ref().child("$folder/$filename");
    final uploadTask = reference.putFile(file);
    await uploadTask.whenComplete(() {});
    final downloadLink = await reference.getDownloadURL();
    return downloadLink;
  }

  Future<void> pickFile() async {
    final prefs = await SharedPreferences.getInstance();
    bool? dontAskAgain = prefs.getBool('dontAskAgain');

    if (dontAskAgain == true) {
      await _requestPermission(Permission.storage);
    } else {
      await _showPermissionDialog();
    }
  }

  Future<void> _showPermissionDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool dontAskAgain = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Permission Required'),
              content:
                  Text('Please grant storage permissions to upload files.'),
              actions: [
                Row(
                  children: [
                    Checkbox(
                      value: dontAskAgain,
                      onChanged: (bool? value) {
                        setState(() {
                          dontAskAgain = value ?? false;
                        });
                      },
                    ),
                    Text('Don\'t ask again'),
                  ],
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    if (dontAskAgain) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('dontAskAgain', true);
                    }
                    await _requestPermission(Permission.storage);
                  },
                  child: Text('Allow'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _requestPermission(Permission permission) async {
    AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
    if (build.version.sdkInt >= 30) {
      PermissionStatus status =
          await Permission.manageExternalStorage.request();

      if (status.isGranted) {
        FilePickerResult? result =
            await FilePicker.platform.pickFiles(allowMultiple: false);

        if (result != null) {
          String? fileName = result.files.single.name;
          if (fileName != null) {
            File file = File(result.files.single.path!);
            if (['mp4', 'jpg', 'png', 'jpeg']
                .contains(result.files.single.extension)) {
              final downloadLink = await uploadFile(fileName, file, 'videos');
              setState(() {
                savedVideos.add({'name': fileName, 'link': downloadLink});
              });
            } else if (result.files.single.extension == 'pdf') {
              final downloadLink = await uploadFile(fileName, file, 'pdfs');
              await _firebaseFirestore.collection('pdfs').add({
                'filename': fileName,
                'downloadLink': downloadLink,
              });
              setState(() {
                importantFiles.add({'name': fileName, 'link': downloadLink});
              });
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  String inputFileName = fileName;
                  return AlertDialog(
                    title: Text('Enter file name'),
                    content: TextField(
                      onChanged: (value) {
                        inputFileName = value;
                      },
                      controller: TextEditingController(text: fileName),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            importantFiles
                                .add({'name': inputFileName, 'link': ''});
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text('Save'),
                      ),
                    ],
                  );
                },
              );
            }
          }
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Permission Denied'),
              content:
                  Text('Please grant storage permissions to upload files.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      var _re = await permission.request();
    }
  }

  void getPdf() async {
    final result = await _firebaseFirestore.collection("pdfs").get();
    pdfData = result.docs.map((e) => e.data()).toList();
    setState(() {});
  }

  void editFileName(int index, List<Map<String, String>> fileList) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String editedFileName = fileList[index]['name']!;
        return AlertDialog(
          title: Text('Edit file name'),
          content: TextField(
            onChanged: (value) {
              editedFileName = value;
            },
            controller: TextEditingController(text: fileList[index]['name']),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  fileList[index]['name'] = editedFileName;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _toggleSearch() {
    setState(() {
      isSearching = !isSearching;
      if (!isSearching) {
        searchQuery = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
              )
            : Text('Welcome To Your Library', style: TextStyle(fontSize: 20)),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Navigation()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isSearching) SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  Section(
                    title: 'Important Files/PDFs',
                    items: importantFiles,
                    searchQuery: searchQuery,
                    onEdit: (index) => editFileName(index, importantFiles),
                    onDelete: (index) {
                      setState(() {
                        importantFiles.removeAt(index);
                      });
                    },
                    onTapItem: (index) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFViewerPage(
                            pdfUrl: importantFiles[index]['link']!,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  Section(
                    title: 'Saved Videos',
                    items: savedVideos,
                    searchQuery: searchQuery,
                    onEdit: (index) {},
                    onDelete: (index) {
                      setState(() {
                        savedVideos.removeAt(index);
                      });
                    },
                    isVideo: true,
                  ),
                  SizedBox(height: 20),
                  Section(
                    title: 'Enrolled Courses',
                    items: enrolledCourses,
                    searchQuery: searchQuery,
                    onEdit: (index) {},
                    onDelete: (index) {
                      setState(() {
                        enrolledCourses.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickFile,
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final List<Map<String, String>> items;
  final String searchQuery;
  final Function(int) onEdit;
  final Function(int) onDelete;
  final Function(int)? onTapItem;
  final bool isVideo;

  Section({
    required this.title,
    required this.items,
    required this.searchQuery,
    required this.onEdit,
    required this.onDelete,
    this.onTapItem,
    this.isVideo = false,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredItems = items
        .where((item) => item['name']!.toLowerCase().contains(searchQuery))
        .toList()
      ..sort((a, b) => a['name']!.compareTo(b['name']!));
    bool noMatchFound = filteredItems.isEmpty && searchQuery.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        noMatchFound
            ? Text(
                'NO MATCH FOUND',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              )
            : isVideo
                ? SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.grey,
                                  child: Center(
                                    child: Text(
                                      filteredItems[index]['name']!,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      onEdit(index);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      onDelete(index);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(filteredItems[index]['name']!),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                onEdit(index);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                onDelete(index);
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          if (onTapItem != null) {
                            onTapItem!(index);
                          }
                        },
                      );
                    },
                  ),
        SizedBox(height: 20),
      ],
    );
  }
}

class PDFViewerPage extends StatefulWidget {
  final String pdfUrl;

  const PDFViewerPage({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  PDFDocument? document;

  @override
  void initState() {
    super.initState();
    initializePdf();
  }

  void initializePdf() async {
    document = await PDFDocument.fromURL(widget.pdfUrl);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
        backgroundColor: Colors.purple,
      ),
      body: document != null
          ? PDFViewer(document: document!)
          : Center(child: CircularProgressIndicator()),
    );
  }
}
