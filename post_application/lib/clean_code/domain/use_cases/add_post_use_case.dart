import 'package:dartz/dartz.dart';
import 'package:post_application/clean_code/domain/repositories/post_repoditory.dart';

import '../entities/failure.dart';
import '../entities/post_entity.dart';
import '../entities/success.dart';

class AddPostUseCase{
  final PostRepository postRepository;

  AddPostUseCase(this.postRepository);

  Either<Failure, Success> call(PostEntity postEntity) {
    return postRepository.addPost(postEntity);
  }
}