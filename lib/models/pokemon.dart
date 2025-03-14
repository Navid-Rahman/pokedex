class Pokemon {
  final String name;
  final String type;
  final String species;
  final String height;
  final String weight;
  final String abilities;
  final String evYield;
  final String catchRate;
  final String baseFriendship;
  final String baseExp;
  final String growthRate;
  final String eggGroups;
  final String gender;
  final String eggCycles;
  final int hpBase;
  final int hpMin;
  final int hpMax;
  final int attackBase;
  final int attackMin;
  final int attackMax;
  final int defenseBase;
  final int defenseMin;
  final int defenseMax;
  final int specialAttackBase;
  final int specialAttackMin;
  final int specialAttackMax;
  final int specialDefenseBase;
  final int specialDefenseMin;
  final int specialDefenseMax;
  final int speedBase;
  final int speedMin;
  final int speedMax;

  Pokemon({
    required this.name,
    required this.type,
    required this.species,
    required this.height,
    required this.weight,
    required this.abilities,
    required this.evYield,
    required this.catchRate,
    required this.baseFriendship,
    required this.baseExp,
    required this.growthRate,
    required this.eggGroups,
    required this.gender,
    required this.eggCycles,
    required this.hpBase,
    required this.hpMin,
    required this.hpMax,
    required this.attackBase,
    required this.attackMin,
    required this.attackMax,
    required this.defenseBase,
    required this.defenseMin,
    required this.defenseMax,
    required this.specialAttackBase,
    required this.specialAttackMin,
    required this.specialAttackMax,
    required this.specialDefenseBase,
    required this.specialDefenseMin,
    required this.specialDefenseMax,
    required this.speedBase,
    required this.speedMin,
    required this.speedMax,
  });

  factory Pokemon.fromJson(String name, Map<String, dynamic> json) {
    return Pokemon(
      name: name,
      type: json['Type'] as String,
      species: json['Species'] as String,
      height: json['Height'] as String,
      weight: json['Weight'] as String,
      abilities: json['Abilities'] as String,
      evYield: json['EV Yield'] as String,
      catchRate: json['Catch Rate'] as String,
      baseFriendship: json['Base Friendship'] as String,
      baseExp: json['Base Exp'] as String,
      growthRate: json['Growth Rate'] as String,
      eggGroups: json['Egg Groups'] as String,
      gender: json['Gender'] as String,
      eggCycles: json['Egg Cycles'] as String,
      hpBase: int.parse(json['HP Base'] as String),
      hpMin: int.parse(json['HP Min'] as String),
      hpMax: int.parse(json['HP Max'] as String),
      attackBase: int.parse(json['Attack Base'] as String),
      attackMin: int.parse(json['Attack Min'] as String),
      attackMax: int.parse(json['Attack Max'] as String),
      defenseBase: int.parse(json['Defense Base'] as String),
      defenseMin: int.parse(json['Defense Min'] as String),
      defenseMax: int.parse(json['Defense Max'] as String),
      specialAttackBase: int.parse(json['Special Attack Base'] as String),
      specialAttackMin: int.parse(json['Special Attack Min'] as String),
      specialAttackMax: int.parse(json['Special Attack Max'] as String),
      specialDefenseBase: int.parse(json['Special Defense Base'] as String),
      specialDefenseMin: int.parse(json['Special Defense Min'] as String),
      specialDefenseMax: int.parse(json['Special Defense Max'] as String),
      speedBase: int.parse(json['Speed Base'] as String),
      speedMin: int.parse(json['Speed Min'] as String),
      speedMax: int.parse(json['Speed Max'] as String),
    );
  }
}
