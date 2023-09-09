import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rest_api_example/blocs/internet_bloc/internet_bloc.dart';
import 'package:rest_api_example/blocs/internet_bloc/internet_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rest Api Testing'),
        ),
        body: Center(
          child: BlocConsumer<InternetBloc, InterentState>(
            listener: (context, state) {
              if (state is InternetConnectedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Internet Connected'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is InternetDisconnectedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Internet Disconnected'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is InternetConnectedState) {
                return const Text('Internet Connected');
              } else if (state is InternetDisconnectedState) {
                return const Text('Internet Disconnected');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ));
  }
}
