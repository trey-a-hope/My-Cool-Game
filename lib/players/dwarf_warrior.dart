import 'package:bonfire/bonfire.dart';
import 'package:flutter/services.dart';
import 'package:my_cool_game/globals.dart';
import 'package:my_cool_game/sprite_animations.dart';
import 'package:my_cool_game/screen_boundary_checker.dart';

class DwarfWarrior extends PlatformPlayer
    with HandleForces, ScreenBoundaryChecker {
  static const _size = Globals.tileSize * 1.5;
  static const _speed = 100.0;
  static const _jumpSpeed = 100.0;

  DwarfWarrior({required super.position})
      : super(
          size: Vector2.all(_size),
          countJumps: 2,
          speed: _speed,
          animation: PlatformAnimations(
            idleRight: SpriteAnimations.dwarfWarriorIdle,
            runRight: SpriteAnimations.dwarfWarriorWalk,
          ),
        ) {
    addForce(
      AccelerationForce2D(
        id: 'gravity',
        value: Vector2(0, _jumpSpeed * 4),
      ),
    );
  }

  @override
  void update(double dt) {
    checkScreenBoundaries();
    super.update(dt);
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
        size: Vector2.all(_size).toSize(),
      ),
    );
    return super.onLoad();
  }
}
