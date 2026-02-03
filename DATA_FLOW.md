# Clean Architecture Data Flow

## 📊 Complete Data Flow Diagram

```
┌─────────────────────────────────────────────────────────────────────┐
│                         PRESENTATION LAYER                          │
│  ┌───────────────────────────────────────────────────────────────┐ │
│  │                           UI (Page)                           │ │
│  │  • Displays data to user                                      │ │
│  │  • Captures user interactions                                 │ │
│  └──────────────────────┬────────────────────┬───────────────────┘ │
│                         │                    │                      │
│                    Dispatches           Listens to                  │
│                       Event              State                      │
│                         │                    │                      │
│  ┌──────────────────────▼────────────────────▼───────────────────┐ │
│  │                         BLoC                                   │ │
│  │  • Receives events from UI                                    │ │
│  │  • Processes business logic via use cases                     │ │
│  │  • Emits states back to UI                                    │ │
│  └──────────────────────┬────────────────────▲───────────────────┘ │
└─────────────────────────┼────────────────────┼─────────────────────┘
                          │                    │
                        Calls              Returns
                      Use Case            Either<Failure, Data>
                          │                    │
┌─────────────────────────▼────────────────────┴─────────────────────┐
│                          DOMAIN LAYER                               │
│  ┌───────────────────────────────────────────────────────────────┐ │
│  │                        Use Cases                              │ │
│  │  • Contains business rules                                    │ │
│  │  • Independent of frameworks                                  │ │
│  │  • Returns Either<Failure, Entity>                           │ │
│  └──────────────────────┬────────────────────▲───────────────────┘ │
│                         │                    │                      │
│                    Calls Repo           Returns Data                │
│                     Interface               or Error                │
│                         │                    │                      │
│  ┌──────────────────────▼────────────────────┴───────────────────┐ │
│  │                  Repository Interface                         │ │
│  │  • Abstract contract for data operations                      │ │
│  │  • Defines what data operations are needed                    │ │
│  └───────────────────────────────────────────────────────────────┘ │
└─────────────────────────┼────────────────────▲─────────────────────┘
                          │                    │
                    Implements              Returns
                    Repository         Either<Failure, Data>
                          │                    │
┌─────────────────────────▼────────────────────┴─────────────────────┐
│                          DATA LAYER                                 │
│  ┌───────────────────────────────────────────────────────────────┐ │
│  │              Repository Implementation                        │ │
│  │  • Implements domain repository                               │ │
│  │  • Decides where to get data (cache, API, etc.)              │ │
│  │  • Handles data transformation and error mapping             │ │
│  └─────────────┬──────────────────────────────┬─────────────────┘ │
│                │                              │                    │
│            Calls                          Calls                    │
│         Local DataSource              Remote DataSource            │
│                │                              │                    │
│  ┌─────────────▼──────────────┐ ┌───────────▼──────────────────┐ │
│  │  Local Data Source         │ │  Remote Data Source          │ │
│  │  • SharedPreferences       │ │  • HTTP Client               │ │
│  │  • SQLite                  │ │  • REST API                  │ │
│  │  • Hive, etc.             │ │  • GraphQL, etc.            │ │
│  └────────────────────────────┘ └──────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────────┘
```

## 🔄 Counter Example Flow

### Scenario: User Taps Increment Button

```
1. USER ACTION
   └─> User taps FloatingActionButton

2. PRESENTATION LAYER
   └─> CounterPage captures tap
       └─> Dispatches IncrementCounterEvent to CounterBloc
           └─> BLoC receives event in _onIncrementCounter()

3. DOMAIN LAYER
   └─> BLoC calls IncrementCounter use case
       └─> Use case calls repository.incrementCounter()

4. DATA LAYER
   └─> CounterRepositoryImpl receives call
       └─> Calls localDataSource.getCounter() to get current value
           └─> SharedPreferences returns current counter value (e.g., 5)
       └─> Calls localDataSource.saveCounter(6) to save new value
           └─> SharedPreferences saves and confirms

5. RETURN PATH (DATA → DOMAIN)
   └─> Repository returns Right(Counter(value: 6))
       └─> Use case returns Right(Counter(value: 6))

6. RETURN PATH (DOMAIN → PRESENTATION)
   └─> BLoC receives Either<Failure, Counter>
       └─> Folds the Either:
           • If Right: Emits CounterLoaded(value: 6)
           • If Left: Emits CounterError(message: '...')

7. UI UPDATE
   └─> CounterPage BlocBuilder receives new state
       └─> Rebuilds with new counter value
           └─> User sees "6" on screen
```

## 🎯 Dependency Rule

```
┌───────────────────────────────────────────────────────────┐
│  Dependencies flow INWARD only                            │
│                                                            │
│  Presentation ─────────────┐                              │
│       │                    │                              │
│       │                    ▼                              │
│       │            ┌──────────────┐                       │
│       └───────────>│    DOMAIN    │                       │
│                    │  (Core Logic) │                       │
│                    └──────────────┘                       │
│       ┌───────────>        ▲                              │
│       │                    │                              │
│       │                    │                              │
│   Data ────────────────────┘                              │
│                                                            │
│  ✓ Presentation depends on Domain                         │
│  ✓ Data depends on Domain                                 │
│  ✗ Domain NEVER depends on Presentation or Data           │
└───────────────────────────────────────────────────────────┘
```

