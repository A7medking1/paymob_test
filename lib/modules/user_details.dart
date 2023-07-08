import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymob_test/core/helper.dart';
import 'package:paymob_test/core/service_locator.dart';
import 'package:paymob_test/modules/cubit/payment_cubit.dart';
import 'package:paymob_test/modules/toggle_screen.dart';
import 'package:paymob_test/modules/widget/custom_form_field.dart';
import 'package:paymob_test/modules/widget/default_button.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController priceController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sl<PaymentCubit>().getAuthToken();
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    priceController.dispose();
    addressController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    firstNameController.text = 'ahmed';
    lastNameController.text = 'nasr';
    emailController.text = 'aaa@010.com';
    phoneController.text = '010221000';
    priceController.text = '1000';
    addressController.text = 'aaa';
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is GetPaymentRequestSuccessState) {
          context.push(const ToggleScreen());
        }
      },
      builder: (context, state) {
        PaymentCubit cubit = PaymentCubit.get(context);

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () => context.pop(),
                            icon: const Icon(Icons.arrow_back_ios_new_outlined),
                          ),
                          Center(
                            child: Image.asset(
                              'assets/img.png',
                              fit: BoxFit.cover,
                              height: MediaQuery.sizeOf(context).height * 0.3,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomFormField(
                                  controller: firstNameController,
                                  type: TextInputType.name,
                                  prefix: Icons.person,
                                  validate: (value) => validate(value!),
                                  hintText: "First Name",
                                  lengthCharacters: 10,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: CustomFormField(
                                  controller: lastNameController,
                                  type: TextInputType.name,
                                  validate: (value) => validate(value!),
                                  prefix: Icons.person,
                                  lengthCharacters: 10,
                                  hintText: "Last Name",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            prefix: Icons.email_outlined,
                            validate: (value) => validate(value!),
                            hintText: "Email",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value) => validate(value!),
                            prefix: Icons.phone,
                            hintText: "Phone",
                            lengthCharacters: 11,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomFormField(
                                  type: TextInputType.number,
                                  controller: priceController,
                                  validate: (value) => validate(value!),
                                  prefix: Icons.monetization_on_outlined,
                                  hintText: "Price",
                                  lengthCharacters: 10,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: CustomFormField(
                                  type: TextInputType.name,
                                  prefix: Icons.home,
                                  validate: (value) => validate(value!),
                                  lengthCharacters: 10,
                                  controller: addressController,
                                  hintText: "Address",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          state is! GetOrderIdLoadingState
                              ? DefaultButton(
                                  backgroundColor: Colors.purple,
                                  widget: const Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      letterSpacing: 1.6,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      cubit.getOrderId(
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        city: addressController.text,
                                        email: emailController.text,
                                        price: priceController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                )
                              : const Center(
                                  child: CircularProgressIndicator.adaptive(
                                  backgroundColor: Colors.purple,
                                )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

String? validate(String value) {
  if (value.isEmpty) {
    return "Form Empty";
  }
  return null;
}
