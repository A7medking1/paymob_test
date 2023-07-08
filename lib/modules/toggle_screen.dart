import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymob_test/core/app_images.dart';
import 'package:paymob_test/core/helper.dart';
import 'package:paymob_test/modules/cubit/payment_cubit.dart';
import 'package:paymob_test/modules/mobile_wallet_screen.dart';
import 'package:paymob_test/modules/ref_code_screen.dart';
import 'package:paymob_test/modules/visa_screen.dart';
import 'package:paymob_test/modules/widget/cached_images.dart';

class ToggleScreen extends StatelessWidget {
  const ToggleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is GetPaymentRedCodeSuccessState) {
          context.push(const RefCodeScreen());
        }
        if (state is GetPaymentMobileWalletSuccessState) {
          context.push(MobileWalletScreen());
        }
      },
      builder: (context, state) {
        PaymentCubit cubit = PaymentCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ChoosePayment(
                    text: 'Payment with Ref code',
                    image: AppImages.refCodeImage,
                    onTap: () {
                      cubit.getRefCode();
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ChoosePayment(
                    text: 'payment with visa',
                    onTap: () {
                      context.push(const VisaScreen());
                    },
                    image: AppImages.visaImage,
                  ),
                  const SizedBox(height: 20.0),
                  const SizedBox(height: 20.0),
                  ChoosePayment(
                    text: 'payment with mobile wallet',
                    onTap: () {
                      cubit.mobileWalletPayment();
                    },
                    image: AppImages.wallet,
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ChoosePayment extends StatelessWidget {
  final void Function()? onTap;
  final String? image;
  final String? text;

  const ChoosePayment({super.key, this.onTap, this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.black, width: 2.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedImages(
                imageUrl: image!,
                height: 120,
              ),
              Text(
                text!,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