## 🔀 Error Handling Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    ERROR SCENARIO                           │
│                                                              │
│  1. Data Source throws exception                            │
│     └─> try { ... } catch (e) { ... }                      │
│                                                              │
│  2. Repository catches exception                            │
│     └─> Returns Left(CacheFailure()) or Left(ServerFailure())│
│                                                              │
│  3. Use Case receives Either<Failure, Entity>               │
│     └─> Passes it up to BLoC                               │
│                                                              │
│  4. BLoC folds the Either                                   │
│     └─> On Left: Emits ErrorState with message            │
│                                                              │
│  5. UI receives ErrorState                                  │
│     └─> Displays error message to user                     │
└─────────────────────────────────────────────────────────────┘
```

## 📦 Dependency Injection Flow

```
main.dart
   │
   ├─> Calls WidgetsFlutterBinding.ensureInitialized()
   │
   ├─> Calls await di.init()
   │   │
   │   └─> injection_container.dart
   │       │
   │       ├─> Registers External Dependencies
   │       │   └─> SharedPreferences instance
   │       │
   │       ├─> Registers Data Sources
   │       │   └─> CounterLocalDataSource (depends on SharedPreferences)
   │       │
   │       ├─> Registers Repositories
   │       │   └─> CounterRepository (depends on DataSource)
   │       │
   │       ├─> Registers Use Cases
   │       │   ├─> GetCounter (depends on Repository)
   │       │   └─> IncrementCounter (depends on Repository)
   │       │
   │       └─> Registers BLoCs
   │           └─> CounterBloc (depends on Use Cases)
   │
   └─> Runs MyApp()
       │
       └─> CounterPage requests CounterBloc from GetIt (sl<CounterBloc>())
           └─> GetIt resolves all dependencies and creates instance
```

## 🧪 Testing Strategy

### Unit Tests by Layer

```
┌─────────────────────────────────────────────────────────────┐
│  DOMAIN LAYER TESTS                                          │
│  ├─> Use Case Tests                                         │
│  │   └─> Mock Repository                                    │
│  │   └─> Verify correct repository method is called         │
│  │   └─> Test success and failure scenarios                 │
│  │                                                           │
│  └─> Entity Tests                                           │
│      └─> Test equality (Equatable)                          │
│      └─> Test props                                         │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│  DATA LAYER TESTS                                            │
│  ├─> Repository Tests                                       │
│  │   └─> Mock Data Sources                                  │
│  │   └─> Verify data source methods are called              │
│  │   └─> Test error handling and mapping                    │
│  │                                                           │
│  ├─> Data Source Tests                                      │
│  │   └─> Mock SharedPreferences / HTTP Client               │
│  │   └─> Test serialization/deserialization                 │
│  │                                                           │
│  └─> Model Tests                                            │
│      └─> Test toJson() / fromJson()                         │
│      └─> Test model to entity conversion                    │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│  PRESENTATION LAYER TESTS                                    │
│  ├─> BLoC Tests                                             │
│  │   └─> Mock Use Cases                                     │
│  │   └─> Test event handling                                │
│  │   └─> Verify correct states are emitted                  │
│  │                                                           │
│  └─> Widget Tests                                           │
│      └─> Mock BLoC                                          │
│      └─> Test UI renders correctly for each state           │
│      └─> Test user interactions                             │
└─────────────────────────────────────────────────────────────┘
```

## 🎨 State Management Flow (BLoC)

```
┌────────────────────────────────────────────────────────────┐
│                                                             │
│  ┌──────────┐         Event          ┌──────────┐         │
│  │   UI     │ ──────────────────────> │   BLoC   │         │
│  │  (Page)  │                         │          │         │
│  │          │ <────────────────────── │          │         │
│  └──────────┘         State           └─────┬────┘         │
│       ▲                                     │              │
│       │                                     │              │
│       │ Rebuild                        Calls Use Case      │
│       │ on new                              │              │
│       │ state                                ▼              │
│       │                              ┌─────────────┐       │
│       └───────── Updates ────────────│  Use Case   │       │
│                 StreamBuilder        └─────────────┘       │
│                                                             │
└────────────────────────────────────────────────────────────┘

Event Types:
  • LoadDataEvent    → Initial data loading
  • CreateEvent      → Create new entity
  • UpdateEvent      → Update existing entity
  • DeleteEvent      → Delete entity

State Types:
  • InitialState     → Before any action
  • LoadingState     → During async operation
  • LoadedState      → Success with data
  • ErrorState       → Failure with error message
```

## 📚 Quick Reference

### File Naming Conventions
- **Entities**: `todo.dart`, `user.dart`
- **Models**: `todo_model.dart`, `user_model.dart`
- **Repositories**: `todo_repository.dart` (interface), `todo_repository_impl.dart` (implementation)
- **Use Cases**: `get_todos.dart`, `add_todo.dart` (action-based names)
- **Data Sources**: `todo_local_datasource.dart`, `todo_remote_datasource.dart`
- **BLoC**: `todo_bloc.dart`, `todo_event.dart`, `todo_state.dart`
- **Pages**: `todo_page.dart`, `todo_detail_page.dart`

### Import Rules
- ✅ Data layer can import from Domain layer
- ✅ Presentation layer can import from Domain layer
- ✅ Presentation layer can import from Data layer (only for DI setup)
- ❌ Domain layer should NEVER import from Data or Presentation
- ❌ Data layer should NEVER import from Presentation
- ❌ Avoid circular dependencies

This comprehensive data flow guide helps you understand how Clean Architecture works in practice!
