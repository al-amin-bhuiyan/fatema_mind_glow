# How to Add a New Feature Using Clean Architecture

This guide walks you through adding a new feature to the app following Clean Architecture principles.

## Example: Adding a "Todo List" Feature

### Step 1: Create the Feature Folder Structure

```
lib/features/todo/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── bloc/
    ├── pages/
    └── widgets/
```

### Step 2: Domain Layer (Business Logic First!)

#### 2.1 Create Entity
```dart
// lib/features/todo/domain/entities/todo.dart
import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;

  const Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
  });

  @override
  List<Object> get props => [id, title, description, isCompleted, createdAt];
}
```

#### 2.2 Create Repository Interface
```dart
// lib/features/todo/domain/repositories/todo_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, List<Todo>>> getTodos();
  Future<Either<Failure, Todo>> addTodo(String title, String description);
  Future<Either<Failure, Todo>> updateTodo(Todo todo);
  Future<Either<Failure, void>> deleteTodo(String id);
}
```

#### 2.3 Create Use Cases
```dart
// lib/features/todo/domain/usecases/get_todos.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetTodos implements UseCase<List<Todo>, NoParams> {
  final TodoRepository repository;

  GetTodos(this.repository);

  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async {
    return await repository.getTodos();
  }
}
```

```dart
// lib/features/todo/domain/usecases/add_todo.dart
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class AddTodo implements UseCase<Todo, AddTodoParams> {
  final TodoRepository repository;

  AddTodo(this.repository);

  @override
  Future<Either<Failure, Todo>> call(AddTodoParams params) async {
    return await repository.addTodo(params.title, params.description);
  }
}

class AddTodoParams extends Equatable {
  final String title;
  final String description;

  const AddTodoParams({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}
```

### Step 3: Data Layer

#### 3.1 Create Model
```dart
// lib/features/todo/data/models/todo_model.dart
import '../../domain/entities/todo.dart';

class TodoModel extends Todo {
  const TodoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.isCompleted,
    required super.createdAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
```

#### 3.2 Create Data Source
```dart
// lib/features/todo/data/datasources/todo_local_datasource.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getTodos();
  Future<void> cacheTodos(List<TodoModel> todos);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const CACHED_TODOS = 'CACHED_TODOS';

  TodoLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<TodoModel>> getTodos() {
    final jsonString = sharedPreferences.getString(CACHED_TODOS);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return Future.value(
        jsonList.map((json) => TodoModel.fromJson(json)).toList(),
      );
    }
    return Future.value([]);
  }

  @override
  Future<void> cacheTodos(List<TodoModel> todos) {
    final jsonList = todos.map((todo) => todo.toJson()).toList();
    return sharedPreferences.setString(
      CACHED_TODOS,
      json.encode(jsonList),
    );
  }
}
```

#### 3.3 Implement Repository
```dart
// lib/features/todo/data/repositories/todo_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_datasource.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;
  final Uuid uuid = const Uuid();

  TodoRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      final todos = await localDataSource.getTodos();
      return Right(todos);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Todo>> addTodo(String title, String description) async {
    try {
      final todos = await localDataSource.getTodos();
      final newTodo = TodoModel(
        id: uuid.v4(),
        title: title,
        description: description,
        isCompleted: false,
        createdAt: DateTime.now(),
      );
      todos.add(newTodo);
      await localDataSource.cacheTodos(todos);
      return Right(newTodo);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  // Implement other methods...
}
```

### Step 4: Presentation Layer

#### 4.1 Create BLoC Events
```dart
// lib/features/todo/presentation/bloc/todo_event.dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/todo.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodosEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String title;
  final String description;

  const AddTodoEvent({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}

class ToggleTodoEvent extends TodoEvent {
  final Todo todo;

  const ToggleTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}
```

#### 4.2 Create BLoC States
```dart
// lib/features/todo/presentation/bloc/todo_state.dart
import 'package:equatable/equatable.dart';
import '../../domain/entities/todo.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;

  const TodoLoaded({required this.todos});

  @override
  List<Object> get props => [todos];
}

class TodoError extends TodoState {
  final String message;

  const TodoError({required this.message});

  @override
  List<Object> get props => [message];
}
```

