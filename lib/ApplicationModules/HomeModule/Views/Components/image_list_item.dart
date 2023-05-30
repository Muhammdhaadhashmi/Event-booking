import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import '../../../../Utils/app_colors.dart';

class ImageListItem extends StatelessWidget {
  final image;
  final double height;
  final double width;

  const ImageListItem({super.key, required this.image, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      // height: Dimensions.screenHeight(context) / 1.6,
      width: width,
      // width: Dimensions.screenWidth(context),
      child:  OptimizedCacheImage(
        imageUrl: image,
        progressIndicatorBuilder:
            (context, url, downloadProgress) =>
            Center(
              child: CircularProgressIndicator(),
            ),
        errorWidget: (context, url, error) => Icon(
          Icons.error,
          color: AppColors.black,
        ),
        fit: BoxFit.contain,
      ),
    );
  }
}