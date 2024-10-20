import 'package:bonfire/bonfire.dart';

class Globals {
  Globals._();

  static const map = 'map.json';
  static const spriteStepTime = 0.1;
  static const tileSize = 32.0;

  static RectangleHitbox simpleHitBox({
    required Size size,
  }) =>
      RectangleHitbox(
        size: Vector2.all(size.width / 2),
        position: Vector2(size.width / 4, size.width / 2),
        isSolid: true,
      );
}
