import 'package:flutter/material.dart';

import '/models/pokemon.dart';
import 'info_item.dart';

class BattleStatsTab extends StatelessWidget {
  final Pokemon pokemon;

  const BattleStatsTab({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoItem(label: 'EV Yield', value: pokemon.evYield),
          InfoItem(label: 'Base Exp', value: pokemon.baseExp.toString()),
          InfoItem(label: 'Catch Rate', value: pokemon.catchRate.toString()),
          InfoItem(label: 'Growth Rate', value: pokemon.growthRate),
        ],
      ),
    );
  }
}
