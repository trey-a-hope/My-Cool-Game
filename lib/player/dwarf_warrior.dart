import 'package:bonfire/bonfire.dart';
import 'package:flutter/services.dart';
import 'package:my_cool_game/globals.dart';
import 'package:my_cool_game/sprite_animations.dart';

class DwarfWarrior extends PlatformPlayer
    with HandleForces, KeyboardEventListener {
  static const _speed = 150.0;
  static const _size = Globals.tileSize * 1.5;

  DwarfWarrior({
    required super.position,
  }) : super(
          size: Vector2.all(_size),
          speed: _speed,
          countJumps: 2,
          animation: PlatformAnimations(
            idleRight: SpriteAnimations.dwarfWarriorIdle,
            runRight: SpriteAnimations.dwarfWarriorWalk,
          ),
        ) {
    addForce(
      AccelerationForce2D(
        id: 'gravity',
        value: Vector2(0, _speed * 4),
      ),
    );
  }

  @override
  void onJoystickAction(JoystickActionEvent event) {
    if (event.event == ActionEvent.DOWN &&
        (event.id == LogicalKeyboardKey.space || event.id == 1)) {
      jump();
    }
    super.onJoystickAction(event);
  }

  @override
  Future<void> onLoad() {
    add(
      Globals.simpleHitBox(
        sizeX: size.x,
      ),
    );
    return super.onLoad();
  }

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
