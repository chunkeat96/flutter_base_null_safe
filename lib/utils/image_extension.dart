import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

extension ImageEx on String {
  String imagePath({String format : 'png'}) {
    return 'assets/images/$this.$format';
  }

  // use this when image is url, otherwise use AssetImage instead
  ImageProvider imageProvider({String holderImg : 'none'}) {
    if (this.isNotEmpty == true) {
      return CachedNetworkImageProvider(this);
    } else {
      return AssetImage(holderImg.imagePath());
    }
  }
}
