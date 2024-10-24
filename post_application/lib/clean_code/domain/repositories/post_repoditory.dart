import 'package:dartz/dartz.dart';

import '../entities/failure.dart';
import '../entities/post_entity.dart';
import '../entities/success.dart';

abstract class PostRepository{
  Either<Failure,List<PostEntity>> getPosts();
  Either<Failure,Success> addPost(PostEntity post);
  Either<Failure,Success>  updatePost(PostEntity post);
  Either<Failure,Success>  deletePost(String postId);
}