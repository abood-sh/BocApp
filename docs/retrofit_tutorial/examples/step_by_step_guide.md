# Step-by-Step Tutorial: Building Your First Retrofit API Service

This guide will walk you through creating a complete API service from scratch using the patterns found in BocApp.

## 🎯 What We'll Build

We'll create a **Todo API Service** that demonstrates:
- ✅ CRUD operations (Create, Read, Update, Delete)
- ✅ Proper error handling
- ✅ Repository pattern
- ✅ BLoC integration
- ✅ Model serialization

## 📋 Project Structure

```
lib/
├── features/
│   └── todos/
│       ├── data/
│       │   ├── api/
│       │   │   ├── todo_api_service.dart
│       │   │   └── todo_api_constants.dart
│       │   ├── models/
│       │   │   ├── todo_model.dart
│       │   │   ├── create_todo_request.dart
│       │   │   └── update_todo_request.dart
│       │   └── repository/
│       │       └── todo_repository.dart
│       ├── logic/
│       │   └── cubit/
│       │       ├── todo_cubit.dart
│       │       └── todo_state.dart
│       └── ui/
│           └── todo_screen.dart
└── core/
    └── networking/
        ├── api_service.dart
        ├── api_result.dart
        └── api_error_handler.dart
```

## Step 1: Define API Constants

Create constants for your endpoints:

```dart
// lib/features/todos/data/api/todo_api_constants.dart
class TodoApiConstants {
  static const String todos = 'todos';
  static const String todoById = 'todos/{id}';
}
```

## Step 2: Create Data Models

### Todo Model

```dart
// lib/features/todos/data/models/todo_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel {
  final int id;
  final String title;
  final String description;
  final bool completed;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  const TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);

  TodoModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? completed,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      completed: completed ?? this.completed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
```

### Request Models

```dart
// lib/features/todos/data/models/create_todo_request.dart
import 'package:json_annotation/json_annotation.dart';

part 'create_todo_request.g.dart';

@JsonSerializable()
class CreateTodoRequest {
  final String title;
  final String description;
  final bool completed;

  const CreateTodoRequest({
    required this.title,
    required this.description,
    this.completed = false,
  });

  factory CreateTodoRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateTodoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateTodoRequestToJson(this);
}
```

```dart
// lib/features/todos/data/models/update_todo_request.dart
import 'package:json_annotation/json_annotation.dart';

part 'update_todo_request.g.dart';

@JsonSerializable()
class UpdateTodoRequest {
  final String? title;
  final String? description;
  final bool? completed;

  const UpdateTodoRequest({
    this.title,
    this.description,
    this.completed,
  });

  factory UpdateTodoRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateTodoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTodoRequestToJson(this);
}
```

## Step 3: Create the API Service

```dart
// lib/features/todos/data/api/todo_api_service.dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/todo_model.dart';
import '../models/create_todo_request.dart';
import '../models/update_todo_request.dart';
import 'todo_api_constants.dart';
import '../../../../core/networking/api_constanta.dart';

part 'todo_api_service.g.dart';

@RestApi(baseUrl: ApiConstanta.apiBaseUrl)
abstract class TodoApiService {
  factory TodoApiService(Dio dio, {String baseUrl}) = _TodoApiService;

  /// Get all todos with optional pagination
  @GET(TodoApiConstants.todos)
  Future<List<TodoModel>> getTodos({
    @Query('page') int? page,
    @Query('limit') int? limit,
    @Query('completed') bool? completed,
  });

  /// Get a specific todo by ID
  @GET(TodoApiConstants.todoById)
  Future<TodoModel> getTodoById(@Path('id') int id);

  /// Create a new todo
  @POST(TodoApiConstants.todos)
  Future<TodoModel> createTodo(@Body() CreateTodoRequest request);

  /// Update an existing todo
  @PUT(TodoApiConstants.todoById)
  Future<TodoModel> updateTodo(
    @Path('id') int id,
    @Body() UpdateTodoRequest request,
  );

  /// Delete a todo
  @DELETE(TodoApiConstants.todoById)
  Future<void> deleteTodo(@Path('id') int id);

  /// Toggle todo completion status
  @PATCH('${TodoApiConstants.todoById}/toggle')
  Future<TodoModel> toggleTodo(@Path('id') int id);
}
```

## Step 4: Implement the Repository

```dart
// lib/features/todos/data/repository/todo_repository.dart
import 'package:dio/dio.dart';
import '../api/todo_api_service.dart';
import '../models/todo_model.dart';
import '../models/create_todo_request.dart';
import '../models/update_todo_request.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_error_handler.dart';

class TodoRepository {
  final TodoApiService _apiService;

  TodoRepository(this._apiService);

  Future<ApiResult<List<TodoModel>>> getTodos({
    int? page,
    int? limit,
    bool? completed,
  }) async {
    try {
      final response = await _apiService.getTodos(
        page: page,
        limit: limit,
        completed: completed,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<TodoModel>> getTodoById(int id) async {
    try {
      final response = await _apiService.getTodoById(id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<TodoModel>> createTodo(CreateTodoRequest request) async {
    try {
      final response = await _apiService.createTodo(request);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<TodoModel>> updateTodo(
    int id,
    UpdateTodoRequest request,
  ) async {
    try {
      final response = await _apiService.updateTodo(id, request);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> deleteTodo(int id) async {
    try {
      await _apiService.deleteTodo(id);
      return const ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<TodoModel>> toggleTodo(int id) async {
    try {
      final response = await _apiService.toggleTodo(id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
```

## Step 5: Create BLoC State Management

### Todo State

