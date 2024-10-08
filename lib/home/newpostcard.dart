import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_cube/Models/user_model.dart' as model;
import 'package:my_cube/Widgets/likeAnimation.dart';
import 'package:my_cube/home/Social/commentscreen.dart';
import 'package:my_cube/services/auth.dart';
import 'package:my_cube/services/post_firestore_methods.dart';
import 'package:intl/intl.dart';
import 'package:my_cube/services/utils.dart';
import 'package:provider/provider.dart';

class NewPostCard extends StatefulWidget {
  final snap;
  const NewPostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<NewPostCard> createState() => _NewPostCardState();
}

class _NewPostCardState extends State<NewPostCard> {
  int commentLen = 0;
  bool isLikeAnimating = false;
  Offset location = Offset.zero;

  @override
  void initState() {
    super.initState();
    fetchCommentLen();
  }

  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('Posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
    setState(() {});
  }

  deletePost(String postId) async {
    try {
      await PostFireStoreMethods().deletePost(postId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.UserModel user = Provider.of<AuthProvider>(context).userModel;
    Size screenSize = MediaQuery.of(context).size;
    const height = 256.0;
    final width = screenSize.width * 0.9;

    const cardHeight = height - 7;
    final cardWidth = width - 7;


    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 467,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const SweepGradient(colors: [
                Colors.cyanAccent,
                Colors.pinkAccent,
                Colors.yellowAccent,
                Colors.cyanAccent
              ]),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(6),
          child: Align(
            alignment:Alignment.center,
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002) // perspective
                ..rotateX(0.001 * location.dy)
                ..rotateY(-0.001 * location.dx),
              alignment: FractionalOffset.center,
              child: GestureDetector(
                onPanUpdate: (details) {
                  location += details.delta;
                  setState(() {});
                },
                onPanEnd: (details) {
                  location = Offset.zero;
                  setState(() {});
                },
                child: Container(
                  width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    // HEADER SECTION OF THE POST
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 16,
                      ).copyWith(right: 0),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(
                              widget.snap['profImage'].toString(),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 8,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.snap['username'].toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          widget.snap['uid'].toString() == user.uid
                              ? IconButton(
                            onPressed: () {
                              showDialog(
                                useRootNavigator: false,
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: ListView(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        shrinkWrap: true,
                                        children: [
                                          'Delete',
                                        ]
                                            .map(
                                              (e) => InkWell(
                                              child: Container(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 16),
                                                child: Text(e),
                                              ),
                                              onTap: () {
                                                deletePost(
                                                  widget.snap['postId']
                                                      .toString(),
                                                );
                                                // remove the dialog box
                                                Navigator.of(context).pop();
                                              }),
                                        )
                                            .toList()),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.more_vert),
                          )
                              : Container(),
                        ],
                      ),
                    ),
                    // IMAGE SECTION OF THE POST
                    GestureDetector(
                      onDoubleTap: () {
                        PostFireStoreMethods().likePost(
                          widget.snap['postId'].toString(),
                          user.uid,
                          widget.snap['likes'],
                        );
                        setState(() {
                          isLikeAnimating = true;
                        });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: Image.network(
                              widget.snap['postUrl'].toString(),
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
                                Icons.thumb_up_off_alt_rounded,
                                color: Colors.lightBlue,
                                size: 100,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // LIKE, COMMENT SECTION OF THE POST
                    Row(
                      children: <Widget>[
                        LikeAnimation(
                          isAnimating: widget.snap['likes'].contains(user.uid),
                          smallLike: true,
                          child: IconButton(
                            icon: widget.snap['likes'].contains(user.uid)
                                ? const Icon(
                              Icons.thumb_up_off_alt_rounded,
                              color: Colors.lightBlue,
                            )
                                : const Icon(
                              Icons.thumb_up_off_alt_rounded,
                            ),
                            onPressed: () => PostFireStoreMethods().likePost(
                              widget.snap['postId'].toString(),
                              user.uid,
                              widget.snap['likes'],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.comment_outlined,
                          ),
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CommentsScreen(
                                postId: widget.snap['postId'].toString(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //DESCRIPTION AND NUMBER OF COMMENTS
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          DefaultTextStyle(
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(fontWeight: FontWeight.w800),
                              child: Text(
                                '${widget.snap['likes'].length} likes',
                                style: Theme.of(context).textTheme.bodyMedium,
                              )),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(
                              top: 8,
                            ),
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: widget.snap['username'].toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ":  ",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ${widget.snap['description']}',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                'View all $commentLen comments',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.indigoAccent,
                                ),
                              ),
                            ),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CommentsScreen(
                                  postId: widget.snap['postId'].toString(),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              DateFormat.yMMMd()
                                  .format(widget.snap['datePublished'].toDate()),
                              style: const TextStyle(
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
      ),
              ),
            ),
          ),
        ),
    ]);
  }
}