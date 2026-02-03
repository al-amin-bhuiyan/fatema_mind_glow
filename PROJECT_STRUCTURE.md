# 📂 Complete Project Structure Reference

```
fatema_mind_glow/
│
├── 📱 android/                     # Android native code
├── 🍎 ios/                        # iOS native code
├── 🐧 linux/                      # Linux desktop code
├── 🖥️  windows/                    # Windows desktop code
├── 🍏 macos/                      # macOS desktop code
├── 🌐 web/                        # Web platform code
│
├── 🧪 test/                       # Test files (mirror lib/ structure)
│   └── features/
│       └── counter/
│           ├── data/
│           ├── domain/
│           └── presentation/
│
├── 🎯 lib/                        # Main application code
│   │
│   ├── 🔧 core/                   # Core/Shared functionality
│   │   ├── error/
│   │   │   └── failures.dart              # Failure classes
│   │   ├── usecases/
│   │   │   └── usecase.dart              # Base UseCase interface
│   │   └── utils/
│   │       └── constants.dart            # App constants
│   │
│   ├── ✨ features/               # Feature modules
│   │   │
│   │   └── counter/              # Counter feature (example)
│   │       │
│   │       ├── 📊 data/          # Data Layer
│   │       │   ├── datasources/
│   │       │   │   └── counter_local_datasource.dart
│   │       │   ├── models/
│   │       │   │   └── counter_model.dart
│   │       │   └── repositories/
│   │       │       └── counter_repository_impl.dart
│   │       │
│   │       ├── 🧠 domain/        # Domain Layer (Business Logic)
│   │       │   ├── entities/
│   │       │   │   └── counter.dart
│   │       │   ├── repositories/
│   │       │   │   └── counter_repository.dart
│   │       │   └── usecases/
│   │       │       ├── get_counter.dart
│   │       │       └── increment_counter.dart
│   │       │
│   │       └── 🎨 presentation/  # Presentation Layer (UI)
│   │           ├── bloc/
│   │           │   ├── counter_bloc.dart
│   │           │   ├── counter_event.dart
│   │           │   └── counter_state.dart
│   │           └── pages/
│   │               └── counter_page.dart
│   │
│   ├── 💉 injection_container.dart    # Dependency Injection setup
│   └── 🚀 main.dart                  # App entry point
│
├── 📄 pubspec.yaml                # Dependencies and assets
├── 📄 analysis_options.yaml       # Lint rules
├── 📄 README.md                   # Project readme
│
└── 📚 Documentation Files
    ├── CLEAN_ARCHITECTURE.md      # Architecture overview
    ├── FEATURE_GUIDE.md           # How to add features
    ├── DATA_FLOW.md              # Data flow diagrams
    ├── SETUP_COMPLETE.md         # Setup summary
    └── PROJECT_STRUCTURE.md      # This file
```

## 📋 File Purposes by Layer

### 🔧 Core Layer
| File | Purpose |
|------|---------|
| `failures.dart` | Define error/failure types (ServerFailure, CacheFailure, etc.) |
| `usecase.dart` | Base interface for all use cases |
| `constants.dart` | App-wide constants and configuration |

### 🧠 Domain Layer (Business Logic)
| File | Purpose |
|------|---------|
| **Entities** | Pure business objects with no dependencies |
| `counter.dart` | Counter entity with business rules |
| **Repositories** | Abstract contracts for data operations |
| `counter_repository.dart` | Interface defining what data operations are needed |
| **Use Cases** | Individual business operations |
| `get_counter.dart` | Get current counter value |
| `increment_counter.dart` | Increment counter by 1 |

### 📊 Data Layer (Data Management)
| File | Purpose |
|------|---------|
| **Models** | Data transfer objects, extends entities |
| `counter_model.dart` | Counter model with JSON serialization |
| **Data Sources** | Interface with external data |
| `counter_local_datasource.dart` | Local storage operations (SharedPreferences) |
| **Repositories** | Implement domain repository interfaces |
| `counter_repository_impl.dart` | Concrete implementation coordinating data sources |

### 🎨 Presentation Layer (UI)
| File | Purpose |
|------|---------|
| **BLoC** | State management |
| `counter_bloc.dart` | Business logic component handling events/states |
| `counter_event.dart` | Events user can trigger |
| `counter_state.dart` | States UI can be in |
| **Pages** | Full screen views |
| `counter_page.dart` | Counter screen UI |
| **Widgets** | Reusable UI components |

## 🎯 Layer Dependencies

