import 'package:dartz/dartz.dart';
import 'package:post_application/clean_code/domain/entities/failure.dart';
import 'package:post_application/clean_code/domain/entities/post_entity.dart';
import 'package:post_application/clean_code/domain/entities/success.dart';
import 'package:post_application/clean_code/domain/repositories/post_repoditory.dart';
import 'package:post_application/clean_code/domain/use_cases/add_post_use_case.dart';
import 'package:post_application/clean_code/domain/use_cases/delete_post_use_case.dart';
import 'package:post_application/clean_code/domain/use_cases/get_post_use_case.dart';
import 'package:post_application/clean_code/domain/use_cases/update_post_use_case.dart';

import '../models/post_model.dart';

class PostRepositoryImp implements PostRepository{



  final List<PostModel> _posts = [];



  @override
  Either<Failure, Success> addPost(PostEntity post) { try {
    _posts.add(PostModel(
        id: post.id, title: post.title, desc: post.desc, email: post.email));
    return Right(Success( message: 'the post add Done!'));
  } catch (e) {
    return Left(Failure(message: '$e'));
  }
  }

  @override
  Either<Failure, Success> deletePost(String postId) {
    try {
      _posts.removeWhere((post) => post.id == postId);
      return Right(Success(message: "Delete is Done"));
    } catch (e) {
      return Left(Failure(message: "$e"));
    }
  }

  @override
  Either<Failure, List<PostEntity>> getPosts() {
    try {
      return Right(List.unmodifiable(_posts));
    } catch (e) {
      return Left(Failure(message: "$e"));
    }
  }

  @override
  Either<Failure, Success> updatePost(PostEntity post) {
    try {
      final index = _posts.indexWhere((p) => p.id == post.id);
      if (index != -1) {
        _posts[index] = PostModel(
            id: post.id, title: post.title, desc: post.desc, email: post.email);
        return Right(Success(message: "update is Done!"));
      }
      return Left(Failure(message: "the element is notFound"));
    } catch (e) {
      return Left(Failure(message: "$e"));
    }
  }

}