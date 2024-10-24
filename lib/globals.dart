import 'package:bonfire/bonfire.dart';

class Globals {
  Globals._();

  static const map = 'map.json';
  static const spriteStepTime = 0.1;
  static const tileSize = 32.0;

  static final items = _Items();
  static final forces = _Forces();

  static RectangleHitbox simpleHitBox({
    required double width,
  }) =>
      RectangleHitbox(
        size: Vector2.all(width / 2),
        position: Vector2(width / 4, width / 2),
        isSolid: true,
      );
}

class _Items {
  final bluePotion = 'items/PotionBlue.png';
  final greenPotion = 'items/PotionGreen.png';
  final axet1 = 'items/AxeT1.png';
  final map = 'items/Map.png';
  final bow = 'items/BowT2.png';
}

class _Forces {
  // Apply acceleration to velocity.
  final gravity = AccelerationForce2D(
    id: 'gravity',
    value: Vector2(0, 400),
  );

  // Apply linear force to velocity.
  final vacuum = LinearForce2D(
    id: 'vacuum',
    value: Vector2(0, 50),
  );

  // Apply resistance to velocity trying to zero.
  final unknown = ResistanceForce2D(
    id: 'unknown',
    value: Vector2(0, 50),
  );
}
