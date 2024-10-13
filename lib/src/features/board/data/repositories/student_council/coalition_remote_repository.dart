import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/network/network_client_service.dart';
import '../../../../../core/utils/repository.dart';
import '../../../domain/models/board.dart';
import '../../../domain/models/student_council/coalition_post.dart';

final coalitionRemoteRepositoryProvider =
    Provider.autoDispose<CoalitionRemoteRepository>(
  (ref) => CoalitionRemoteRepository(
    client: ref.watch(networkClientServiceProvider),
  ),
);

class CoalitionRemoteRepository extends RemoteRepository {
  CoalitionRemoteRepository({required super.client});

  Future<Board<CoalitionPost>> getBoard({
    CancelToken? cancelToken,
    required String coalitionType,
    String? keyword,
    int? bodySize,
    int? page,
    int? size,
    List<String>? sort,
  }) async {
    final result = await client.request(
      path: '/post/coalition',
      method: RequestType.get,
      queryParameters: {
        'coalitionType': coalitionType,
        'keyword': keyword,
        'bodySize': bodySize,
        'page': page,
        'size': size,
        'sort': sort?.map((e) => e).join('&'),
      },
      cancelToken: cancelToken,
    );
    return Board.fromJson(
      result.data,
      (data) => CoalitionPost.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<CoalitionPost> getPost({
    CancelToken? cancelToken,
    int? id,
  }) async {
    final result = await client.request(
      path: '/post/coalition/$id',
      method: RequestType.get,
      cancelToken: cancelToken,
    );
    return CoalitionPost.fromJson(result.data);
  }

  Future<bool> deletePost({
    CancelToken? cancelToken,
    required int id,
  }) async {
    final result = await client.request(
      path: '/post/coalition/$id',
      method: RequestType.delete,
      cancelToken: cancelToken,
    );

    return result.statusCode == 200;
  }
}
