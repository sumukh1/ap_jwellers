import 'package:myapp/core/models/response/app_error.dart';
import 'package:myapp/core/models/response/app_success.dart';
import 'package:either_dart/either.dart';

typedef AppSuccessResponse = Future<Either<AppError, AppSuccess>>;
typedef AppTypeResponse<T> = Future<Either<AppError, T>>;
