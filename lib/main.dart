import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const KnowmeApp());

const red = Color(0xFFE50925);
const bg = Color(0xFF090909);
const panel = Color(0xFF171717);

class KnowmeApp extends StatelessWidget {
  const KnowmeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KNOWME PUBG',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: red,
          brightness: Brightness.dark,
          surface: panel,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: bg,
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: panel,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        useMaterial3: true,
      ),
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});
  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int index = 0;
  final pages = const [
    DashboardPage(),
    SensitivityPage(),
    AimTrainingPage(),
    PremiumPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.bolt, color: red, size: 25),
            SizedBox(width: 7),
            Text('KNOWME', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.4)),
            SizedBox(width: 5),
            Text('PUBG', style: TextStyle(color: red, fontWeight: FontWeight.w900)),
          ],
        ),
      ),
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (v) => setState(() => index = v),
        backgroundColor: const Color(0xFF111111),
        indicatorColor: red.withValues(alpha: .22),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.tune), label: 'Sensitivity'),
          NavigationDestination(icon: Icon(Icons.gps_fixed), label: 'Aim'),
          NavigationDestination(icon: Icon(Icons.workspace_premium_outlined), label: 'Premium'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              colors: [Color(0xFF650817), Color(0xFF171010), Color(0xFF101010)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: red.withValues(alpha: .5)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PLAY SMARTER', style: TextStyle(color: Colors.white70, letterSpacing: 2, fontSize: 12)),
              SizedBox(height: 10),
              Text('LEVEL UP\\nYOUR GAME', style: TextStyle(fontSize: 30, height: 1.05, fontWeight: FontWeight.w900)),
              SizedBox(height: 12),
              Text('Your independent PUBG gaming companion.'),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const Text('YOUR TOOLS', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.2)),
        const SizedBox(height: 10),
        const FeatureTile(icon: Icons.tune, title: 'Sensitivity Calculator', subtitle: 'Build and save your control setup'),
        const FeatureTile(icon: Icons.gps_fixed, title: 'Aim Training', subtitle: 'Practice accuracy and reaction'),
        const FeatureTile(icon: Icons.workspace_premium, title: 'KNOWME Premium', subtitle: 'Explore future membership benefits'),
        const SizedBox(height: 12),
        const Text('Note: KNOWME PUBG is a companion app. It does not modify PUBG Mobile or provide cheats.', style: TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }
}

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const FeatureTile({super.key, required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: CircleAvatar(backgroundColor: red.withValues(alpha: .16), child: Icon(icon, color: red)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right, color: Colors.white54),
    ),
  );
}

class SensitivityPage extends StatefulWidget {
  const SensitivityPage({super.key});
  @override
  State<SensitivityPage> createState() => _SensitivityPageState();
}

class _SensitivityPageState extends State<SensitivityPage> {
  double camera = 120, ads = 100, gyro = 250;
  Widget setting(String label, double value, ValueChanged<double> change) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
        Text(value.round().toString(), style: const TextStyle(color: red, fontWeight: FontWeight.bold)),
      ]),
      Slider(value: value, min: 0, max: 400, divisions: 400, activeColor: red, onChanged: change),
    ],
  );

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      const PageHeading(title: 'Sensitivity', subtitle: 'Adjust values and create your own setup.'),
      Card(child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          setting('Camera', camera, (v) => setState(() => camera = v)),
          setting('ADS', ads, (v) => setState(() => ads = v)),
          setting('Gyroscope', gyro, (v) => setState(() => gyro = v)),
          const SizedBox(height: 8),
          SizedBox(width: double.infinity, child: FilledButton(
            style: FilledButton.styleFrom(backgroundColor: red),
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Settings are ready. Saving to an account will be added in a later version.'))),
            child: const Text('SAVE SETUP'),
          )),
        ]),
      )),
      const Padding(padding: EdgeInsets.only(top: 12), child: Text('These are editable starting values, not guaranteed optimal settings. Test and adjust them in-game.', style: TextStyle(color: Colors.white54, fontSize: 12))),
    ],
  );
}

class AimTrainingPage extends StatefulWidget {
  const AimTrainingPage({super.key});
  @override
  State<AimTrainingPage> createState() => _AimTrainingPageState();
}

class _AimTrainingPageState extends State<AimTrainingPage> {
  final random = Random();
  int hits = 0, seconds = 30;
  bool running = false;
  double x = .5, y = .5;
  Timer? timer;

