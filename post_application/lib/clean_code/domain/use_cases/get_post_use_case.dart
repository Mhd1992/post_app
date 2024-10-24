import 'package:dartz/dartz.dart';
import 'package:post_application/clean_code/domain/repositories/post_repoditory.dart';

import '../entities/failure.dart';
import '../entities/post_entity.dart';
import '../entities/success.dart';

class GetPostUseCase{
  final PostRepository postRepository;

  GetPostUseCase(this.postRepository);

  Either<Failure, List<PostEntity>> call() {
    return postRepository.getPosts();
  }
}