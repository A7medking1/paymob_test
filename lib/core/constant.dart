class ApiConstant {
  static const baseUrl = 'https://accept.paymob.com/api';

  static const getAuthToken = '$baseUrl/api/auth/tokens';

  static const paymentApiKey =
      'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TnpJME5URTJMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuVDUzRVczclY3RTUxd0t1aF95eVROWTFkUzcwZlRrTnJvbUZBVTNmQlROM2VyRFpIYVhxRHI0X3BTU1ptMlNzVEV2QkQ5UTM2RUlDVnE0WW56bWZjX1E=';

  static const getOrderId = '$baseUrl/ecommerce/orders';
  static const getPaymentToken = '$baseUrl/acceptance/payment_keys';
  static const getPayment = '$baseUrl/acceptance/payments/pay';



  static String visaUrl = '$baseUrl/acceptance/iframes/744284?payment_token=$finalTokenPayment';

  /// kiosk 4011185
  /// online card 3678430
  /// mobile wallet 3706992

  ///
  static String paymentAuthToken = '';
  static String paymentOrderId = '';
  static int integrationIdCard = 3678430;
  static String refCode = '';
  static String finalTokenPayment = '';
  static String mobileWalletIframe = '';
}