#### 4.3 Create BLoC
```dart
// lib/features/todo/presentation/bloc/todo_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/get_todos.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodos getTodos;
  final AddTodo addTodo;

  TodoBloc({
    required this.getTodos,
    required this.addTodo,
  }) : super(TodoInitial()) {
    on<LoadTodosEvent>(_onLoadTodos);
    on<AddTodoEvent>(_onAddTodo);
  }

  Future<void> _onLoadTodos(
    LoadTodosEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    final failureOrTodos = await getTodos(NoParams());
    failureOrTodos.fold(
      (failure) => emit(const TodoError(message: 'Failed to load todos')),
      (todos) => emit(TodoLoaded(todos: todos)),
    );
  }

  Future<void> _onAddTodo(
    AddTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final failureOrTodo = await addTodo(
      AddTodoParams(title: event.title, description: event.description),
    );
    failureOrTodo.fold(
      (failure) => emit(const TodoError(message: 'Failed to add todo')),
      (todo) {
        // Reload todos
        add(LoadTodosEvent());
      },
    );
  }
}
```

#### 4.4 Create Page
```dart
// lib/features/todo/presentation/pages/todo_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TodoBloc>()..add(LoadTodosEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        body: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TodoLoaded) {
              return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (context, index) {
                  final todo = state.todos[index];
                  return ListTile(
                    title: Text(todo.title),
                    subtitle: Text(todo.description),
                    leading: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (_) {
                        // Handle toggle
                      },
                    ),
                  );
                },
              );
            } else if (state is TodoError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Show dialog to add todo
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
```

### Step 5: Register Dependencies

Update `injection_container.dart`:

```dart
// Add to init() function

// Features - Todo
// Bloc
sl.registerFactory(
  () => TodoBloc(
    getTodos: sl(),
    addTodo: sl(),
  ),
);

// Use cases
sl.registerLazySingleton(() => GetTodos(sl()));
sl.registerLazySingleton(() => AddTodo(sl()));

// Repository
sl.registerLazySingleton<TodoRepository>(
  () => TodoRepositoryImpl(
    localDataSource: sl(),
  ),
);

// Data sources
sl.registerLazySingleton<TodoLocalDataSource>(
  () => TodoLocalDataSourceImpl(
    sharedPreferences: sl(),
  ),
);
```

### Step 6: Add Route to Main App

Update navigation in your app to include the new TodoPage.

## 📋 Checklist for New Features

- [ ] Define entity in domain layer
- [ ] Create repository interface
- [ ] Create use cases
- [ ] Create model extending entity
- [ ] Implement data source(s)
- [ ] Implement repository
- [ ] Create BLoC events
- [ ] Create BLoC states
- [ ] Implement BLoC
- [ ] Create UI pages/widgets
- [ ] Register all dependencies
- [ ] Add navigation/routing
- [ ] Write tests for each layer

## 🎯 Best Practices

1. **Always start with the Domain layer** - Define what your app should do before worrying about how
2. **Keep use cases simple** - One use case = one action
3. **Use dependency injection** - Makes testing easier
4. **Keep layers independent** - Domain shouldn't know about data or presentation
5. **Use value objects** - Leverage Equatable for equality comparisons
6. **Handle errors properly** - Use Either<Failure, Success> pattern
7. **Write tests** - Test each layer independently

## 🔍 Common Patterns

### API Data Source
```dart
abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> getTodosFromApi();
  Future<TodoModel> postTodo(TodoModel todo);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final http.Client client;
  
  TodoRemoteDataSourceImpl({required this.client});
  
  @override
  Future<List<TodoModel>> getTodosFromApi() async {
    final response = await client.get(Uri.parse('https://api.example.com/todos'));
    if (response.statusCode == 200) {
      // Parse and return
    } else {
      throw ServerException();
    }
  }
}
```

### Network Info (Check Internet Connection)
```dart
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;
  
  NetworkInfoImpl(this.connectionChecker);
  
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
```

This guide provides a complete blueprint for extending your Clean Architecture app with new features!
