import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/post_repository_imp.dart';
import '../../domain/entities/failure.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/entities/success.dart';
import '../../domain/repositories/post_repoditory.dart';
import '../../domain/use_cases/add_post_use_case.dart';
import '../../domain/use_cases/delete_post_use_case.dart';
import '../../domain/use_cases/get_post_use_case.dart';
import '../../domain/use_cases/update_post_use_case.dart';

class PostNotifier extends StateNotifier<List<PostEntity>> {
/*  PostNotifier(this.getPostUseCase, this.addPostUseCase, this.deletePostUseCase,
      this.updatePostUseCase, super.state);*/

  PostNotifier(this.getPostUseCase, this.addPostUseCase, this.deletePostUseCase,
      this.updatePostUseCase)
      : super([]) {
    loadPosts();
  }


  bool isLoading = false;
  final GetPostUseCase getPostUseCase;
  final AddPostUseCase addPostUseCase;
  final DeletePostUseCase deletePostUseCase;
  final UpdatePostUseCase updatePostUseCase;

  void loadPosts() {
    final result = getPostUseCase();
    result.fold(
          (failure) {
        // Handle failure (e.g., show a message)
        print(failure.message);
      },
          (posts) {
        state = posts;
      },
    );
  }

  void createPost(PostEntity post) {
    final result = addPostUseCase(post);
    result.fold(
          (failure) {
        Failure(message: "faild");
      },
          (posts) {
        Success(message: "Done!");
      },
    );
    loadPosts();
  }

  void updatePost(PostEntity post) {
    final result = updatePostUseCase(post);
    result.fold(
          (failure) {
        Failure( message: 'Fild');
      },
          (posts) {
        Success(message: "Done!");
      },
    );
    loadPosts();
  }

  void removePost(String id) {
    isLoading = true;
    final result = deletePostUseCase(id);

    result.fold(
          (failure) {
        Failure(message: "faild");
      },
          (posts) {
        Success(message: "Done!");
      },
    );

    loadPosts();
    isLoading = false;
  }
}

final postRepositoryProvider = Provider<PostRepository>((ref) {
  return PostRepositoryImp();
});

final postProvider =
StateNotifierProvider<PostNotifier, List<PostEntity>>((ref) {

  final repository = ref.read(postRepositoryProvider);

  return PostNotifier(GetPostUseCase(repository), AddPostUseCase(repository),
      DeletePostUseCase(repository), UpdatePostUseCase(repository));
});

class LoadingNotifier extends StateNotifier<bool> {
  LoadingNotifier(super.state);

  void changeLoadingState(bool value){
    state = value;
  }
}

final loadingProvider = StateNotifierProvider<LoadingNotifier, bool>((ref) {
  return LoadingNotifier(false);
});