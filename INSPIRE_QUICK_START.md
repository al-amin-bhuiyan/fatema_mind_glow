# Inspire Screen - Quick Start Guide

## 🚀 Quick Start

### Navigate to Inspire Screen
```dart
// Method 1: Via Bottom Navigation
// Just tap the "Inspire" icon in the bottom navigation bar (4th tab)

// Method 2: Programmatically
context.go(AppPath.inspire);

// Method 3: Using NavBar Controller
final navController = Get.find<CustomNavBarController>();
navController.changeIndex(3, context);
```

### Access Controller
```dart
final controller = Get.find<InspireController>();
```

## 📱 Features Available

### 1. Featured Quote
- Displays personalized quote at the top
- Changes based on user's reflections

### 2. Category Filters
- **Voices** - Voice-based inspirations
- **Meaning** - Meaningful quotes
- **Perspectives** - Different viewpoints
- **What Matters** - Core values

```dart
controller.selectCategory('Meaning');
```

### 3. Saved Inspirations
- Grid of 4 inspiration cards
- Each card shows:
  - Type badge (Quote/Role Model)
  - Inspiration text
  - Context (when/where saved)
  - Bookmark icon

```dart
// Toggle bookmark
controller.toggleBookmark('inspiration_id');

// Open detail
controller.openInspirationDetail(inspirationItem);
```

### 4. Inspiration Videos
- Grid of 4 video thumbnails
- Tap to play video

```dart
controller.playVideo(videoItem);
```

## 🎨 Customization

### Update Featured Quote
```dart
controller.featuredQuote.value = FeaturedQuote(
  text: '"Your new quote here"',
  subtitle: 'Custom subtitle',
);
```

### Add New Inspiration
```dart
controller.savedInspirations.add(
  InspirationItem(
    id: '5',
    type: InspirationItemType.quote,
    title: 'New inspiration text',
    savedContext: 'Saved after meditation',
    isBookmarked: false,
  ),
);
```

### Add New Video
```dart
controller.inspirationVideos.add(
  VideoItem(
    id: '5',
    thumbnailAsset: 'assets/images/video_thumb_4.png',
    videoUrl: 'https://example.com/video5.mp4',
    title: 'New Video Title',
  ),
);
```

## 🔧 Integration Points

### TODO: Implement Video Player
```dart
void playVideo(VideoItem video) {
  // Navigate to video player screen
  context.push('/video-player', extra: video);
}
```

### TODO: Implement Inspiration Detail
```dart
void openInspirationDetail(InspirationItem inspiration) {
  // Navigate to detail screen
  context.push('/inspiration-detail', extra: inspiration);
}
```

### TODO: Connect to Backend API
```dart
void _loadSavedInspirations() async {
  // Replace mock data with API call
  final response = await apiService.getInspirations();
  savedInspirations.value = response.data;
}
```

## 📝 Model Classes Reference

### FeaturedQuote
```dart
FeaturedQuote(
  text: String,        // The quote text
  subtitle: String,    // Subtitle/description
)
```

### InspirationItem
```dart
InspirationItem(
  id: String,                      // Unique ID
  type: InspirationItemType,       // quote or roleModel
  title: String,                   // Main text
  savedContext: String,            // When/where saved
  isBookmarked: bool,              // Bookmark status
)
```

### VideoItem
```dart
VideoItem(
  id: String,                      // Unique ID
  thumbnailAsset: String,          // Thumbnail image path
  videoUrl: String,                // Video URL
  title: String,                   // Video title
)
```

## 🎯 Common Tasks

### Filter by Category
```dart
// User taps category chip
onTap: () => controller.selectCategory('Perspectives')
```

### Toggle Bookmark
```dart
// User taps bookmark icon
onBookmarkTap: () => controller.toggleBookmark(inspiration.id)
```

### Play Video
```dart
// User taps video thumbnail
onTap: () => controller.playVideo(video)
```

### View Inspiration Detail
```dart
// User taps inspiration card
onTap: () => controller.openInspirationDetail(inspiration)
```

## 🐛 Troubleshooting

### Issue: Screen not showing
**Solution**: Make sure you've registered the route in `route_path.dart`

### Issue: Assets not loading
**Solution**: Verify assets exist in `assets/` folder and are declared in `pubspec.yaml`

### Issue: Navigation not working
**Solution**: Check that `CustomNavBarController` is initialized with Get.put()

### Issue: State not updating
**Solution**: Use `.obs` for reactive variables and `.value` to access/update

## 📚 Related Documentation

- Full Implementation: `INSPIRE_IMPLEMENTATION.md`
- Summary: `INSPIRE_SUMMARY.md`
- Project Structure: `PROJECT_STRUCTURE.md`

## ✅ Checklist for Adding New Features

- [ ] Update model classes in controller
- [ ] Create/update UI widgets
- [ ] Add navigation if needed
- [ ] Update documentation
- [ ] Test on multiple screen sizes
- [ ] Handle error cases
- [ ] Add loading states

---

**Need Help?** Check the detailed implementation docs or review the existing code structure.
