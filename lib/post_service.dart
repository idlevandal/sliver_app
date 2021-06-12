import 'dart:convert';

import 'package:http/http.dart';
import 'package:sliver_app/post.dart';

Future<List<Post>> getPosts() async {
  Response res = await get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  if (res.statusCode == 200) {
    List<dynamic> response = jsonDecode(res.body);

    return response.map((el) => Post.fromJson(el)).toList();
  } else {
    print('error retrieving todos');
    throw Exception('Error');
  }
}