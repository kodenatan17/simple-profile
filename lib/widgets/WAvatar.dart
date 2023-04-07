import 'package:flutter/material.dart';
import 'package:widget_mask/widget_mask.dart';

class WAvatar extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BlendMode blendMode;
  final bool hasEnabledButton;
  final Function()? buttonFunction;
  const WAvatar.icon({
    required this.imagePath,
    required this.width,
    required this.height,
    required this.buttonFunction,
    super.key,
  })  : blendMode = BlendMode.srcATop,
        hasEnabledButton = true;
  const WAvatar.only({
    super.key,
    required this.imagePath,
    required this.width,
    required this.height,
  })  : blendMode = BlendMode.srcATop,
        hasEnabledButton = false,
        buttonFunction = null;
  @override
  Widget build(BuildContext context) {
    if (hasEnabledButton == true) {
      return SizedBox(
        width: width,
        height: height,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.loose,
          children: [
            WidgetMask(
              blendMode: BlendMode.srcATop,
              childSaveLayer: true,
              mask: Image(
                fit: BoxFit.cover,
                image: imagePath.isNotEmpty
                    ? NetworkImage(imagePath)
                    : const AssetImage("assets/profile.jpeg") as ImageProvider,
              ),
              child: const Image(
                fit: BoxFit.cover,
                image: AssetImage("assets/ava.png"),
              ),
            ),
            Positioned(
              bottom: 0,
              right: -10,
              child: RawMaterialButton(
                onPressed: buttonFunction,
                elevation: 2.0,
                fillColor: Colors.redAccent,
                padding: const EdgeInsets.all(10.0),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    }
    if (hasEnabledButton == false) {
      return WidgetMask(
        blendMode: blendMode,
        childSaveLayer: true,
        mask: Image(
          fit: BoxFit.cover,
          width: width,
          image: imagePath.isNotEmpty
              ? NetworkImage(imagePath)
              : const AssetImage("assets/profile.jpeg") as ImageProvider,
        ),
        child: Image(
          fit: BoxFit.fill,
          width: width,
          image: const AssetImage("assets/ava.png"),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
