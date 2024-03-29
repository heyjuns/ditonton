import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_list_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/popular_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/search_bloc.dart';
import 'package:ditonton/presentation/bloc/search_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_list_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/db/database_helper.dart';
import 'data/datasources/db/tv_database_helper.dart';
import 'data/datasources/tv_local_data_source.dart';
import 'data/datasources/tv_remote_data_source.dart';
import 'data/repositories/tv_repository_impl.dart';
import 'domain/usecases/get_now_playing_tvs.dart';
import 'domain/usecases/get_popular_tv.dart';
import 'domain/usecases/get_top_rated_tv.dart';
import 'domain/usecases/get_tv_detail.dart';
import 'domain/usecases/get_tv_recommendations.dart';
import 'domain/usecases/get_watchlist_tv_status.dart';
import 'domain/usecases/search_tv.dart';
import 'package:core/core.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(
    () => WatchlistMoviesBloc(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => SearchBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => PopularMoviesBloc(
      getPopularMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedMoviesBloc(
      getTopRatedMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieListBloc(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );
//tv
  locator.registerFactory(
    () => TvDetailBloc(
      getTvDetail: locator(),
      getTvRecommendations: locator(),
      getWatchListTvStatus: locator(),
      saveWatchlistTv: locator(),
      removeWatchlistTv: locator(),
    ),
  );

  locator.registerFactory(
    () => TvListBloc(
      getNowPlayingTvs: locator(),
      getPopularTvs: locator(),
      getTopRatedTvs: locator(),
    ),
  );

  locator.registerFactory(
    () => SearchTvsBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TopRatedTvsBloc(
      getTopRatedTvs: locator(),
    ),
  );

  locator.registerFactory(
    () => PopularTvsBloc(
      getPopularTvs: locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistTvsBloc(
      getWatchlistTvs: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  locator.registerLazySingleton(() => GetNowPlayingTvs(locator()));
  locator.registerLazySingleton(() => GetPopularTvs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvs(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvs(locator()));
  locator.registerLazySingleton(() => GetWatchListTvStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTv(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTv(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvs(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator
      .registerLazySingleton<MovieDatabaseHelper>(() => MovieDatabaseHelper());
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  // external
  locator.registerLazySingleton(() => SSLPinning.client);
}
