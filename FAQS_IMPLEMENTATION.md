# FAQs Screen Implementation Documentation

## Overview
This document outlines the complete implementation of the FAQs (Frequently Asked Questions) screen following clean architecture principles, OOP best practices, and scalable design patterns.

## Architecture

### File Structure
```
lib/
├── models/
│   └── faq_model.dart                    # FAQ data model
├── routes/
│   ├── app_path.dart                     # Route paths (updated)
│   └── route_path.dart                   # Route configuration (updated)
└── views/
    └── profile/
        └── widgets/
            └── support_and_help/
                ├── support_and_help.dart              # Main support screen
                ├── support_and_help_controller.dart   # Support controller (updated)
                └── faqs/
                    ├── faqs.dart                      # FAQs screen
                    ├── faqs_controller.dart           # FAQs controller
                    └── widgets/
                        └── faq_item_widget.dart       # Reusable FAQ item widget
```

## Component Details

### 1. FaqModel (`lib/models/faq_model.dart`)

**Purpose**: Immutable data model representing a single FAQ item.

**Features**:
- Immutable properties for question, answer, and expansion state
- `copyWith` method for state updates
- JSON serialization/deserialization support
- Proper `equals` and `hashCode` implementations
- String representation for debugging

**Properties**:
- `question` (String): The FAQ question text
- `answer` (String): The FAQ answer text
- `isExpanded` (bool): Current expansion state (default: false)

**Key Methods**:
```dart
FaqModel copyWith({String? question, String? answer, bool? isExpanded})
factory FaqModel.fromJson(Map<String, dynamic> json)
Map<String, dynamic> toJson()
```

### 2. FaqsController (`lib/views/profile/widgets/support_and_help/faqs/faqs_controller.dart`)

**Purpose**: Manages FAQ list state and business logic using GetX.

**Features**:
- Reactive FAQ list using `RxList<FaqModel>`
- Toggle individual FAQ expansion
- Bulk operations (expand all, collapse all)
- Pre-loaded FAQ data with app-specific content
- Navigation handling

**Key Properties**:
```dart
final RxList<FaqModel> faqList = <FaqModel>[].obs;
```

**Key Methods**:
```dart
void toggleExpansion(int index)  // Toggle specific FAQ
void collapseAll()                // Collapse all FAQs
void expandAll()                  // Expand all FAQs
void goBack()                     // Navigate back
```

**Predefined FAQs**:
1. "What is this app for?"
2. "How does the conversation practice work?"
3. "Will the conversations be the same every time?"
4. "What is the 'Create Your Own Scenario' feature?"

### 3. FaqsScreen (`lib/views/profile/widgets/support_and_help/faqs/faqs.dart`)

**Purpose**: Main FAQs screen with list of expandable questions.

**Design Features**:
- Background image from CustomAssets
- Custom app bar with back button
- ListView with separators for FAQ items
- Empty state handling
- Smooth scrolling with BouncingScrollPhysics

**Layout Structure**:
```
Scaffold
└── Container (Background)
    └── SafeArea
        └── Column
            ├── AppBar (Custom)
            └── ListView (FAQs)
```

**Styling**:
- Horizontal padding: 26.w
- Vertical padding: 16.h
- Item spacing: 16.h
- Font: Poppins
- Title font size: 18.sp (600 weight)
- Body font size: 16.sp (400 weight)

### 4. FaqItemWidget (`lib/views/profile/widgets/support_and_help/faqs/widgets/faq_item_widget.dart`)

**Purpose**: Reusable, animated expandable FAQ item component.

**Features**:
- Smooth expand/collapse animations (300ms)
- Animated icon rotation
- Height transition with AnimatedCrossFade
- Touch feedback with GestureDetector
- Clean visual separation with divider

**Properties**:
```dart
final String question;
final String answer;
final bool isExpanded;
final VoidCallback onTap;
```

**Visual Design**:
- Background color: #F5F1E8
- Border radius: 12.r
- Shadow: Subtle black shadow (0.05 opacity)
- Padding: 16.w horizontal, 16.h vertical
- Icon: keyboard_arrow_down (animated rotation)
- Divider color: #E0E0E0

**Animations**:
1. **Container height**: AnimatedCrossFade with easeInOut curve
2. **Icon rotation**: AnimatedRotation (0° to 180°)
3. **Duration**: 300ms for all transitions

**Text Styling**:
- Question: 16.sp, weight 500, color #1E1E1E, line height 1.3
- Answer: 14.sp, weight 400, color #1E1E1E, line height 1.5, letter spacing 0.2

### 5. Route Configuration

**Updated Files**:
1. `lib/routes/app_path.dart`: Added `faqs = '/faqs'`
2. `lib/routes/route_path.dart`: Added FAQs route and import

**Route Definition**:
```dart
GoRoute(
  path: AppPath.faqs,
  name: 'faqs',
  builder: (context, state) => const FaqsScreen(),
)
```

### 6. Support and Help Controller Update

**Modified Method**:
```dart
void onFAQsTap(BuildContext context) {
  context.push(AppPath.faqs);
}
```

**Navigation**: Uses GoRouter's `context.push()` for proper navigation stack management.

## Design Specifications

### Color Palette
```dart
Background: CustomAssets.backgroundimage
FAQ Item Background: Color(0xFFF5F1E8)
Text Primary: Color(0xFF1E1E1E)
Divider: Color(0xFFE0E0E0)
Back Button BG: Colors.black.withValues(alpha: 0.10)
Shadow: Colors.black.withValues(alpha: 0.05)
```

