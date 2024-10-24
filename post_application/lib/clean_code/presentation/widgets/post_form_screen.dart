import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../domain/entities/post_entity.dart';
import '../providers/post_provider.dart';

class PostFormScreen extends ConsumerStatefulWidget {
  final PostEntity? post;

  PostFormScreen({this.post});

  @override
  _PostFormScreenState createState() => _PostFormScreenState();
}

class _PostFormScreenState extends ConsumerState<PostFormScreen> {

  late FormGroup form, customForm;

  @override
  void initState() {
    super.initState();
    /* using with out reactive form
     if (widget.post != null) {
      _titleController.text = widget.post!.title;
      _descController.text = widget.post!.desc;*/
    form = fb.group({
      'title': FormControl<String>(
        value: widget.post?.title,
        validators: [
          Validators.compose([Validators.required, Validators.minLength(3)])
        ],
      ),
      'desc': FormControl<String>(
        value: widget.post?.desc,
        validators: [
          Validators.compose([
            Validators.required,
          ])
        ],
      ),
      'email': FormControl<String>(
        value: widget.post?.email,
        validators: [
          Validators.compose([Validators.required,
            //  Validators.email
          ])
        ],
      )
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post == null ? 'Add Post' : 'Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: [
              ReactiveTextField(
                formControlName: 'title',
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                validationMessages: {
                  'required': (error) => 'The title must not be empty',
                  ValidationMessage.minLength: (error) =>
                  'the min length is three ',
                },
              ),
              const SizedBox(
                height: 8,
              ),
              ReactiveTextField(
                formControlName: 'desc',
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                validationMessages: {
                  'required': (error) => 'The description must not be empty',
                },
              ),
              const SizedBox(
                height: 8,
              ),
              ReactiveTextField(
                formControlName: 'email',
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrange),
                  ),
                ),
                validationMessages: {
                  'required': (error) => 'The title must not be empty',
                  // 'email': (error) => 'invalid email address',
                },
              ),
              const SizedBox(height: 20),
              ReactiveFormConsumer(builder: (context, form, child) {
                return ElevatedButton(
                  onPressed: !form.valid
                      ? null
                      : () {
                    //using reactiveForm package
                    if (form.valid) {
                      final fbTitle = form.control('title').value;
                      final fbDesc = form.control('desc').value;
                      final fbEmail = form.control('email').value;
                      final fbId =
                          widget.post?.id ?? DateTime.now().toString();
                      final post = PostEntity(
                          id: fbId,
                          title: fbTitle,
                          desc: fbDesc,
                          email: fbEmail);

                      if (widget.post == null) {
                        ref.read(postProvider.notifier).createPost(post);
                      } else {
                        ref.read(postProvider.notifier).updatePost(post);
                      }
                      Navigator.of(context).pop();
                    } else {
                      form.markAllAsTouched();
                    }
                  },
                  /* with out using reactiveForm package
                  final title = _titleController.text;
                    final desc = _descController.text;
                    final id = widget.post?.id ?? DateTime.now().toString();

                    final post =
                        PostEntity(id: id, title: title, desc: desc, email: null);

                    if (widget.post == null) {
                      ref.read(postProvider.notifier).createPost(post);
                    } else {
                      ref.read(postProvider.notifier).updatePost(post);
                    }*/

                  // Navigator.of(context).pop();

                  child: Text(widget.post == null ? 'Add Post' : 'Update Post'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
