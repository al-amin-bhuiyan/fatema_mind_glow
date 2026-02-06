# Inspire Screen Implementation

## Overview
The Inspire screen displays inspirational content including quotes, role models, and videos to users based on their reflection journey.

## Architecture

### Files Structure
```
lib/
├── controllers/
│   └── inspire/
│       └── inspire_controller.dart          # Controller managing inspire state
├── views/
│   └── inspire/
│       ├── inspire.dart                     # Main inspire screen
│       └── widgets/
│           ├── featured_quote_card.dart     # Featured quote widget
│           ├── category_filter_chips.dart   # Category filter chips
│           ├── inspiration_card.dart        # Inspiration card widget
│           └── video_thumbnail_card.dart    # Video thumbnail widget
└── routes/
    ├── app_path.dart                        # Route paths (updated)
    └── route_path.dart                      # Route configuration (updated)
```

### Key Components

#### 1. InspireController
- **Location**: `lib/controllers/inspire/inspire_controller.dart`
- **Responsibilities**:
  - Manages inspire screen state
  - Loads saved inspirations and videos
  - Handles category filtering
  - Manages bookmark toggles
  - Navigates to inspiration details and video player

#### 2. InspireScreen
- **Location**: `lib/views/inspire/inspire.dart`
- **Features**:
  - Featured quote display
  - Category filter chips
  - Grid of saved inspiration cards
  - Grid of inspiration video thumbnails
  - Responsive design using ScreenUtil
  - Proper navigation bar integration

#### 3. Widgets

##### FeaturedQuoteCard
- Displays the main featured quote
- Shows personalized subtitle
- Responsive styling with proper colors

##### CategoryFilterChips
- Horizontal scrollable filter chips
- Categories: Voices, Meaning, Perspectives, What Matters
- Active state indication

##### InspirationCard
- Displays saved inspiration items
- Shows type badge (Quote or Role Models)
- Bookmark toggle functionality
- Tap to view detail

##### VideoThumbnailCard
- Displays video thumbnail
- Play button overlay
- Tap to play video

## Model Classes

### FeaturedQuote
```dart
class FeaturedQuote {
  final String text;
  final String subtitle;
}
```

### InspirationItem
```dart
class InspirationItem {
  final String id;
  final InspirationItemType type;
  final String title;
  final String savedContext;
  final bool isBookmarked;
}
```

### VideoItem
```dart
class VideoItem {
  final String id;
  final String thumbnailAsset;
  final String videoUrl;
  final String title;
}
```

## Navigation

### Route Setup
- **Path**: `/inspire` (defined in `AppPath.inspire`)
- **Index in NavBar**: 3
- **Access**: Via bottom navigation bar "Inspire" tab

### Navigation Flow
```
Home → NavBar (Inspire) → InspireScreen
                           ├→ Inspiration Detail (TODO)
                           └→ Video Player (TODO)
```

## Design Specifications

### Colors
- Background: `Color(0x33C3A95E)` (light beige with opacity)
- Text Primary: `Color(0xFF1E1E1E)` (black)
- Text Secondary: `Color(0xFF78706B)` (brown gray)
- Category Badge: `Color(0x33896D16)` (gold with opacity)
- Border: `Color(0x66896D16)` (gold border)

### Typography
- **Headings**: Poppins SemiBold (18sp, 16sp)
- **Body**: Manrope Regular (14sp, 13sp, 12sp)
- **Small Text**: Manrope Medium (9sp)

### Spacing
- Section spacing: 24h, 20h
- Card spacing: 8h, 12h
- Horizontal padding: 26w
- Border radius: 14r

## Usage

### Basic Navigation
```dart
// Navigate to inspire screen
context.go(AppPath.inspire);

// Or from NavBar
navController.changeIndex(3, context);
```

### Accessing Controller
```dart
final InspireController controller = Get.find<InspireController>();

// Select category
controller.selectCategory('Meaning');

// Toggle bookmark
controller.toggleBookmark(inspirationId);

// Play video
controller.playVideo(videoItem);
```

## Future Enhancements

1. **Inspiration Detail Page**
   - Full inspiration content
   - Share functionality
   - Related inspirations

2. **Video Player Integration**
   - Full-screen video player
   - Play/pause controls
   - Progress tracking

3. **Search & Filter**
   - Search inspirations
   - Advanced filtering
   - Sort options

4. **Personalization**
   - AI-recommended content
   - Based on user reflections
   - Adaptive categories

## Dependencies

- `get`: State management
- `flutter_screenutil`: Responsive sizing
- `flutter_svg`: SVG icon support
- `go_router`: Navigation

## Assets Required

### Icons
- `book_mark_icon_marked.svg`
- `book_mark_icon_not_marked.svg`
- `video_icon_over_the_video_thumb.svg`

### Images
- `video_thumb_1.png`
- `video_thumb_2.png`
- `video_thumb_3.png`
- `background_image.png`

## Testing Checklist

- [x] Screen loads successfully
- [x] Featured quote displays
- [x] Category filters work
- [x] Inspiration cards render
- [x] Video thumbnails display
- [x] Navigation works
- [x] Bookmark toggle works
- [ ] Video playback (TODO)
- [ ] Detail navigation (TODO)

## Known Issues

None currently. All basic features are implemented and working.

## Related Documentation

- `JOURNEY_SCREEN_IMPLEMENTATION.md`
- `NAVIGATION_BAR_IMPLEMENTATION.md`
- `PROJECT_STRUCTURE.md`