```dart
// lib/features/todos/logic/cubit/todo_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/todo_model.dart';

part 'todo_state.freezed.dart';

@freezed
class TodoState with _$TodoState {
  const factory TodoState.initial() = _Initial;
  
  const factory TodoState.loading() = _Loading;
  
  const factory TodoState.todosLoaded(List<TodoModel> todos) = _TodosLoaded;
  
  const factory TodoState.todoCreated(TodoModel todo) = _TodoCreated;
  
  const factory TodoState.todoUpdated(TodoModel todo) = _TodoUpdated;
  
  const factory TodoState.todoDeleted(int todoId) = _TodoDeleted;
  
  const factory TodoState.error(String message) = _Error;
}
```

### Todo Cubit

```dart
// lib/features/todos/logic/cubit/todo_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/todo_repository.dart';
import '../../data/models/todo_model.dart';
import '../../data/models/create_todo_request.dart';
import '../../data/models/update_todo_request.dart';
import 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository _repository;
  List<TodoModel> _todos = [];

  TodoCubit(this._repository) : super(const TodoState.initial());

  List<TodoModel> get todos => _todos;

  Future<void> loadTodos({
    int? page,
    int? limit,
    bool? completed,
  }) async {
    emit(const TodoState.loading());
    
    final result = await _repository.getTodos(
      page: page,
      limit: limit,
      completed: completed,
    );
    
    result.when(
      success: (todos) {
        _todos = todos;
        emit(TodoState.todosLoaded(todos));
      },
      failure: (error) {
        emit(TodoState.error(error.message ?? 'Failed to load todos'));
      },
    );
  }

  Future<void> createTodo({
    required String title,
    required String description,
    bool completed = false,
  }) async {
    final request = CreateTodoRequest(
      title: title,
      description: description,
      completed: completed,
    );
    
    final result = await _repository.createTodo(request);
    
    result.when(
      success: (todo) {
        _todos.add(todo);
        emit(TodoState.todoCreated(todo));
        emit(TodoState.todosLoaded(_todos));
      },
      failure: (error) {
        emit(TodoState.error(error.message ?? 'Failed to create todo'));
      },
    );
  }

  Future<void> updateTodo(
    int id, {
    String? title,
    String? description,
    bool? completed,
  }) async {
    final request = UpdateTodoRequest(
      title: title,
      description: description,
      completed: completed,
    );
    
    final result = await _repository.updateTodo(id, request);
    
    result.when(
      success: (updatedTodo) {
        final index = _todos.indexWhere((todo) => todo.id == id);
        if (index != -1) {
          _todos[index] = updatedTodo;
        }
        emit(TodoState.todoUpdated(updatedTodo));
        emit(TodoState.todosLoaded(_todos));
      },
      failure: (error) {
        emit(TodoState.error(error.message ?? 'Failed to update todo'));
      },
    );
  }

  Future<void> deleteTodo(int id) async {
    final result = await _repository.deleteTodo(id);
    
    result.when(
      success: (_) {
        _todos.removeWhere((todo) => todo.id == id);
        emit(TodoState.todoDeleted(id));
        emit(TodoState.todosLoaded(_todos));
      },
      failure: (error) {
        emit(TodoState.error(error.message ?? 'Failed to delete todo'));
      },
    );
  }

  Future<void> toggleTodo(int id) async {
    final result = await _repository.toggleTodo(id);
    
    result.when(
      success: (updatedTodo) {
        final index = _todos.indexWhere((todo) => todo.id == id);
        if (index != -1) {
          _todos[index] = updatedTodo;
        }
        emit(TodoState.todoUpdated(updatedTodo));
        emit(TodoState.todosLoaded(_todos));
      },
      failure: (error) {
        emit(TodoState.error(error.message ?? 'Failed to toggle todo'));
      },
    );
  }
}
```

## Step 6: Generate Code

Run the code generation command:

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

This will generate:
- `todo_model.g.dart`
- `create_todo_request.g.dart`
- `update_todo_request.g.dart`
- `todo_api_service.g.dart`
- `todo_state.freezed.dart`

## Step 7: Set up Dependency Injection

```dart
// lib/core/di/dependency_injection.dart
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../networking/dio_factory.dart';
import '../../features/todos/data/api/todo_api_service.dart';
import '../../features/todos/data/repository/todo_repository.dart';
import '../../features/todos/logic/cubit/todo_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio instance
  getIt.registerLazySingleton<Dio>(() => DioFactory.create());

  // API Services
  getIt.registerLazySingleton<TodoApiService>(
    () => TodoApiService(getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<TodoRepository>(
    () => TodoRepository(getIt()),
  );

  // Cubits
  getIt.registerFactory<TodoCubit>(
    () => TodoCubit(getIt()),
  );
}
```

## 🎉 Congratulations!

You've successfully created a complete Retrofit API service with:

✅ **Type-safe API calls** with Retrofit annotations  
✅ **Proper error handling** with ApiResult pattern  
✅ **Clean architecture** with repository pattern  
✅ **State management** with BLoC/Cubit  
✅ **Code generation** for models and API services  
✅ **Dependency injection** for loose coupling  

## 🔧 Next Steps

1. **Create the UI** to interact with your API service
2. **Add unit tests** for your repository and cubit
3. **Implement caching** for offline support
4. **Add pagination** for large datasets
5. **Implement search and filtering**

## 📚 Key Takeaways

- **Separation of concerns**: API service, repository, and business logic are separated
- **Type safety**: Compile-time checking prevents runtime errors
- **Error handling**: Consistent error handling across the app
- **Testability**: Each layer can be tested independently
- **Maintainability**: Code is organized and easy to understand

This pattern is used throughout the BocApp project and represents industry best practices for Flutter app architecture!