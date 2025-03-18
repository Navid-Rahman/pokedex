import 'dart:ui';

import 'package:flutter/material.dart';

import '/core/app_colors.dart';
import '/models/pokemon.dart';

class PokemonDetailsModal extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonDetailsModal({
    super.key,
    required this.pokemon,
  });

  @override
  State<PokemonDetailsModal> createState() => _PokemonDetailsModalState();
}

class _PokemonDetailsModalState extends State<PokemonDetailsModal> {
  int _selectedIndex = 0;

  // Tab labels
  final List<String> _tabLabels = [
    'Basic Info',
    'Battle Stats',
    'Egg Details',
    'Base Stats',
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: const BoxDecoration(
            color: Color(0xff1A1A1D),
          ),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  color: Colors.white.withValues(alpha: 0.1),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Main content with padding to avoid overlap
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 40.0), // Space for header and button
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Vertical Tabs
                                  Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: Colors.white
                                              .withValues(alpha: 0.2),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: _tabLabels.length,
                                      itemBuilder: (context, index) {
                                        final isSelected =
                                            _selectedIndex == index;
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              _selectedIndex = index;
                                            });
                                          },
                                          child: Container(
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? AppColors.primaryColor
                                                      .withValues(alpha: 0.2)
                                                  : Colors.transparent,
                                              border: Border(
                                                left: BorderSide(
                                                  color: isSelected
                                                      ? AppColors.primaryColor
                                                      : Colors.transparent,
                                                  width: 4,
                                                ),
                                                bottom: BorderSide(
                                                  color: Colors.white
                                                      .withValues(alpha: 0.1),
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  _tabLabels[index],
                                                  style: TextStyle(
                                                    color: isSelected
                                                        ? AppColors.primaryColor
                                                        : Colors.white,
                                                    fontWeight: isSelected
                                                        ? FontWeight.bold
                                                        : FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  // Tab Content
                                  Expanded(
                                    child: IndexedStack(
                                      index: _selectedIndex,
                                      children: [
                                        _buildBasicInfoTab(),
                                        _buildBattleStatsTab(),
                                        _buildEggDetailsTab(),
                                        _buildBaseStatsTab(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Floating close button positioned relative to header
                      Positioned(
                        top: 8, // Align with header padding
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.black),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfoTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoItem('Species', widget.pokemon.species),
          _buildInfoItem('Height', '${widget.pokemon.height} m'),
          _buildInfoItem('Weight', '${widget.pokemon.weight} kg'),
          _buildInfoItem('Abilities', widget.pokemon.abilities),
        ],
      ),
    );
  }

  Widget _buildBattleStatsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoItem('EV Yield', widget.pokemon.evYield),
          _buildInfoItem('Base Exp', widget.pokemon.baseExp.toString()),
          _buildInfoItem('Catch Rate', widget.pokemon.catchRate.toString()),
          _buildInfoItem('Growth Rate', widget.pokemon.growthRate),
        ],
      ),
    );
  }

  Widget _buildEggDetailsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoItem('Egg Groups', widget.pokemon.eggGroups),
          _buildInfoItem('Gender Ratio', widget.pokemon.gender),
          _buildInfoItem('Egg Cycles', widget.pokemon.eggCycles.toString()),
        ],
      ),
    );
  }

  Widget _buildBaseStatsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatBar('HP', widget.pokemon.hpBase),
          _buildStatBar('Attack', widget.pokemon.attackBase),
          _buildStatBar('Defense', widget.pokemon.defenseBase),
          _buildStatBar('Special Attack', widget.pokemon.specialAttackBase),
          _buildStatBar('Special Defense', widget.pokemon.specialDefenseBase),
          _buildStatBar('Speed', widget.pokemon.speedBase),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBar(String label, int value) {
    final maxValue = 255; // Max possible base stat value
    final percentage = value / maxValue;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              Text(
                value.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: _getStatColor(value),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatColor(int value) {
    if (value < 50) return Colors.red;
    if (value < 90) return Colors.orange;
    if (value < 120) return Colors.amber;
    return Colors.green;
  }
}
