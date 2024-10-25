
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/post_provider.dart';
import '../widgets/post_form_screen.dart';
import '../widgets/post_list_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postProvider);
    final isLoading = ref.watch(loadingProvider);
    final isLoadingWithMessage = ref.watch(resultStateProvider);

    //final postAsync = ref.watch(postAsyncProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Posts'),centerTitle: true,),
      body: (isLoadingWithMessage.isLoading)
          ? const Center(child: CircularProgressIndicator())
          : posts.isEmpty?const Center(child: Text('noData'),): ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostListItem(
            post: post,
            onDelete: ()  {
            //  ref.read(loadingProvider.notifier).changeLoadingState(true);
            //  await Future.delayed(const Duration(seconds: 3));
              ref.read(postProvider.notifier).removePost(post.id,ref: ref).then(
                  (_){
                    _showMessageDialog(context,isLoadingWithMessage.message);
                  }
              );
             // ref.read(loadingProvider.notifier).changeLoadingState(false);
            },
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PostFormScreen(post: post),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PostFormScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );

  }

  void _showMessageDialog(BuildContext context, String message) {


 print('^_^_^_^_^_^');
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('title'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () async {

                  Navigator.of(ctx).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }
}
