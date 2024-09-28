import 'package:campus/postFeed/Comment_screen.dart';
import 'package:campus/postFeed/Imagepicker.dart';
import 'package:campus/postFeed/Like_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:campus/postFeed/Like_animation.dart';
import '../api/user_controller.dart';
import '../postFeed/Firestor_methods.dart';

class PostWidget extends StatefulWidget {
  final snap;
  const PostWidget({
    super.key,
    required this.snap,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLikeAnimating = false;
  int commentLen = 0;
  void initState() {
    super.initState();
    getComments();
  }

  void getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 54,
          color: Colors.white,
          child: Center(
            child: ListTile(
                leading: SizedBox(
                  width: 35,
                  height: 35,
                  child: ClipOval(
                    child: Image.network(
                      widget.snap['profImage'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  widget.snap['username'],
                  style: TextStyle(fontSize: 13),
                ),
                subtitle: Text(
                  'location',
                  style: TextStyle(fontSize: 11),
                ),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shrinkWrap: true,
                          children: ['Delete']
                              .map(
                                (e) => InkWell(
                                  onTap: () async {
                                    FireStoreMethods()
                                        .deletePost(widget.snap['postId']);
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 16),
                                    child: Text(e),
                                  ),
                                ),
                              )
                              .toList(), // Ensure the map is converted to a list.
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_horiz),
                )),
          ),
        ),
        GestureDetector(
          onDoubleTap: () async {
            await FireStoreMethods().likePost(
              widget.snap['postId'].toString(),
              widget.snap['uid'],
              widget.snap['likes'],
            );
            setState(() {
              isLikeAnimating = true;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 375,
                child: Image.network(
                  widget.snap['postUrl'],
                  fit: BoxFit.cover,
                ),
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isLikeAnimating ? 1 : 0,
                child: LikeAnimation(
                  isAnimating: isLikeAnimating,
                  duration: const Duration(
                    milliseconds: 400,
                  ),
                  onEnd: () {
                    setState(() {
                      isLikeAnimating = false;
                    });
                  },
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 14),
              Row(
                children: [
                  SizedBox(width: 14),
                  LikeAnimation(
                    isAnimating:
                        widget.snap['likes'].contains(userController.email),
                    smallLike: true,
                    child: IconButton(
                      onPressed: () async {
                        await FireStoreMethods().likePost(widget.snap['postId'],
                            widget.snap['uid'], widget.snap['likes']);
                      },
                      icon: widget.snap['likes'].contains(widget.snap['uid'])
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.favorite_border,
                            ),
                    ),
                  ),
                  SizedBox(width: 17),
                  IconButton(
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CommentsScreen(
                                  snap: widget.snap,
                                ))),
                    icon: Icon(
                      Icons.comment_outlined,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: 17),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.send_outlined,
                      size: 28,
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.bookmark_border_outlined,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 19,
                  top: 13.5,
                  bottom: 5,
                ),
                child: Text(
                  '${widget.snap['likes'].length} likes',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Text(
                      widget.snap['username'] + ' ',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' ${widget.snap['description']}',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'View all $commentLen comments',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                onTap: () {},
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  DateFormat.yMMMd()
                      .format(widget.snap['datePublished'].toDate()),
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              Gap(10)
            ],
          ),
        ),
      ],
    );
  }
}
