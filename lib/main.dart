import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sliver_app/post.dart';
import 'package:sliver_app/post_service.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final postProvider = FutureProvider<List<Post>>((ref) {
  return getPosts();
});

class MyApp extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
                                                                                primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TodoList(),
    );
  }
}

class TodoList extends ConsumerWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final posts = watch(postProvider);
    return posts.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, stack) => Text(err.toString()),
      data: (data) => ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            shadowColor: Color(0xFFDDDDDD),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF3a4d65), Color(0xFF09203f)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              child: ListTile(
                leading: Icon(Icons.today_outlined, color: Colors.white70,),
                title: Text('User Id: ${data[index].userId} ___ Todo Id: ${data[index].id!}', style: TextStyle(color: Colors.white),),
                subtitle: Text(data[index].title!, style: TextStyle(color: Colors.white70),),
              ),
            ),
          );
        },
      )
    );
  }
}
