# Retrofit Tutorial Exercises

Complete these hands-on exercises to master Retrofit in Flutter. Each exercise builds upon the previous one and teaches important concepts.

## 🎯 Exercise 1: Basic API Service (Beginner)

**Goal**: Create a simple Weather API service

### Task
Create an API service to fetch weather information from a public weather API.

### Requirements
1. Create a `WeatherApiService` with these endpoints:
   - `GET /weather` - Get current weather by city name
   - `GET /forecast` - Get 5-day weather forecast

2. Create these models:
   - `WeatherModel` - Current weather data
   - `ForecastModel` - Forecast data
   - `WeatherRequest` - Request parameters

### Code Template

```dart
// weather_api_service.dart
@RestApi(baseUrl: 'https://api.openweathermap.org/data/2.5/')
abstract class WeatherApiService {
  factory WeatherApiService(Dio dio) = _WeatherApiService;

  // TODO: Add GET method for current weather
  // Endpoint: 'weather'
  // Query parameters: q (city), appid (API key)

  // TODO: Add GET method for forecast
  // Endpoint: 'forecast'
  // Query parameters: q (city), appid (API key)
}
```

### Expected Output
```dart
final weatherService = WeatherApiService(dio);
final weather = await weatherService.getCurrentWeather('London', 'your-api-key');
print('Temperature: ${weather.main.temp}°C');
```

---

## 🔥 Exercise 2: CRUD Operations (Intermediate)

**Goal**: Implement a complete Blog Post API with CRUD operations

### Task
Create a blog API service with full CRUD functionality.

### Requirements
1. Create `BlogApiService` with these endpoints:
   - `GET /posts` - List all posts (with pagination)
   - `GET /posts/{id}` - Get specific post
   - `POST /posts` - Create new post
   - `PUT /posts/{id}` - Update existing post
   - `DELETE /posts/{id}` - Delete post

2. Create these models:
   - `BlogPostModel`
   - `CreatePostRequest`
   - `UpdatePostRequest`
   - `PaginatedResponse<T>`

3. Implement repository pattern with error handling

### Code Template

```dart
@JsonSerializable()
class BlogPostModel {
  final int id;
  final String title;
  final String content;
  final String author;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  // TODO: Complete the model
}

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class BlogApiService {
  // TODO: Implement all CRUD operations
}
```

### Challenge Points
- Add proper error handling for each operation
- Implement optimistic updates in the repository
- Add validation for request models

---

## 🚀 Exercise 3: Advanced Features (Advanced)

**Goal**: Implement file upload with progress tracking

### Task
Create an API service that handles file uploads with progress tracking and metadata.

### Requirements
1. Create `FileUploadService` with:
   - `POST /upload` - Upload single file
   - `POST /upload/multiple` - Upload multiple files
   - `GET /files` - List uploaded files
   - `DELETE /files/{id}` - Delete file

2. Features to implement:
   - Progress tracking during upload
   - File type validation
   - Thumbnail generation for images
   - Metadata extraction

### Code Template

```dart
@RestApi(baseUrl: 'https://api.example.com/v1/')
abstract class FileUploadService {
  @POST('/upload')
  @MultiPart()
  Future<FileUploadResponse> uploadFile(
    @Part() File file,
    @Part('metadata') String metadata,
  );

  // TODO: Add multiple file upload
  // TODO: Add file listing endpoint
  // TODO: Add file deletion endpoint
}

class FileUploadRepository {
  final FileUploadService _apiService;

  FileUploadRepository(this._apiService);

  Stream<double> uploadFileWithProgress(File file) async* {
    // TODO: Implement progress tracking
    // Hint: Use Dio's onSendProgress callback
  }
}
```

### Challenge Points
- Implement progress tracking using Dio interceptors
- Add file size and type validation
- Handle upload cancellation
- Implement retry mechanism for failed uploads

---

## 🔒 Exercise 4: Authentication & Security (Expert)

**Goal**: Implement secure authentication flow with token refresh

### Task
Create a complete authentication system with automatic token refresh.

### Requirements
1. Create `AuthApiService` with:
   - `POST /auth/login` - User login
   - `POST /auth/refresh` - Refresh access token
   - `POST /auth/logout` - User logout
   - `GET /auth/profile` - Get user profile (protected)

2. Implement automatic token refresh:
   - Intercept 401 responses
   - Automatically refresh tokens
   - Retry original request
   - Handle refresh token expiration

### Code Template

```dart
class AuthInterceptor extends Interceptor {
  final AuthRepository _authRepository;

  AuthInterceptor(this._authRepository);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: Add access token to headers
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: Handle 401 errors and refresh token
  }
}

@RestApi(baseUrl: 'https://api.example.com/v1/')
abstract class AuthApiService {
  @POST('/auth/login')
  Future<LoginResponse> login(@Body() LoginRequest request);

  // TODO: Add refresh endpoint
  // TODO: Add logout endpoint
  // TODO: Add protected profile endpoint
}
```

