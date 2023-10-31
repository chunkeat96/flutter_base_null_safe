import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_null_safe/utils/image_extension.dart';

/// 加载图片（支持本地与网络图片）
class LoadImage extends StatelessWidget {

  const LoadImage(this.image, {
    Key? key,
    this.file,
    this.width,
    this.height,
    this.fit: BoxFit.cover,
    this.format: "png",
    this.holderImg: "",
  }): super(key: key);

  final File? file;
  final String? image;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String format;
  final String holderImg;

  @override
  Widget build(BuildContext context) {
    if(file?.path.isNotEmpty == true){
      return LoadFileImage(
        file,
        fit: fit,
        width: width,
        height: height,
        holderImg: holderImg,
      );
    }

    if (image?.isNotEmpty == true) {
      if (image!.startsWith('http')) {
        return CachedNetworkImage(
          imageUrl: image!,
          placeholder: (context, url) => LoadAssetImage(holderImg, height: height, width: width, fit: fit),
          errorWidget: (context, url, error) => LoadAssetImage(holderImg, height: height, width: width, fit: fit),
          width: width,
          height: height,
          fit: fit,
        );
      } else {
        return LoadAssetImage(image,
            height: height,
            width: width,
            fit: fit,
            format: format
        );
      }
    }

    return LoadAssetImage(holderImg,
      height: height,
      width: width,
      fit: fit,
      format: format,
    );
  }
}

/// 加载本地资源图片
class LoadAssetImage extends StatelessWidget {

  const LoadAssetImage(this.image, {
    Key? key,
    this.width,
    this.height,
    this.fit,
    this.format: 'png',
    this.gaplessPlayback: true,
    this.color,
  }): super(key: key);

  final String? image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final String format;
  final bool gaplessPlayback;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (image?.isNotEmpty == true) {
      return Image.asset(
        image!.imagePath(format: format),
        height: height,
        width: width,
        fit: fit,
        gaplessPlayback: gaplessPlayback,
        color: color,
      );
    }
    return SizedBox(height: height, width: width,);
  }
}

class LoadFileImage extends StatelessWidget {

  const LoadFileImage(this.file, {
    Key? key,
    this.width,
    this.height,
    this.fit : BoxFit.fill,
    this.holderImg,
  }) : super(key: key);

  final File? file;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String? holderImg;

  @override
  Widget build(BuildContext context) {
    return file != null ? Image.file(
      file!,
      width: width,
      height: height,
      fit: fit,
      gaplessPlayback: true,
    ) : LoadAssetImage(
      holderImg,
      width: width,
      height: height,
      fit: fit,
    );
  }
}

