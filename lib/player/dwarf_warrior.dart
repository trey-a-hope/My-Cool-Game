import 'package:bonfire/bonfire.dart';
import 'package:my_cool_game/sprite_animations.dart';

class DwarfWarrior extends PlatformPlayer with KeyboardEventListener {
  static const _speed = 150.0;
  static const _size = 60.0;

  DwarfWarrior({
    required super.position,
  }) : super(
          size: Vector2.all(_size),
          speed: _speed,
          animation: PlatformAnimations(
            idleRight: SpriteAnimations.dwarfWarriorIdle,
            runRight: SpriteAnimations.dwarfWarriorWalk,
          ),
        );

  @override
  void update(double dt) {
    super.update(dt);
    _checkBoundaries();
  }

  void _checkBoundaries() {
    final mapSize = gameRef.map.getMapSize();

    // Left boundary
    if (position.x < 0) {
      position.x = 0;
    }
    // Right boundary
    else if (position.x + width > mapSize.x) {
      position.x = mapSize.x - width;
    }

    // Top boundary
    if (position.y < 0) {
      position.y = 0;
    }
    // Bottom boundary
    else if (position.y + height > mapSize.y) {
      position.y = mapSize.y - height;
    }
  }
}