### Challenge Points
- Implement secure token storage
- Handle concurrent requests during token refresh
- Add biometric authentication
- Implement session timeout

---

## 🌐 Exercise 5: Real-time Features (Expert)

**Goal**: Combine REST API with WebSocket for real-time updates

### Task
Create a chat application that uses REST API for initial data and WebSocket for real-time messages.

### Requirements
1. REST API endpoints:
   - `GET /chats` - List user's chats
   - `GET /chats/{id}/messages` - Get chat history
   - `POST /chats` - Create new chat

2. WebSocket features:
   - Real-time message delivery
   - Typing indicators
   - User presence status
   - Message read receipts

### Code Template

```dart
class ChatService {
  final ChatApiService _apiService;
  late WebSocketChannel _channel;

  ChatService(this._apiService);

  Stream<ChatMessage> get messageStream => _channel.stream
      .map((data) => ChatMessage.fromJson(jsonDecode(data)));

  Future<void> connect(String userId) async {
    // TODO: Establish WebSocket connection
  }

  Future<void> sendMessage(String chatId, String message) async {
    // TODO: Send message via WebSocket
  }

  Future<List<ChatMessage>> getChatHistory(String chatId) async {
    // TODO: Use REST API to get message history
  }
}
```

### Challenge Points
- Handle connection drops and reconnection
- Implement message queue for offline mode
- Add end-to-end encryption
- Optimize for battery usage

---

## 🎯 Exercise Solutions

### Exercise 1 Solution

<details>
<summary>Click to see solution</summary>

```dart
@JsonSerializable()
class WeatherModel {
  final MainWeather main;
  final String name;
  final List<WeatherDescription> weather;

  WeatherModel({
    required this.main,
    required this.name,
    required this.weather,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}

@JsonSerializable()
class MainWeather {
  final double temp;
  final double humidity;
  final double pressure;

  MainWeather({
    required this.temp,
    required this.humidity,
    required this.pressure,
  });

  factory MainWeather.fromJson(Map<String, dynamic> json) =>
      _$MainWeatherFromJson(json);
}

@RestApi(baseUrl: 'https://api.openweathermap.org/data/2.5/')
abstract class WeatherApiService {
  factory WeatherApiService(Dio dio) = _WeatherApiService;

  @GET('/weather')
  Future<WeatherModel> getCurrentWeather(
    @Query('q') String city,
    @Query('appid') String apiKey,
  );

  @GET('/forecast')
  Future<ForecastModel> getForecast(
    @Query('q') String city,
    @Query('appid') String apiKey,
  );
}
```
</details>

### Exercise 2 Solution

<details>
<summary>Click to see solution</summary>

```dart
@JsonSerializable()
class BlogPostModel {
  final int id;
  final String title;
  final String content;
  final String author;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  BlogPostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.createdAt,
  });

  factory BlogPostModel.fromJson(Map<String, dynamic> json) =>
      _$BlogPostModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$BlogPostModelToJson(this);
}

@RestApi(baseUrl: 'https://jsonplaceholder.typicode.com/')
abstract class BlogApiService {
  factory BlogApiService(Dio dio) = _BlogApiService;

  @GET('/posts')
  Future<List<BlogPostModel>> getPosts(
    @Query('_page') int? page,
    @Query('_limit') int? limit,
  );

  @GET('/posts/{id}')
  Future<BlogPostModel> getPost(@Path('id') int id);

  @POST('/posts')
  Future<BlogPostModel> createPost(@Body() CreatePostRequest request);

  @PUT('/posts/{id}')
  Future<BlogPostModel> updatePost(
    @Path('id') int id,
    @Body() UpdatePostRequest request,
  );

  @DELETE('/posts/{id}')
  Future<void> deletePost(@Path('id') int id);
}
```
</details>

---

## 🏆 Completion Checklist

Mark off each exercise as you complete it:

- [ ] **Exercise 1**: Basic API Service ⭐
- [ ] **Exercise 2**: CRUD Operations ⭐⭐
- [ ] **Exercise 3**: File Upload ⭐⭐⭐
- [ ] **Exercise 4**: Authentication ⭐⭐⭐⭐
- [ ] **Exercise 5**: Real-time Features ⭐⭐⭐⭐⭐

## 🎯 Bonus Challenges

Once you've completed all exercises, try these bonus challenges:

1. **Performance Optimization**: Implement request caching with TTL
2. **Offline Mode**: Add offline support with local database sync
3. **Testing**: Write comprehensive unit and integration tests
4. **Error Recovery**: Implement intelligent retry strategies
5. **Monitoring**: Add API call analytics and performance monitoring

## 📚 Resources for Solutions

- [BocApp Repository](https://github.com/abood-sh/BocApp) - See real implementations
- [Retrofit Documentation](https://pub.dev/packages/retrofit)
- [Dio Documentation](https://pub.dev/packages/dio)
- [Flutter Testing Guide](https://docs.flutter.dev/testing)

---

**Happy coding! 🚀**

*Remember: The goal is not just to complete the exercises, but to understand the patterns and principles behind them.*