import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';

import 'package:downloader_app/models/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({Key? key}) : super(key: key);

  @override
  _SongsPageState createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  bool searching = false;
  final ReceivePort _port = ReceivePort();

  late Future<List<Videos>> videos;
  late Directory? downloadPath;
  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    inicialize();
    refreshSongs();
    
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  Future<void> inicialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(debug: false);
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
    downloadPath = await DownloadsPathProvider.downloadsDirectory;
  }

  void refreshSongs([String q = "acdc"]) {
    videos = fetchSongs(q);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text("Music"),
            const SizedBox(
              width: 25,
            ),
            Visibility(
              visible: searching,
              child: Expanded(
                child: TextField(
                  onSubmitted: (string) {
                    setState(() {
                      searching = false;
                      refreshSongs(string);
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "buscar...",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Visibility(
            visible: !searching,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    searching = !searching;
                  });
                },
                icon: const Icon(Icons.search)),
          )
        ],
      ),
      body: FutureBuilder<List<Videos>>(
          future: videos,
          builder: (context, snap) {
            if (snap.hasData) {
              return ListView.builder(
                  itemCount: snap.data!.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () => download(url: snap.data![i].url),
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.network(snap.data![i].bestThumbnail.url),
                            ListTile(
                              title: Text(snap.data![i].title),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  Future<List<Videos>> fetchSongs(String q) async {
    final res = await get(
      Uri.parse(
        "https://music-hn.herokuapp.com/api.v2/videos?q=$q",
      ),
    );

    final videoRes = Videosres.fromJson(jsonDecode(res.body));
    return videoRes.videos;
  }

  

  void download({required String url, format = "mp3"}) async {
    final status = await Permission.storage.request();

    if (downloadPath == null) {
      message();
      return;
    }
    if (!status.isGranted) {
      message(msg:"Permiso denegado");
      return;
    }
    await FlutterDownloader.enqueue(
      url:
          "https://music-hn.herokuapp.com/api.v2/videos/download?url=$url&format=$format",
      savedDir: downloadPath!.path,
      showNotification: true,
      openFileFromNotification: true,
    );
  }

  void message({String msg = "Directorio de descargas no encontrado"}) {
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
