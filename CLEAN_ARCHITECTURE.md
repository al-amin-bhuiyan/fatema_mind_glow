# Clean Architecture Structure

This project follows Clean Architecture principles with a clear separation of concerns across three main layers:

## 📁 Project Structure

```
lib/
├── core/                           # Core functionality shared across features
│   ├── error/
│   │   └── failures.dart          # Error handling classes
│   ├── usecases/
│   │   └── usecase.dart           # Base UseCase contract
│   └── utils/
│       └── constants.dart         # App-wide constants
│
├── features/                       # Feature modules
│   └── counter/                   # Example: Counter feature
│       ├── data/                  # Data Layer
│       │   ├── datasources/
│       │   │   └── counter_local_datasource.dart
│       │   ├── models/
│       │   │   └── counter_model.dart
│       │   └── repositories/
│       │       └── counter_repository_impl.dart
│       │
│       ├── domain/                # Domain Layer (Business Logic)
│       │   ├── entities/
│       │   │   └── counter.dart
│       │   ├── repositories/
│       │   │   └── counter_repository.dart
│       │   └── usecases/
│       │       ├── get_counter.dart
│       │       └── increment_counter.dart
│       │
│       └── presentation/          # Presentation Layer (UI)
│           ├── bloc/
│           │   ├── counter_bloc.dart
│           │   ├── counter_event.dart
│           │   └── counter_state.dart
│           └── pages/
│               └── counter_page.dart
│
├── injection_container.dart        # Dependency Injection setup
└── main.dart                      # App entry point
```

## 🏗️ Architecture Layers

### 1. Domain Layer (Business Logic)
- **Entities**: Core business objects
- **Repositories**: Abstract contracts for data operations
- **Use Cases**: Individual business operations/actions

### 2. Data Layer (Data Management)
- **Data Sources**: Interface with external data (API, Database, Cache)
- **Models**: Data transfer objects with serialization
- **Repository Implementations**: Concrete implementations of domain repositories

### 3. Presentation Layer (UI)
- **BLoC**: Business Logic Components for state management
- **Pages**: UI screens
- **Widgets**: Reusable UI components

## 🔧 Key Dependencies

- **flutter_bloc**: State management
- **get_it**: Dependency injection
- **dartz**: Functional programming (Either, Option)
- **equatable**: Value equality
- **shared_preferences**: Local data storage

## 🎯 Clean Architecture Benefits

1. **Separation of Concerns**: Each layer has a single responsibility
2. **Testability**: Easy to unit test each layer independently
3. **Maintainability**: Changes in one layer don't affect others
4. **Scalability**: Easy to add new features following the same pattern
5. **Independence**: Business logic is independent of frameworks and UI

## 🚀 Adding a New Feature

To add a new feature, follow this structure:

1. Create feature folder under `lib/features/your_feature/`
2. Create domain layer:
   - Define entities
   - Define repository interface
   - Create use cases
3. Create data layer:
   - Implement data sources
   - Create models
   - Implement repository
4. Create presentation layer:
   - Create BLoC (events, states, bloc)
   - Create pages/widgets
5. Register dependencies in `injection_container.dart`

## 📝 Example: Counter Feature

The Counter feature demonstrates the complete Clean Architecture flow:

1. **User taps button** → CounterPage dispatches IncrementCounterEvent
2. **BLoC receives event** → Calls IncrementCounter use case
3. **Use case** → Calls repository.incrementCounter()
4. **Repository** → Calls data source to update local storage
5. **Data flows back** → BLoC emits new CounterLoaded state
6. **UI updates** → Page rebuilds with new counter value

## 🧪 Testing

Each layer can be tested independently:

- **Domain Layer**: Test use cases with mock repositories
- **Data Layer**: Test repositories with mock data sources
- **Presentation Layer**: Test BLoCs with mock use cases

## 📚 Resources

- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Clean Architecture Guide](https://resocoder.com/flutter-clean-architecture-tdd/)
