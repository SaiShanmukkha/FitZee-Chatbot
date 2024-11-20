final List<Map<String, String>> availableExercises = [
    {
      'name': 'Push-Up',
      'asset': 'assets/images/pushups.gif',
      'route': '/exercises/pushups'
    },
    {
      'name': 'Squat',
      'asset': 'assets/images/squats.gif',
      'route': '/exercises/squats'
    },
    {
      'name': 'Lunges',
      'asset': 'assets/images/lunges.gif',
      'route': '/exercises/lunges'
    },
    {
      'name': 'Plank',
      'asset': 'assets/images/planks.gif',
      'route': '/exercises/plank'
    },
    {
      'name': 'Burpees',
      'asset': 'assets/images/burpees.gif',
      'route': '/exercises/burpees'
    },
    {
      'name': 'Jumping Jacks',
      'asset': 'assets/images/jumping_jacks.gif',
      'route': '/exercises/jumping_jacks'
    },
    {
      'name': 'Mountain Climbers',
      'asset': 'assets/images/mountain_climbers.gif',
      'route': '/exercises/mountain_climbers'
    },
    {
      'name': 'Deadlift',
      'asset': 'assets/images/deadlift.gif',
      'route': '/exercises/deadlift'
    },
    {
      'name': 'Bicep Curls',
      'asset': 'assets/images/bicep_curls.gif',
      'route': '/exercises/bicep_curls'
    },
    {
      'name': 'Tricep Dips',
      'asset': 'assets/images/triceps.gif',
      'route': '/exercises/triceps'
    },
    {
      'name': 'Chest Press',
      'asset': 'assets/images/chest_press.gif',
      'route': '/exercises/chest_press'
    },
    {
      'name': 'Leg Raises',
      'asset': 'assets/images/leg_raises.gif',
      'route': '/exercises/leg_raises'
    },
    {
      'name': 'Russian Twists',
      'asset': 'assets/images/russian_twists.gif',
      'route': '/exercises/russian_twists'
    },
    {
      'name': 'Shoulder Press',
      'asset': 'assets/images/shoulder_press.gif',
      'route': '/exercises/shoulder_press'
    },
    {
      'name': 'High Knees',
      'asset': 'assets/images/high_knees.gif',
      'route': '/exercises/high_knees'
    },
    {
      'name': 'Jump Rope',
      'asset': 'assets/images/jump_rope.gif',
      'route': '/exercises/jump_rope'
    },
  ];

  // Categories for exercise grouping
  final Map<String, List<String>> categories = {
    'Gain Muscle': [
      'Push-Up',
      'Squat',
      'Deadlift',
      'Bicep Curls',
      'Tricep Dips',
      'Chest Press'
    ],
    'Boost Endurance': [
      'Jumping Jacks',
      'Mountain Climbers',
      'High Knees',
      'Burpees',
      'Jump Rope'
    ],
    'Build Strength': ['Plank', 'Lunges', 'Shoulder Press', 'Leg Raises'],
    'Increase Energy': ['Russian Twists', 'High Knees', 'Jump Rope'],
  };