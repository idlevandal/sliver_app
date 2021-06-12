import 'package:flutter/cupertino.dart';
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
      home: SafeArea(child: HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFb5bcc5),
      // appBar: AppBar(
      //   backgroundColor: Color(0xFF3a4d65),
      //   title: Text('Posts', style: TextStyle(color: Colors.white),)
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true, // pint to the top, if false it disappears
            floating: true, // comes back into view as soon a user scrolls up
            expandedHeight: 160.0,
              backgroundColor: Color(0xFF3a4d65),
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Posts'),
              background: DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: <Color>[
                      Color(0xFF9da6b2).withOpacity(0.8),
                      Color(0xFF9da6b2).withOpacity(0.6),
                    ],
                  ),
                ),
                child: Image.asset(
                  'images/posts.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          PostList(),
        ],
      ),
    );
  }
}

class PostList extends ConsumerWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final posts = watch(postProvider);
    return posts.when(
      loading: () => SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
      error: (err, stack) => SliverToBoxAdapter(child: Text(err.toString())),
      data: (data) => SliverList(
          delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
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
                      leading: Icon(Icons.account_circle_outlined, color: Colors.white70,),
                      title: Text('User Id: ${data[index].userId} ___ Post Id: ${data[index].id!}', style: TextStyle(color: Colors.white),),
                      subtitle: Text(data[index].title!, style: TextStyle(color: Colors.white70),),
                      trailing: Icon(Icons.today_outlined, color: Color(0xFF536379),),
                    ),
                  ),
                );
              },
            childCount: data.length
          ),
      ),
    );
  }
}
