import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:paymob_test/core/api/api_consumer.dart';
import 'package:paymob_test/core/api/dio_consumer.dart';
import 'package:paymob_test/modules/cubit/payment_cubit.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    sl.registerLazySingleton<Dio>(() => Dio());

    sl.registerLazySingleton(() => PrettyDioLogger(
      responseBody: false,
      requestBody: false,

    ));

    sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));


    sl.registerFactory(() => PaymentCubit(sl()));
  }
}
