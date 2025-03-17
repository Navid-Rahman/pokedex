// // TabBar for the 4 tabs
// TabBar(
// controller: _tabController,
// indicatorColor: Colors.white,
// labelColor: Colors.white,
// labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
// fontWeight: FontWeight.bold,
// ),
// labelPadding: EdgeInsets.zero,
// unselectedLabelColor: Colors.white60,
// tabs: const [
// Tab(text: "Basic Info"),
// Tab(text: "Battle Stats"),
// Tab(text: "Egg Details"),
// Tab(text: "Base Stats"),
// ],
// ),

// // Fixed height container for tab content
// SizedBox(
// height: 300, // Adjust this height as needed
// child: TabBarView(
// controller: _tabController,
// children: [
// // Tab 1: Basic Info
// _buildBasicInfoTab(),
//
// // Tab 2: Battle Stats
// _buildBattleStatsTab(),
//
// // Tab 3: Egg Details
// _buildEggDetailsTab(),
//
// // Tab 4: Base Stats
// _buildBaseStatsTab(),
// ],
// ),
// ),

// Widget _buildBasicInfoTab() {
//   return SingleChildScrollView(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildInfoRow("Species", widget.pokemon.species),
//         _buildInfoRow("Height", "${widget.pokemon.height} m"),
//         _buildInfoRow("Weight", "${widget.pokemon.weight} kg"),
//         _buildInfoRow("Abilities", widget.pokemon.abilities),
//       ],
//     ),
//   );
// }
//
// Widget _buildBattleStatsTab() {
//   return SingleChildScrollView(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildInfoRow("EV Yield", widget.pokemon.evYield),
//         _buildInfoRow("Base Exp", widget.pokemon.baseExp.toString()),
//         _buildInfoRow("Catch Rate", widget.pokemon.catchRate.toString()),
//         _buildInfoRow("Growth Rate", widget.pokemon.growthRate),
//       ],
//     ),
//   );
// }
//
// Widget _buildEggDetailsTab() {
//   return SingleChildScrollView(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildInfoRow("Egg Groups", widget.pokemon.eggGroups),
//         _buildInfoRow("Gender Ratio", widget.pokemon.gender),
//         _buildInfoRow("Egg Cycles", widget.pokemon.eggCycles.toString()),
//       ],
//     ),
//   );
// }
//
// Widget _buildBaseStatsTab() {
//   return SingleChildScrollView(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildStatRow("HP", widget.pokemon.hpBase),
//         _buildStatRow("Attack", widget.pokemon.attackBase),
//         _buildStatRow("Defense", widget.pokemon.defenseBase),
//         _buildStatRow("Special Attack", widget.pokemon.specialAttackBase),
//         _buildStatRow("Special Defense", widget.pokemon.specialDefenseBase),
//         _buildStatRow("Speed", widget.pokemon.speedBase),
//       ],
//     ),
//   );
// }
//
// Widget _buildInfoRow(String label, String value) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 16.0),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           value,
//           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//             color: Colors.white70,
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _buildStatRow(String label, int value) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 16.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               label,
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               value.toString(),
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 color: Colors.white70,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 4),
//         LinearProgressIndicator(
//           value:
//           value / 255, // Normalize to 0-1 range (max stat is usually 255)
//           backgroundColor: Colors.white10,
//           valueColor: AlwaysStoppedAnimation<Color>(
//             _getStatColor(value),
//           ),
//         ),
//       ],
//     ),
//   );
// }
//
// Color _getStatColor(int value) {
//   if (value < 50) return Colors.red;
//   if (value < 100) return Colors.orange;
//   if (value < 150) return Colors.yellow;
//   return Colors.green;
// }
