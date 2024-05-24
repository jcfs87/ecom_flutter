import 'package:ecom_app/model/posts_with_user_puntos.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class PostsItem extends StatelessWidget {
  const PostsItem({
    super.key,
    required this.posts,
  });

  final PostsWithUserAndTotalRating posts;
  
  //Function to format date
  String _formatDate(String created_At) {
  //Parse the received date string to DateTime object
    DateTime date = DateTime.parse(created_At);
// Get the current date
    DateTime now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return "Hoy " + DateFormat.Hm().format(date);
    } else {
       return DateFormat.yMMMMd().add_jm().format(date);
    }

  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                posts.title!,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
               _formatDate(posts.created_at!),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: posts.photo != null
                        ? NetworkImage(posts.photo!)
                        : const AssetImage('assets/images/user_3177440.png')
                            as ImageProvider<Object>?,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    posts.name!,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.star_outlined,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  posts.total_puntos != null
                      ? Text(
                          posts.total_puntos!,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                        )
                      : const SizedBox.shrink(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
