import '../../../../core/utils/use_case.dart';
import '../repositories/auth_repository.dart';

class SendSignUpCodeParams {
  final String signUpToken;
  final String phoneNumber;

  SendSignUpCodeParams({
    required this.signUpToken,
    required this.phoneNumber,
  });
}

class SendSignUpCodeUseCase extends UseCase<bool, SendSignUpCodeParams> {
  final AuthRepository authRepository;

  SendSignUpCodeUseCase({
    required this.authRepository,
  });

  @override
  Future<bool> call({
    required SendSignUpCodeParams params,
  }) async {
    return await authRepository.sendSignUpCode(
      signUpToken: params.signUpToken,
      phoneNumber: params.phoneNumber,
    );
  }
}
