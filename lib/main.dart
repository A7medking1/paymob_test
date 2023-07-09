import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymob_test/bloc_observer.dart';
import 'package:paymob_test/core/helper.dart';
import 'package:paymob_test/core/service_locator.dart';
import 'package:paymob_test/modules/cubit/payment_cubit.dart';
import 'package:paymob_test/modules/user_details.dart';
import 'package:paymob_test/modules/widget/custom_loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  ServicesLocator().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<PaymentCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if(state is GetAuthTokenLoadingState){
            OverlayLoadingProgress.start(context);
          }

          if(state is GetAuthTokenSuccessState){
            context.push(const UserDetails());
            OverlayLoadingProgress.stop();
          }

          if(state is GetAuthTokenErrorState){
            OverlayLoadingProgress.stop();
          }

        },
        builder: (context, state) {
          return Center(
            child: TextButton(
              child: const Text('CHECKOUT'),
              onPressed: () {
                PaymentCubit.get(context).getAuthToken();
              },
            ),
          );
        },
      ),
    );
  }
}