### Spacing (using flutter_screenutil)
```dart
Horizontal Screen Padding: 26.w
Vertical Screen Padding: 16.h
Item Spacing: 16.h
Button Size: 30.w x 30.h
Icon Size: 24.sp
```

### Typography
```dart
Font Family: Poppins
App Bar Title: 18.sp, weight 600
FAQ Question: 16.sp, weight 500
FAQ Answer: 14.sp, weight 400
```

## OOP Principles Applied

### 1. **Encapsulation**
- Private methods prefixed with underscore
- Controlled state access through reactive properties
- Widget composition with clear boundaries

### 2. **Single Responsibility**
- FaqModel: Data representation only
- FaqsController: Business logic and state management
- FaqsScreen: UI composition and layout
- FaqItemWidget: Single FAQ item presentation

### 3. **Separation of Concerns**
- Models: Data structure
- Controllers: Business logic
- Views: Presentation
- Widgets: Reusable components
- Routes: Navigation configuration

### 4. **Reusability**
- FaqItemWidget can be used in other contexts
- FaqModel can be extended for API integration
- Controller methods are modular and testable

### 5. **Immutability**
- FaqModel uses `final` properties
- State updates through `copyWith` method
- Prevents accidental mutations

## Scalability Features

### 1. **Data Source Flexibility**
Current implementation uses hardcoded data, but can easily be extended:
```dart
// Future enhancement
Future<void> _loadFaqsFromApi() async {
  final response = await faqRepository.fetchFaqs();
  faqList.value = response.map((json) => FaqModel.fromJson(json)).toList();
}
```

### 2. **Search and Filter**
Can be added without major refactoring:
```dart
// Future enhancement
RxString searchQuery = ''.obs;

List<FaqModel> get filteredFaqs {
  if (searchQuery.isEmpty) return faqList;
  return faqList.where((faq) => 
    faq.question.toLowerCase().contains(searchQuery.toLowerCase()) ||
    faq.answer.toLowerCase().contains(searchQuery.toLowerCase())
  ).toList();
}
```

### 3. **Category Support**
Model can be extended:
```dart
// Future enhancement
class FaqModel {
  final String category; // Add category
  // ...existing properties
}
```

### 4. **Analytics Integration**
Controller ready for tracking:
```dart
// Future enhancement
void toggleExpansion(int index) {
  // Existing logic...
  analyticsService.logEvent('faq_expanded', {
    'question': faqList[index].question,
  });
}
```

## Usage

### Navigate to FAQs Screen
```dart
// From any screen with context
context.push(AppPath.faqs);

// Or using GetX
Get.toNamed(AppPath.faqs);
```

### Accessing Controller
```dart
final controller = Get.find<FaqsController>();
controller.toggleExpansion(0);
controller.expandAll();
controller.collapseAll();
```

### Adding New FAQs
Update `_initializeFaqs()` method in `FaqsController`:
```dart
void _initializeFaqs() {
  faqList.value = [
    // Existing FAQs...
    const FaqModel(
      question: 'Your new question?',
      answer: 'Your detailed answer here.',
      isExpanded: false,
    ),
  ];
}
```

## Testing Considerations

### Unit Tests
```dart
// Test controller logic
test('toggleExpansion should toggle FAQ state', () {
  final controller = FaqsController();
  controller.toggleExpansion(0);
  expect(controller.faqList[0].isExpanded, true);
});
```

### Widget Tests
```dart
// Test FAQ item widget
testWidgets('FaqItemWidget expands on tap', (tester) async {
  bool tapped = false;
  await tester.pumpWidget(
    MaterialApp(
      home: FaqItemWidget(
        question: 'Test?',
        answer: 'Answer',
        isExpanded: false,
        onTap: () => tapped = true,
      ),
    ),
  );
  await tester.tap(find.byType(FaqItemWidget));
  expect(tapped, true);
});
```

## Performance Optimizations

1. **Lazy Loading**: ListView.separated builds items on demand
2. **Const Constructors**: Used throughout for better performance
3. **Selective Rebuilds**: Obx only rebuilds when faqList changes
4. **Efficient Animations**: Hardware-accelerated transforms

## Accessibility Features

1. **Semantic Labels**: All interactive elements have proper semantics
2. **Touch Targets**: Minimum 30.w x 30.h for buttons
3. **Text Scaling**: Uses .sp for responsive font sizes
4. **Color Contrast**: Text colors meet WCAG standards

## Future Enhancements

1. **API Integration**: Replace hardcoded data with backend service
2. **Search Functionality**: Add search bar to filter FAQs
3. **Categories**: Group FAQs by category with tabs
4. **Favorites**: Allow users to bookmark frequently accessed FAQs
5. **Share**: Add share functionality for individual FAQs
6. **Offline Support**: Cache FAQs locally
7. **Multilingual**: Support multiple languages
8. **Rich Text**: Support formatting in answers (bold, links, etc.)

## Dependencies

```yaml
dependencies:
  flutter_screenutil: ^5.9.0  # Responsive sizing
  get: ^4.6.6                  # State management
  go_router: ^14.8.1          # Navigation
```

## Conclusion

This implementation follows industry best practices for Flutter development:
- ✅ Clean Architecture
- ✅ SOLID Principles
- ✅ Responsive Design
- ✅ Smooth Animations
- ✅ Reusable Components
- ✅ Type Safety
- ✅ State Management
- ✅ Scalable Structure
- ✅ Maintainable Code
- ✅ Performance Optimized

The FAQs screen is now production-ready and can be easily extended with additional features as requirements evolve.
