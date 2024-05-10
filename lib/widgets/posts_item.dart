import 'package:ecom_app/model/posts_with_user_puntos.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PostsItem extends StatelessWidget {
  const PostsItem({
    super.key,
    required this.posts,
  });

  final PostsWithUserAndTotalRating posts;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 255, 255),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    posts.title!,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  posts.created_at!,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                ),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
