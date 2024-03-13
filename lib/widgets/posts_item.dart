import 'package:ecom_app/model/posts.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class PostsItem extends StatelessWidget {
  const PostsItem({
    super.key,
    required this.posts,
  });

  final Posts posts;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(
              posts.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              posts.description,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(),
            ),
          ],
        ),
      ),
    );
  }
}
