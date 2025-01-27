import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:built_collection/built_collection.dart';
import 'package:localstore/localstore.dart';

import '../core/services/local_sore_service.dart';
import '../model/thread.dart';
import 'package:http/http.dart' as http;


class LocalStoreServiceImpl implements LocalStoreService {
  Localstore get db => Localstore.instance;

  CollectionRef get threads => db.collection('thread');

  final StreamController<BuiltList<Thread>> _threadController =
      StreamController<BuiltList<Thread>>.broadcast();
  String? output;


  @override
  Future<void> clearThread() async {
    await threads.delete();
  }

  @override
  Future<void> createThread({required Thread thread}) async {
    final String threadDoc = threads.doc().id;
    final Thread c = thread.rebuild((b) => b.id = threadDoc);
    await threads.doc(threadDoc).set(c.toJson());
    _refreshThread();
  }

  void _refreshThread() {
    threads.get().then((Map<String, dynamic>? data) {
      final BuiltList<Thread> t = (data ?? <String, dynamic>{})
          .values
          .cast<Map<String, dynamic>>()
          .map(Thread.fromJson)
          .toBuiltList();
      _threadController.add(t);
    });
  }

  @override
  Future<void> deleteThread({required String id}) async {
    await threads.doc(id).delete();
    _refreshThread();
  }

  @override
  Future<void> dispose() async {}

  @override
  Future<Thread> getThread({required String id}) async {
    final Map<String, dynamic>? data = await threads.doc(id).get();
    if (data == null) {
      throw 'thread not available';
    }
    return  Thread.fromJson(data);
  }

  @override
  Future<void> init() async {}

  @override
  Stream<BuiltList<Thread>> listenThread() {
    _refreshThread();
    return _threadController.stream;
  }

  @override
  Future<void> updateThread({required String id}) async {}

  @override
  Future<String?> getAIImageToData(String base64Image) async {
    final response = await http.post(
      Uri.parse('https://api.groq.com/openai/v1/chat/completions'),
      headers: {
        'Authorization':
        'Bearer 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',
      },
      body: jsonEncode({
        "messages": [
          {
            "role": "user",
            "content": [
              {
                "type": "text",
                "text":
                "Extract all the text from the provided image, including handwritten or printed text, numbers, and special characters. Return the content only in proper markdown format, without any additional explanations or identifiers.",
              },
              {
                "type": "image_url",
                "image_url": {"url": "data:image/jpeg;base64,$base64Image"}
              }
            ]
          }
        ],
        "model": "llama-3.2-11b-vision-preview",
        "temperature": 1,
        "max_completion_tokens": 1024,
        "top_p": 1,
        "stream": false,
        "stop": null
      }),
    );

    var jsonDecode2 = jsonDecode(response.body);
    List body = jsonDecode2["choices"];
    var b = body;

    for (var i in b) {
      output = (output ?? '') + (i["message"]["content"]).toString();
    }
    print('Extracted data => $output');
    return output;
  }

}
