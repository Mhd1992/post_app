import 'package:dartz/dartz.dart';
import 'package:post_application/clean_code/domain/repositories/post_repoditory.dart';

import '../entities/failure.dart';
import '../entities/success.dart';

class DeletePostUseCase{
  final PostRepository postRepository;

  DeletePostUseCase(this.postRepository);

  Either<Failure, Success> call(String id) {
    return postRepository.deletePost(id);
  }
}