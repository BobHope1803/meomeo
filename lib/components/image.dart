//Load image from url
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// loadUrlImage({required String urlImage}){
//   return CachedNetworkImage(
//     imageUrl: urlImage,
//     placeholder: (context, url) => CircularProgressIndicator(),
//     errorWidget: (context, url, error) => Icon(Icons.error),
//   );
// }

Widget loadUrlImage(
    {required String imageUrl,
    BoxFit imageBoxFit = BoxFit.contain,
    bool setSize = true,
    double? height,
    double? width}) {
  return Container(
    height: !setSize ? height : 50,
    width: !setSize ? width : 50,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(500),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 0), // changes position of shadow
        ),
      ],
    ),
    child: CachedNetworkImage(
      useOldImageOnUrlChange: true,
      imageUrl: imageUrl,
      placeholder: (context, url) => SizedBox(
          height: 20,
          width: 20,
          child: Center(
              child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ))),
      errorWidget: (context, url, error) =>
          Icon(Icons.image_not_supported_outlined, size: 35, color: Colors.grey),
      imageBuilder: (context, imageProvider) =>
          CircleAvatar(backgroundImage: NetworkImage("$imageUrl")),
      height: !setSize ? height : 50,
      width: !setSize ? width : 50,
    ),
  );
}
