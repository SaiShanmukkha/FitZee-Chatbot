import 'package:FitZee/pages/diet/berries_df.dart';
import 'package:FitZee/pages/diet/cheese_df.dart';
import 'package:FitZee/pages/diet/greekyogurt_df.dart';
import 'package:FitZee/pages/diet/guacamole_df.dart';
import 'package:FitZee/pages/diet/leafygreens_df.dart';
import 'package:FitZee/pages/diet/leanprotein_df.dart';
import 'package:FitZee/pages/diet/leanredmeat_df.dart';
import 'package:FitZee/pages/diet/nutbutter_df.dart';
import 'package:FitZee/pages/diet/wholebread_df.dart';
import 'package:FitZee/pages/diet/wholeeggs_df.dart';
import 'package:FitZee/pages/exercise_log/exercise_list.dart';
import 'package:FitZee/pages/account/account_home.dart';
import 'package:FitZee/pages/chat/chat_home.dart';
import 'package:FitZee/pages/diet/diet_home.dart';
import 'package:FitZee/pages/exercises/bicep_curls.dart';
import 'package:FitZee/pages/exercises/burpes.dart';
import 'package:FitZee/pages/exercises/chest_press.dart';
import 'package:FitZee/pages/exercises/deadlift.dart';
import 'package:FitZee/pages/exercises/excercise_home.dart';
import 'package:FitZee/pages/exercises/high_knees.dart';
import 'package:FitZee/pages/exercises/jumping_jacks.dart';
import 'package:FitZee/pages/exercises/jumping_rope.dart';
import 'package:FitZee/pages/exercises/leg_raises.dart';
import 'package:FitZee/pages/exercises/lunges.dart';
import 'package:FitZee/pages/exercises/mountain_climbers.dart';
import 'package:FitZee/pages/exercises/plank.dart';
import 'package:FitZee/pages/exercises/pushups.dart';
import 'package:FitZee/pages/exercises/russian_twists.dart';
import 'package:FitZee/pages/exercises/shoulder_press.dart';
import 'package:FitZee/pages/exercises/squats.dart';
import 'package:FitZee/pages/exercises/tricep_dips.dart';
import 'package:FitZee/pages/leader_board/leader_board.dart';
import 'package:FitZee/pages/step_count_pedometer/live_step_count_home.dart';
import 'package:FitZee/pages/step_data_page/StepCountData.dart';
import 'package:FitZee/pages/user_data/user_data.dart';
import 'package:FitZee/pages/home/home_page.dart';
import 'package:FitZee/pages/login/login_page.dart';
import 'package:FitZee/pages/register/register_page.dart';
import 'package:FitZee/providers/theme_provider.dart';
import 'package:FitZee/services/user_progress_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:FitZee/providers/fb_auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constants/firebase_options.dart';
import 'services/stepcount_database_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await StepcountDatabaseService().updateLastWeekStepData();
  await UserProgressService().generateLast10DaysBadges();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FBAuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // Light ThemeData
  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF6200EE),
    colorScheme: const ColorScheme(
      primary: Color(0xFF6200EE),
      primaryContainer: Color(0xFF3700B3),
      secondary: Color(0xFF03DAC6),
      secondaryContainer: Color(0xFF018786),
      surface: Color(0xFFFFFFFF),
      background: Color(0xFFFFFFFF),
      error: Color(0xFFB00020),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFF000000),
      onSurface: Color(0xFF000000),
      onError: Color(0xFFFFFFFF),
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color(0xFF6200EE),
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
    ),
  );

  // Dark ThemeData
  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF6200EE),
    colorScheme: const ColorScheme(
      primary: Color(0xFF6200EE),
      primaryContainer: Color(0xFF3700B3),
      secondary: Color(0xFF03DAC6),
      secondaryContainer: Color(0xFF018786),
      surface: Color(0xFF121212),
      error: Color(0xFFB00020),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFF000000),
      onSurface: Color(0xFFFFFFFF),
      onError: Color(0xFFFFFFFF),
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color(0xFF03DAC6),
      unselectedItemColor: Colors.grey,
      backgroundColor: Color(0xFF121212),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'FitZee',
          debugShowCheckedModeBanner: false,
          darkTheme: _darkTheme,
          theme: _lightTheme,
          themeAnimationCurve: Curves.easeInOut,
          themeAnimationDuration: const Duration(milliseconds: 500),
          themeMode:
              themeProvider.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          home: Consumer<FBAuthProvider>(
            builder: (context, authProvider, child) {
              return FutureBuilder<bool>(
                future: authProvider.isUserLoggedIn(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.data == true) {
                    return FutureBuilder<bool>(
                      future: _isUserDataAvailable(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.data == true) {
                          return const MyHomePage(title: "FitZee - Home");
                        } else {
                          return UserDataCollectionPage();
                        }
                      },
                    );
                  } else {
                    return const LoginPage();
                  }
                },
              );
            },
          ),
          routes: {
            '/home': (context) => const MyHomePage(title: "FitZee - Home"),
            '/login': (context) => const LoginPage(),
            '/chat': (context) => ChatPage(),
            '/exercise_log': (context) => ExerciseList(),
            '/register': (context) => const RegisterPage(),
            '/user_data': (context) => UserDataCollectionPage(),
            '/leader_board': (context) => LeaderboardPage(),
            '/diet_home': (context) => DietHomePage(),
            '/diet/guacamole': (context) => GuacamoleDietFoodDetail(),
            '/diet/nutbutter': (context) => NutsAndNutButterDetail(),
            '/diet/wholegrain': (context) => WholeGrainBreadDetail(),
            '/diet/cheese': (context) => CheeseDetail(),
            '/diet/redmeat': (context) => LeanRedMeatDetail(),
            '/diet/leafygreens': (context) => LeafyGreensDetail(),
            '/diet/leanprotein': (context) => LeanProteinDetail(),
            '/diet/berries': (context) => BerriesDetail(),
            '/diet/wholeeggs': (context) => WholeEggsDetail(),
            '/diet/greekyogurt': (context) => GreekYogurtDetail(),
            '/account': (context) => const AccountHome(),
            '/step_count': (context) => const LiveStepCount(),
            '/step_data_page': (context) => StepDataPage(),
            '/exercises': (context) => ExercisesHomePage(),
            '/exercises/pushups': (context) => PushUpDetailPage(),
            '/exercises/squats': (context) => SquatsDetailPage(),
            '/exercises/lunges': (context) => LungesDetailPage(),
            '/exercises/plank': (context) => PlankDetailPage(),
            '/exercises/burpees': (context) => BurpeesDetailPage(),
            '/exercises/jumping_jacks': (context) => JumpingJacksDetailPage(),
            '/exercises/mountain_climbers': (context) =>
                MountainClimbersDetailPage(),
            '/exercises/deadlift': (context) => DeadliftDetailPage(),
            '/exercises/bicep_curls': (context) => BicepCurlDetailPage(),
            '/exercises/triceps': (context) => TricepDipDetailPage(),
            '/exercises/chest_press': (context) => ChestPressDetailPage(),
            '/exercises/leg_raises': (context) => LegRaisesDetailPage(),
            '/exercises/russian_twists': (context) => RussianTwistsDetailPage(),
            '/exercises/shoulder_press': (context) => ShoulderPressDetailPage(),
            '/exercises/high_knees': (context) => HighKneesDetailPage(),
            '/exercises/jump_rope': (context) => JumpRopeDetailPage(),
          },
        );
      },
    );
  }

  // Checks if user data is available in Firestore
  Future<bool> _isUserDataAvailable() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return false;

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userDoc.exists && userDoc.data()?['tookInitialValue'] == true;
    } catch (e) {
      return false;
    }
  }
}
