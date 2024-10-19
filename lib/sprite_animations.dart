import 'package:bonfire/bonfire.dart';
import 'package:my_cool_game/globals.dart';

class SpriteAnimations {
  SpriteAnimations._();
  static const _dwarfWarriorIdle = 'dwarf_warrior/idle';
  static const _dwarfWarriorAttack = 'dwarf_warrior/attack';
  static const _dwarfWarriorWalk = 'dwarf_warrior/walk';
  static const _dwarfWarriorDeath = 'dwarf_warrior/death';
  static const _dwarfWarriorHurt = 'dwarf_warrior/hurt';

  static const _dwarfWarriorIdleCount = 3;
  static const _dwarfWarriorAttackCount = 6;
  static const _dwarfWarriorWalkCount = 6;
  static const _dwarfWarriorDeathCount = 6;
  static const _dwarfWarriorHurtCount = 3;

  static Future<SpriteAnimation> get dwarfWarriorHurt async => _spriteAnimation(
        _dwarfWarriorHurtCount,
        _dwarfWarriorHurt,
      );

  static Future<SpriteAnimation> get dwarfWarriorDeath async =>
      _spriteAnimation(
        _dwarfWarriorDeathCount,
        _dwarfWarriorDeath,
      );

  static Future<SpriteAnimation> get dwarfWarriorWalk async => _spriteAnimation(
        _dwarfWarriorWalkCount,
        _dwarfWarriorWalk,
      );

  static Future<SpriteAnimation> get dwarfWarriorIdle async => _spriteAnimation(
        _dwarfWarriorIdleCount,
        _dwarfWarriorIdle,
      );

  static Future<SpriteAnimation> get dwarfWarriorAttack async =>
      _spriteAnimation(
        _dwarfWarriorAttackCount,
        _dwarfWarriorAttack,
      );

  static Future<SpriteAnimation> _spriteAnimation(
    int count,
    String path,
  ) async {
    final sprites = <Sprite>[];

    for (int i = 0; i < count; i++) {
      final sprite = await Sprite.load('$path/$i.png');
      sprites.add(sprite);
    }

    return SpriteAnimation.spriteList(
      sprites,
      stepTime: Globals.spriteStepTime,
    );
  }
}
