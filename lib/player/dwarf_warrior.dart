import 'package:bonfire/bonfire.dart';
import 'package:my_cool_game/sprite_animations.dart';

class DwarfWarrior extends PlatformPlayer
    with HandleForces, KeyboardEventListener {
  static const _jumpSpeed = 100.0;
  static const _speed = 150.0;
  static const _size = 60.0;

  DwarfWarrior({
    required super.position,
  }) : super(
          size: Vector2.all(_size),
          life: 100,
          speed: 100,
          countJumps: 1,
          animation: PlatformAnimations(
            idleRight: SpriteAnimations.dwarfWarriorIdle,
            runRight: SpriteAnimations.dwarfWarriorAttack,
          ),
        ) {
    addForce(
      AccelerationForce2D(
        id: 'gravity',
        value: Vector2(0, _jumpSpeed * 2),
      ),
    );
  }

  @override
  Future<void> onLoad() {
    add(
      RectangleHitbox(
        size: Vector2.all(size.x / 2),
        position: Vector2(size.x / 4, size.x / 2),
        isSolid: true,
      ),
    );
    return super.onLoad();
  }
}
