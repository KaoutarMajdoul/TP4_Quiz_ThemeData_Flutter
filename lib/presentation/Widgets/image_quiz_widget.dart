import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageQuiz extends StatelessWidget {
  const ImageQuiz({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Container for Image
      width: 350,
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }
}