  void start() {
    timer?.cancel();
    setState(() { hits = 0; seconds = 30; running = true; moveTarget(); });
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds <= 1) {
        t.cancel();
        setState(() { seconds = 0; running = false; });
      } else {
        setState(() => seconds--);
      }
    });
  }

  void moveTarget() {
    x = .12 + random.nextDouble() * .76;
    y = .12 + random.nextDouble() * .70;
  }

  @override
  void dispose() { timer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(18),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const PageHeading(title: 'Aim Training', subtitle: 'A simple tap-target practice session.'),
      Row(children: [
        _stat('TIME', '$seconds s'),
        const SizedBox(width: 10),
        _stat('HITS', '$hits'),
      ]),
      const SizedBox(height: 14),
      Expanded(child: LayoutBuilder(builder: (context, c) => Container(
        width: double.infinity,
        decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white12)),
        child: Stack(children: [
          if (running)
            Positioned(
              left: (c.maxWidth * x - 27).clamp(0, c.maxWidth - 54),
              top: (c.maxHeight * y - 27).clamp(0, c.maxHeight - 54),
              child: GestureDetector(
                onTap: () => setState(() { hits++; moveTarget(); }),
                child: Container(
                  width: 54, height: 54,
                  decoration: BoxDecoration(shape: BoxShape.circle, color: red.withValues(alpha: .18), border: Border.all(color: red, width: 3)),
                  child: const Icon(Icons.gps_fixed, color: red),
                ),
              ),
            )
          else
            Center(child: Text(seconds == 0 ? 'SESSION COMPLETE\\n$hits TARGETS HIT' : 'PRESS START TO PRACTICE', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w800, height: 1.8))),
        ]),
      ))),
      const SizedBox(height: 14),
      SizedBox(width: double.infinity, child: FilledButton(
        style: FilledButton.styleFrom(backgroundColor: red, padding: const EdgeInsets.all(15)),
        onPressed: running ? null : start,
        child: Text(running ? 'TRAINING...' : 'START 30-SECOND SESSION'),
      )),
    ]),
  );

  Widget _stat(String label, String value) => Expanded(child: Card(child: Padding(
    padding: const EdgeInsets.all(14),
    child: Column(children: [Text(label, style: const TextStyle(color: Colors.white54, fontSize: 11)), const SizedBox(height: 4), Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: red))]),
  )));
}

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      const PageHeading(title: 'KNOWME Premium', subtitle: 'Membership plans can be connected after store setup.'),
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), gradient: const LinearGradient(colors: [Color(0xFF7D0B1B), Color(0xFF1A1012)])),
        child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.workspace_premium, size: 38),
          SizedBox(height: 12),
          Text('GO PREMIUM', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
          SizedBox(height: 8),
          Text('Planned benefits: saved sensitivity profiles, extra training statistics and profile themes.'),
        ]),
      ),
      const SizedBox(height: 14),
      const Card(child: ListTile(title: Text('Free'), subtitle: Text('Core tools and basic aim practice'), trailing: Text('FREE', style: TextStyle(color: red, fontWeight: FontWeight.bold)))),
      const Card(child: ListTile(title: Text('Premium'), subtitle: Text('Future paid membership'), trailing: Text('COMING SOON', style: TextStyle(color: Colors.white54, fontSize: 11)))),
      const SizedBox(height: 8),
      const Text('No payment is collected in this starter build. Real subscriptions require store billing setup, policies and testing.', style: TextStyle(color: Colors.white54, fontSize: 12)),
    ],
  );
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController(text: 'Player');
  String device = 'Select device';
  @override
  void dispose() { nameController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      const PageHeading(title: 'Player Profile', subtitle: 'Set up your local player card.'),
      Center(child: Container(
        width: 92, height: 92,
        decoration: BoxDecoration(shape: BoxShape.circle, color: red.withValues(alpha: .15), border: Border.all(color: red, width: 2)),
        child: const Icon(Icons.person, size: 48, color: red),
      )),
      const SizedBox(height: 18),
      TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Player name', border: OutlineInputBorder())),
      const SizedBox(height: 14),
      DropdownButtonFormField<String>(
        value: device,
        decoration: const InputDecoration(labelText: 'Device', border: OutlineInputBorder()),
        items: const ['Select device', 'Android', 'iPhone'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
        onChanged: (v) => setState(() => device = v ?? 'Select device'),
      ),
      const SizedBox(height: 14),
      FilledButton(
        style: FilledButton.styleFrom(backgroundColor: red),
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile preview: ${nameController.text} · $device'))),
        child: const Text('UPDATE PROFILE'),
      ),
      const SizedBox(height: 12),
      const Text('This first version stores profile details only while the app is open. Cloud accounts and permanent saving are planned for a later stage.', style: TextStyle(color: Colors.white54, fontSize: 12)),
    ],
  );
}

class PageHeading extends StatelessWidget {
  final String title, subtitle;
  const PageHeading({super.key, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 27, fontWeight: FontWeight.w900)),
      const SizedBox(height: 5),
      Text(subtitle, style: const TextStyle(color: Colors.white60)),
    ]),
  );
}
