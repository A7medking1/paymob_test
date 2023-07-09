import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymob_test/core/api/api_consumer.dart';
import 'package:paymob_test/core/constant.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.apiConsumer) : super(PaymentInitial());

  ApiConsumer apiConsumer;

  static PaymentCubit get(context) => BlocProvider.of(context);

  Future<void> getAuthToken() async {
    emit(GetAuthTokenLoadingState());

    try {
      Response response =
          await apiConsumer.post(ApiConstant.getAuthToken, body: {
        "api_key": ApiConstant.paymentApiKey
      });

      ApiConstant.paymentAuthToken = response.data['token'];

      emit(GetAuthTokenSuccessState());
    } catch (e) {
      emit(GetAuthTokenErrorState());
    }
  }

  Future<void> getOrderId({
    required String firstName,
    required String lastName,
    required String city,
    required String email,
    required String price,
    required String phone,
  }) async {
    emit(GetOrderIdLoadingState());
    try {
      Response response = await apiConsumer.post(ApiConstant.getOrderId, body: {
        "auth_token": ApiConstant.paymentAuthToken,
        "delivery_needed": "false",
        "amount_cents": price,
        "currency": "EGP",
        "items": [],
      });

      ApiConstant.paymentOrderId = response.data['id'].toString();

      await getPaymentRequest(
        firstName: firstName,
        lastName: lastName,
        city: city,
        email: email,
        price: price,
        phone: phone,
      );
    } catch (e) {
      emit(GetOrderIdErrorState());
    }
  }

  Future<void> getPaymentRequest({
    required String firstName,
    required String lastName,
    required String city,
    required String email,
    required String price,
    required String phone,
  }) async {
    try {
      Response response =
          await apiConsumer.post(ApiConstant.getPaymentToken, body: {
        "auth_token": ApiConstant.paymentAuthToken,
        "amount_cents": price,
        "expiration": 10000,
        "order_id": ApiConstant.paymentOrderId,
        "currency": "EGP",
        "billing_data": {
          "apartment": "NA",
          "email": email,
          "floor": "NA",
          "first_name": firstName,
          "street": "NA",
          "building": "NA",
          "phone_number": phone,
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": city,
          "country": "NA",
          "last_name": lastName,
          "state": "NA"
        },
        "integration_id": ApiConstant.integrationIdCard,
        "lock_order_when_paid": "false"
      });

      ApiConstant.finalTokenPayment = response.data['token'];

      emit(GetPaymentRequestSuccessState());
    } catch (e) {
      emit(GetPaymentRequestErrorState());
    }
  }

  Future<void> getRefCode() async {
    emit(GetPaymentRedCodeLoadingState());

    try {
      Response response = await apiConsumer.post(ApiConstant.getPayment, body: {
        "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
        "payment_token": ApiConstant.finalTokenPayment,
      });

      ApiConstant.refCode = response.data['id'].toString();

      emit(GetPaymentRedCodeSuccessState());
    } catch (e) {
      emit(GetPaymentRedCodeErrorState());
    }
  }



  Future<void> mobileWalletPayment() async {
    emit(GetPaymentMobileWalletLoadingState());

    try {
      Response response = await apiConsumer.post(ApiConstant.getPayment, body: {
        "source": {
          "identifier": "01010101010",
          "subtype": "WALLET"
        },
        "payment_token": ApiConstant.finalTokenPayment  // token obtained in step 3
      });

      ApiConstant.mobileWalletIframe = response.data['iframe_redirection_url'].toString();


      emit(GetPaymentMobileWalletSuccessState());
    } catch (e) {
      emit(GetPaymentMobileWalletErrorState());
    }
  }
}
