import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/personality_service.dart';
import '../services/firestore_service.dart';
import '../models/user_model.dart';
import '../models/personality_models.dart';

// Auth Providers
final authServiceProvider = Provider((ref) => AuthService());

final authStateProvider = StreamProvider((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

final currentUserProvider = FutureProvider<AppUser?>((ref) async {
  final authService = ref.watch(authServiceProvider);
  final user = authService.currentUser;
  if (user == null) return null;
  
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getUser(user.uid);
});

// Firestore Providers
final firestoreServiceProvider = Provider((ref) => FirestoreService());

// Personality Service Providers
final personalityServiceProvider = Provider((ref) => PersonalityService());

// Test Questions Provider
final questionsProvider = FutureProvider.family<List<Question>, String>((ref, testType) async {
  final personalityService = ref.watch(personalityServiceProvider);
  return personalityService.loadQuestions(testType);
});

// User Results Provider
final userResultsProvider = StreamProvider<List<PersonalityResult>>((ref) async* {
  final currentUser = await ref.watch(currentUserProvider.future);
  if (currentUser == null) {
    yield [];
    return;
  }
  
  final firestoreService = ref.watch(firestoreServiceProvider);
  yield* firestoreService.getUserResults(currentUser.id);
});

// Theme Provider
final themeModeProvider = StateProvider<bool>((ref) => false); // false = light, true = dark

// Test Progress Provider
final testProgressProvider = StateProvider<double>((ref) => 0.0);

// Current Test Answers Provider
final currentTestAnswersProvider = StateProvider<List<UserAnswer>>((ref) => []);

// Daily Challenges Provider
final dailyChallengesProvider = FutureProvider<List<DailyChallenge>>((ref) async {
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getDailyChallenges();
});

// User Achievements Provider
final userAchievementsProvider = FutureProvider<List<Achievement>>((ref) async {
  final currentUser = await ref.watch(currentUserProvider.future);
  if (currentUser == null) return [];
  
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getUserAchievements(currentUser.id);
});

// Loading Provider
final isLoadingProvider = StateProvider<bool>((ref) => false);
