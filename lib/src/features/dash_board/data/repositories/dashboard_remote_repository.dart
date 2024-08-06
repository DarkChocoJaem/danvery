import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/repository.dart';
import '../../domain/models/home_board.dart';

final dashBoardRemoteRepositoryProvider =
    Provider.autoDispose<DashBoardRemoteRepository>(
  (ref) => DashBoardRemoteRepository(
    client: ref.watch(networkClientServiceProvider),
  ),
);

class DashBoardRemoteRepository extends RemoteRepository {
  DashBoardRemoteRepository({required super.client});

  Future<HomeBoard> getHomeBoard({
    CancelToken? cancelToken,
  }) async {
    final result = await client.request(
      path: '/main',
      method: RequestType.get,
      cancelToken: cancelToken,
    );

    return HomeBoard.fromJson(result.data);
  }
}
