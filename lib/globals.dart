import 'package:bonfire/bonfire.dart';

class Globals {
  Globals._();

  static const map = 'map.json';
  static const spriteStepTime = 0.1;
  static const tileSize = 32.0;

  static RectangleHitbox simpleHitBox({
    required double sizeX,
  }) =>
      RectangleHitbox(
        size: Vector2.all(sizeX / 2),
        position: Vector2(sizeX / 4, sizeX / 2),
        isSolid: true,
      );
}