```
┌──────────────────────────────────────────┐
│          Presentation Layer              │
│  ┌────────────────────────────────────┐  │
│  │  • Pages                           │  │
│  │  • Widgets                         │  │
│  │  • BLoC (Events, States, Bloc)    │  │
│  └────────────────────────────────────┘  │
│         │                                 │
│         │ depends on                      │
│         ▼                                 │
├──────────────────────────────────────────┤
│            Domain Layer                   │
│  ┌────────────────────────────────────┐  │
│  │  • Entities (Pure business logic) │  │
│  │  • Use Cases                       │  │
│  │  • Repository Interfaces           │  │
│  └────────────────────────────────────┘  │
│         ▲                                 │
│         │ implements                      │
│         │                                 │
├──────────────────────────────────────────┤
│             Data Layer                    │
│  ┌────────────────────────────────────┐  │
│  │  • Models                          │  │
│  │  • Data Sources                    │  │
│  │  • Repository Implementations      │  │
│  └────────────────────────────────────┘  │
└──────────────────────────────────────────┘
```

## 📦 Package Dependencies

### Production Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  
  # State Management
  flutter_bloc: ^8.1.6       # BLoC pattern implementation
  
  # Dependency Injection
  get_it: ^8.0.0             # Service locator for DI
  
  # Functional Programming
  dartz: ^0.10.1             # Either, Option types
  
  # Value Equality
  equatable: ^2.0.5          # Simplify equality comparisons
  
  # Local Storage
  shared_preferences: ^2.3.0  # Key-value storage
```

### Dev Dependencies
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0      # Recommended lints
```

## 🔄 Data Flow Summary

```
User Interaction
      ↓
   UI Page
      ↓
   Event (dispatch to BLoC)
      ↓
   BLoC (receives event)
      ↓
   Use Case (business logic)
      ↓
   Repository Interface
      ↓
   Repository Implementation
      ↓
   Data Source (local/remote)
      ↓
   External Data (API, DB, Cache)
      ↓
   Data Source (returns data)
      ↓
   Repository (maps to entity)
      ↓
   Use Case (returns Either)
      ↓
   BLoC (emits state)
      ↓
   UI Page (rebuilds)
      ↓
   User sees updated UI
```

## 🗂️ File Naming Conventions

| Type | Convention | Example |
|------|-----------|---------|
| Entity | `{name}.dart` | `counter.dart`, `user.dart` |
| Model | `{name}_model.dart` | `counter_model.dart` |
| Repository Interface | `{name}_repository.dart` | `counter_repository.dart` |
| Repository Impl | `{name}_repository_impl.dart` | `counter_repository_impl.dart` |
| Data Source | `{name}_{type}_datasource.dart` | `counter_local_datasource.dart` |
| Use Case | `{action}_{entity}.dart` | `get_counter.dart`, `increment_counter.dart` |
| BLoC | `{name}_bloc.dart` | `counter_bloc.dart` |
| Event | `{name}_event.dart` | `counter_event.dart` |
| State | `{name}_state.dart` | `counter_state.dart` |
| Page | `{name}_page.dart` | `counter_page.dart` |
| Widget | `{name}_widget.dart` | `counter_display_widget.dart` |

## 📐 Folder Creation Order

When adding a new feature, create folders in this order:

1. **Domain Layer First** (Business logic is independent)
   - entities/
   - repositories/
   - usecases/

2. **Data Layer Second** (Implements domain contracts)
   - models/
   - datasources/
   - repositories/

3. **Presentation Layer Last** (Consumes domain logic)
   - bloc/
   - pages/
   - widgets/ (if needed)

## 🎯 Quick Reference Commands

```bash
# Create new feature structure (manual)
mkdir -p lib/features/{feature_name}/{data,domain,presentation}
mkdir -p lib/features/{feature_name}/data/{datasources,models,repositories}
mkdir -p lib/features/{feature_name}/domain/{entities,repositories,usecases}
mkdir -p lib/features/{feature_name}/presentation/{bloc,pages,widgets}

# Or use PowerShell
New-Item -ItemType Directory -Path "lib/features/feature_name/data/datasources" -Force
New-Item -ItemType Directory -Path "lib/features/feature_name/data/models" -Force
New-Item -ItemType Directory -Path "lib/features/feature_name/data/repositories" -Force
New-Item -ItemType Directory -Path "lib/features/feature_name/domain/entities" -Force
New-Item -ItemType Directory -Path "lib/features/feature_name/domain/repositories" -Force
New-Item -ItemType Directory -Path "lib/features/feature_name/domain/usecases" -Force
New-Item -ItemType Directory -Path "lib/features/feature_name/presentation/bloc" -Force
New-Item -ItemType Directory -Path "lib/features/feature_name/presentation/pages" -Force
New-Item -ItemType Directory -Path "lib/features/feature_name/presentation/widgets" -Force
```

## 🚀 Ready to Scale

This structure supports:
- ✅ Multiple features independently
- ✅ Team collaboration (features don't conflict)
- ✅ Easy testing (mock dependencies)
- ✅ Code reusability (shared core)
- ✅ Platform independence (business logic separate from UI)
- ✅ Easy refactoring (change one layer without affecting others)

---

**This structure is your blueprint for building scalable Flutter applications!** 🎊
