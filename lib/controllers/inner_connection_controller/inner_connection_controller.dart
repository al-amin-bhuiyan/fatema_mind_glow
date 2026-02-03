import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Inner Connection Controller - Manages inner connection questionnaire flow
class InnerConnectionController extends GetxController {
  // Current page index (0-7 for 8 pages)
  final RxInt currentPage = 0.obs;
  final int totalPages = 8;

  // Text editing controller for full name
  final TextEditingController fullNameController = TextEditingController();

  // User responses
  final RxString selectedFullName = ''.obs;
  final RxString selectedPronoun = ''.obs;
  final RxString selectedAgeRange = ''.obs;
  final RxString selectedLifeSituation = ''.obs;
  final RxString selectedLifeStage = ''.obs;
  final RxString selectedLifeFeeling = ''.obs;
  final RxString selectedFaith = ''.obs;
  final RxString selectedInspirationSource = ''.obs;
  final RxString selectedAttentionArea = ''.obs;

  // Pronoun options (Page 0 - 1/8)
  final List<String> pronounOptions = [
    'She/Her',
    'He/Him',
    'Not to say',
  ];

  // Age range options (Page 1 - 2/8)
  final List<String> ageRangeOptions = [
    'Under 18 years',
    '18-24',
    '25-34',
    '35-44',
    '45-64',
    '65+',
  ];

  // Life situation options (Page 2 - 3/8)
  final List<String> lifeSituationOptions = [
    'Single',
    'Married',
    'In a Relationship',
    'Separated / Divorced',
    'Widowed',
    'Other',
  ];

  // Life stage options (Page 2 - 4/8)
  final List<String> lifeStageOptions = [
    'Student',
    'Working professional',
    'Parent / caregiver',
    'Self-employed / Building something',
    'Retired',
    'Other',
  ];

  // Life feeling options (Page 3 - 5/8)
  final List<String> lifeFeelingOptions = [
    'Busy / overwhelming',
    'Stable but heavy',
    'Balanced',
    'Uncertain',
    'Mindfulness',
    'Quiet but disconnected',
    'Other',
  ];

  // Faith options (Page 4 - 6/8)
  final List<String> faithOptions = [
    'Christianity',
    'Islam',
    'Judaism',
    'Buddhism',
    'Hinduism',
    'Another faith or spiritual path',
    'I prefer non-religious inspiration',
    'Other',
  ];

  // Inspiration source options (Page 5 - 7/8)
  final List<String> inspirationSourceOptions = [
    'Sacred or spiritual texts',
    'Spiritual teachers or scholars',
    'Public figures or role models',
    'Writers or books',
    'Artists, creators, or influencers',
    'Name specific people, books, or voices',
  ];

  // Attention area options (Page 6 - 8/8)
  final List<String> attentionAreaOptions = [
    'Something I\'ve been carrying',
    'A feeling I don\'t fully understand',
    'A situation in my life',
    'A pattern I\'ve noticed',
    'I don\'t know yet — I just want space',
    'Other',
  ];

  /// Navigation methods
  void nextPage() {
    if (currentPage.value < totalPages - 1) {
      currentPage.value++;
    } else {
      completeQuestionnaire();
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      currentPage.value--;
    }
  }

  /// Selection methods
  void updateFullName(String name) {
    selectedFullName.value = name;
  }

  void selectPronoun(String pronoun) {
    selectedPronoun.value = pronoun;
  }

  void selectAgeRange(String ageRange) {
    selectedAgeRange.value = ageRange;
  }

  void selectLifeSituation(String option) {
    selectedLifeSituation.value = option;
  }

  void selectLifeStage(String option) {
    selectedLifeStage.value = option;
  }

  void selectLifeFeeling(String option) {
    selectedLifeFeeling.value = option;
  }

  void selectFaith(String option) {
    selectedFaith.value = option;
  }

  void selectInspirationSource(String option) {
    selectedInspirationSource.value = option;
  }

  void selectAttentionArea(String option) {
    selectedAttentionArea.value = option;
  }

  /// Check if user can continue from current page
  bool canContinue() {
    switch (currentPage.value) {
      case 0:
        return selectedFullName.value.trim().isNotEmpty && selectedPronoun.value.isNotEmpty;
      case 1:
        return selectedAgeRange.value.isNotEmpty;
      case 2:
        return selectedLifeSituation.value.isNotEmpty;
      case 3:
        return selectedLifeStage.value.isNotEmpty;
      case 4:
        return selectedLifeFeeling.value.isNotEmpty;
      case 5:
        return selectedFaith.value.isNotEmpty;
      case 6:
        return selectedInspirationSource.value.isNotEmpty;
      case 7:
        return selectedAttentionArea.value.isNotEmpty;
      default:
        return false;
    }
  }

  /// Get progress for progress bar (pages 0-7 show progress)
  double getProgress() {
    const progressBarPages = 8;
    return (currentPage.value + 1) / progressBarPages;
  }

  /// Get all user data
  Map<String, String> getUserData() {
    return {
      'fullName': selectedFullName.value,
      'pronoun': selectedPronoun.value,
      'ageRange': selectedAgeRange.value,
      'lifeSituation': selectedLifeSituation.value,
      'lifeStage': selectedLifeStage.value,
      'lifeFeeling': selectedLifeFeeling.value,
      'faith': selectedFaith.value,
      'inspirationSource': selectedInspirationSource.value,
      'attentionArea': selectedAttentionArea.value,
    };
  }

  /// Complete questionnaire
  void completeQuestionnaire() {
    print('====== Inner Connection Completed! ======');
    print('Full Name: ${selectedFullName.value}');
    print('Pronoun: ${selectedPronoun.value}');
    print('Age Range: ${selectedAgeRange.value}');
    print('Life Situation: ${selectedLifeSituation.value}');
    print('Life Stage: ${selectedLifeStage.value}');
    print('Life Feeling: ${selectedLifeFeeling.value}');
    print('Faith: ${selectedFaith.value}');
    print('Inspiration Source: ${selectedInspirationSource.value}');
    print('Attention Area: ${selectedAttentionArea.value}');
    print('=========================================');

    Get.snackbar(
      'Success',
      'Inner connection questionnaire completed!',
      backgroundColor: Colors.green.withValues(alpha: 0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );

    // TODO: Save data to database/storage
    // TODO: Navigate to home or next screen
  }

  /// Reset all selections
  void resetQuestionnaire() {
    currentPage.value = 0;
    fullNameController.clear();
    selectedFullName.value = '';
    selectedPronoun.value = '';
    selectedAgeRange.value = '';
    selectedLifeSituation.value = '';
    selectedLifeStage.value = '';
    selectedLifeFeeling.value = '';
    selectedFaith.value = '';
    selectedInspirationSource.value = '';
    selectedAttentionArea.value = '';
  }

  @override
  void onClose() {
    fullNameController.dispose();
    super.onClose();
  }
}
