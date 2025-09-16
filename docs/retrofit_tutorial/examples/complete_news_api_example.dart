// Practical Example: Complete News API Implementation
// This example shows how to implement a News API service following the BocApp patterns

// ==================== API Constants ====================
class NewsApiConstants {
  static const String articles = 'articles';
  static const String topHeadlines = 'top-headlines';
  static const String everything = 'everything';
  static const String sources = 'sources';
}

// ==================== Models ====================

// lib/features/news/data/models/article_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel {
  final String? title;
  final String? description;
  final String? url;
  @JsonKey(name: 'urlToImage')
  final String? imageUrl;
  @JsonKey(name: 'publishedAt')
  final DateTime? publishedAt;
  final ArticleSource? source;
  final String? author;
  final String? content;

  const ArticleModel({
    this.title,
    this.description,
    this.url,
    this.imageUrl,
    this.publishedAt,
    this.source,
    this.author,
    this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}

@JsonSerializable()
class ArticleSource {
  final String? id;
  final String name;

  const ArticleSource({
    this.id,
    required this.name,
  });

  factory ArticleSource.fromJson(Map<String, dynamic> json) =>
      _$ArticleSourceFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleSourceToJson(this);
}

@JsonSerializable()
class NewsResponse {
  final String status;
  @JsonKey(name: 'totalResults')
  final int totalResults;
  final List<ArticleModel> articles;

  const NewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResponseToJson(this);
}

// ==================== API Service ====================

// lib/features/news/data/api/news_api_service.dart
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/article_model.dart';
import 'news_api_constants.dart';

part 'news_api_service.g.dart';

@RestApi(baseUrl: 'https://newsapi.org/v2/')
abstract class NewsApiService {
  factory NewsApiService(Dio dio, {String baseUrl}) = _NewsApiService;

  /// Get top headlines
  @GET(NewsApiConstants.topHeadlines)
  Future<NewsResponse> getTopHeadlines({
    @Query('country') String? country,
    @Query('category') String? category,
    @Query('sources') String? sources,
    @Query('q') String? query,
    @Query('pageSize') int? pageSize,
    @Query('page') int? page,
    @Query('apiKey') required String apiKey,
  });

  /// Search everything
  @GET(NewsApiConstants.everything)
  Future<NewsResponse> searchEverything({
    @Query('q') String? query,
    @Query('qInTitle') String? queryInTitle,
    @Query('sources') String? sources,
    @Query('domains') String? domains,
    @Query('excludeDomains') String? excludeDomains,
    @Query('from') String? from,
    @Query('to') String? to,
    @Query('language') String? language,
    @Query('sortBy') String? sortBy,
    @Query('pageSize') int? pageSize,
    @Query('page') int? page,
    @Query('apiKey') required String apiKey,
  });

  /// Get sources
  @GET(NewsApiConstants.sources)
  Future<SourcesResponse> getSources({
    @Query('category') String? category,
    @Query('language') String? language,
    @Query('country') String? country,
    @Query('apiKey') required String apiKey,
  });
}

@JsonSerializable()
class SourcesResponse {
  final String status;
  final List<NewsSource> sources;

  const SourcesResponse({
    required this.status,
    required this.sources,
  });

  factory SourcesResponse.fromJson(Map<String, dynamic> json) =>
      _$SourcesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SourcesResponseToJson(this);
}

@JsonSerializable()
class NewsSource {
  final String id;
  final String name;
  final String description;
  final String url;
  final String category;
  final String language;
  final String country;

  const NewsSource({
    required this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.category,
    required this.language,
    required this.country,
  });

  factory NewsSource.fromJson(Map<String, dynamic> json) =>
      _$NewsSourceFromJson(json);

  Map<String, dynamic> toJson() => _$NewsSourceToJson(this);
}

// ==================== Repository ====================

// lib/features/news/data/repository/news_repository.dart
import 'package:dio/dio.dart';
import '../api/news_api_service.dart';
import '../models/article_model.dart';
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_error_handler.dart';

class NewsRepository {
  final NewsApiService _apiService;
  final String _apiKey;

  NewsRepository(this._apiService, this._apiKey);

  Future<ApiResult<NewsResponse>> getTopHeadlines({
    String? country = 'us',
    String? category,
    String? sources,
    String? query,
    int? pageSize = 20,
    int? page = 1,
  }) async {
    try {
      final response = await _apiService.getTopHeadlines(
        country: country,
        category: category,
        sources: sources,
        query: query,
        pageSize: pageSize,
        page: page,
        apiKey: _apiKey,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<NewsResponse>> searchNews({
    String? query,
    String? queryInTitle,
    String? sources,
    String? domains,
    String? excludeDomains,
    String? from,
    String? to,
    String? language = 'en',
    String? sortBy = 'publishedAt',
    int? pageSize = 20,
    int? page = 1,
  }) async {
    try {
      final response = await _apiService.searchEverything(
        query: query,
        queryInTitle: queryInTitle,
        sources: sources,
        domains: domains,
        excludeDomains: excludeDomains,
        from: from,
        to: to,
        language: language,
        sortBy: sortBy,
        pageSize: pageSize,
        page: page,
        apiKey: _apiKey,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<SourcesResponse>> getSources({
    String? category,
    String? language,
    String? country,
  }) async {
    try {
      final response = await _apiService.getSources(
        category: category,
        language: language,
        country: country,
        apiKey: _apiKey,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}

// ==================== State Management ====================

// lib/features/news/logic/cubit/news_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/article_model.dart';

part 'news_state.freezed.dart';

@freezed
class NewsState with _$NewsState {
  const factory NewsState.initial() = _Initial;
  
  const factory NewsState.loading() = _Loading;
  
  const factory NewsState.headlinesLoaded({
    required List<ArticleModel> articles,
    required int totalResults,
    required int currentPage,
    required bool hasMorePages,
  }) = _HeadlinesLoaded;
  
  const factory NewsState.searchResultsLoaded({
    required List<ArticleModel> articles,
    required int totalResults,
    required int currentPage,
    required bool hasMorePages,
    required String query,
  }) = _SearchResultsLoaded;
  
  const factory NewsState.sourcesLoaded({
    required List<NewsSource> sources,
  }) = _SourcesLoaded;
  
  const factory NewsState.error(String message) = _Error;
}

// lib/features/news/logic/cubit/news_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/news_repository.dart';
import '../../data/models/article_model.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository _repository;
  
  List<ArticleModel> _currentArticles = [];
  int _currentPage = 1;
  String? _currentQuery;
  
  NewsCubit(this._repository) : super(const NewsState.initial());

  Future<void> loadTopHeadlines({
    String? country = 'us',
    String? category,
    bool refresh = false,
  }) async {
    if (refresh) {
      _currentArticles.clear();
      _currentPage = 1;
      emit(const NewsState.loading());
    }

    final result = await _repository.getTopHeadlines(
      country: country,
      category: category,
      page: _currentPage,
    );

    result.when(
      success: (response) {
        if (refresh) {
          _currentArticles = response.articles;
        } else {
          _currentArticles.addAll(response.articles);
        }
        
        final hasMore = _currentArticles.length < response.totalResults;
        
        emit(NewsState.headlinesLoaded(
          articles: _currentArticles,
          totalResults: response.totalResults,
          currentPage: _currentPage,
          hasMorePages: hasMore,
        ));
        
        if (!refresh) _currentPage++;
      },
      failure: (error) {
        emit(NewsState.error(error.message ?? 'Failed to load headlines'));
      },
    );
  }

  Future<void> searchNews({
    required String query,
    bool refresh = false,
  }) async {
    if (refresh || query != _currentQuery) {
      _currentArticles.clear();
      _currentPage = 1;
      _currentQuery = query;
      emit(const NewsState.loading());
    }

    final result = await _repository.searchNews(
      query: query,
      page: _currentPage,
    );

    result.when(
      success: (response) {
        if (refresh || query != _currentQuery) {
          _currentArticles = response.articles;
        } else {
          _currentArticles.addAll(response.articles);
        }
        
        final hasMore = _currentArticles.length < response.totalResults;
        
        emit(NewsState.searchResultsLoaded(
          articles: _currentArticles,
          totalResults: response.totalResults,
          currentPage: _currentPage,
          hasMorePages: hasMore,
          query: query,
        ));
        
        if (!refresh) _currentPage++;
      },
      failure: (error) {
        emit(NewsState.error(error.message ?? 'Failed to search news'));
      },
    );
  }

  Future<void> loadSources({
    String? category,
    String? language,
    String? country,
  }) async {
    emit(const NewsState.loading());
    
    final result = await _repository.getSources(
      category: category,
      language: language,
      country: country,
    );

    result.when(
      success: (response) {
        emit(NewsState.sourcesLoaded(sources: response.sources));
      },
      failure: (error) {
        emit(NewsState.error(error.message ?? 'Failed to load sources'));
      },
    );
  }

  Future<void> loadMoreArticles() async {
    if (_currentQuery != null) {
      await searchNews(query: _currentQuery!);
    } else {
      await loadTopHeadlines();
    }
  }

  void resetState() {
    _currentArticles.clear();
    _currentPage = 1;
    _currentQuery = null;
    emit(const NewsState.initial());
  }
}

// ==================== Usage Example ====================

/*
// In your main.dart or dependency injection setup:
void setupDependencies() {
  final dio = DioFactory.create();
  final newsApiService = NewsApiService(dio);
  final newsRepository = NewsRepository(newsApiService, 'YOUR_API_KEY');
  
  GetIt.instance.registerSingleton<NewsRepository>(newsRepository);
  GetIt.instance.registerFactory<NewsCubit>(() => NewsCubit(GetIt.instance()));
}

// In your UI:
class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance<NewsCubit>()..loadTopHeadlines(refresh: true),
      child: Scaffold(
        appBar: AppBar(title: Text('News')),
        body: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            return state.when(
              initial: () => Center(child: Text('Welcome to News')),
              loading: () => Center(child: CircularProgressIndicator()),
              headlinesLoaded: (articles, totalResults, currentPage, hasMorePages) {
                return ListView.builder(
                  itemCount: articles.length + (hasMorePages ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == articles.length) {
                      return Center(
                        child: ElevatedButton(
                          onPressed: () => context.read<NewsCubit>().loadMoreArticles(),
                          child: Text('Load More'),
                        ),
                      );
                    }
                    
                    final article = articles[index];
                    return ListTile(
                      title: Text(article.title ?? 'No title'),
                      subtitle: Text(article.description ?? 'No description'),
                      leading: article.imageUrl != null
                          ? Image.network(article.imageUrl!, width: 60, height: 60, fit: BoxFit.cover)
                          : null,
                      onTap: () {
                        // Navigate to article details
                      },
                    );
                  },
                );
              },
              searchResultsLoaded: (articles, totalResults, currentPage, hasMorePages, query) {
                // Similar to headlines loaded
                return Container();
              },
              sourcesLoaded: (sources) {
                return ListView.builder(
                  itemCount: sources.length,
                  itemBuilder: (context, index) {
                    final source = sources[index];
                    return ListTile(
                      title: Text(source.name),
                      subtitle: Text(source.description),
                    );
                  },
                );
              },
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: $message'),
                    ElevatedButton(
                      onPressed: () => context.read<NewsCubit>().loadTopHeadlines(refresh: true),
                      child: Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
*/

// ==================== Testing Example ====================

/*
// test/features/news/data/repository/news_repository_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([NewsApiService])
import 'news_repository_test.mocks.dart';

void main() {
  group('NewsRepository', () {
    late NewsRepository repository;
    late MockNewsApiService mockApiService;

    setUp(() {
      mockApiService = MockNewsApiService();
      repository = NewsRepository(mockApiService, 'test-api-key');
    });

    test('should return success when API call is successful', () async {
      // Arrange
      final mockResponse = NewsResponse(
        status: 'ok',
        totalResults: 1,
        articles: [
          ArticleModel(
            title: 'Test Article',
            description: 'Test Description',
            url: 'https://example.com',
          ),
        ],
      );
      
      when(mockApiService.getTopHeadlines(
        country: anyNamed('country'),
        apiKey: anyNamed('apiKey'),
      )).thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.getTopHeadlines();

      // Assert
      expect(result.isSuccess, true);
      result.when(
        success: (response) {
          expect(response.articles.length, 1);
          expect(response.articles.first.title, 'Test Article');
        },
        failure: (_) => fail('Should not be failure'),
      );
    });
  });
}
*/