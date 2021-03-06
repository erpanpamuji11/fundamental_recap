import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundamental_recap/bloc/home/bloc/home_bloc.dart';
import 'package:fundamental_recap/page/detail_page.dart';

class DogBreedListPage extends StatefulWidget {
  const DogBreedListPage({Key? key}) : super(key: key);

  @override
  State<DogBreedListPage> createState() => _DogBreedListPageState();
}

class _DogBreedListPageState extends State<DogBreedListPage> {
  @override
  void initState() {
    Future.microtask(
      () => context.read<HomeBloc>().add(const LoadListDogBreed()),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomeLoaded) {
          return ListView.builder(
            itemCount: state.listDogBreed.length,
            itemBuilder: (context, index) {
              final item = state.listDogBreed[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text("${index + 1}"),
                ),
                title: Text(item),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    DetailPage.route,
                    arguments: DetailPageArgument(breed: item),
                  );
                },
              );
            },
          );
        } else if (state is HomeError) {
          return Text(state.message.toString());
        } else {
          return const Text("");
        }
      },
    );
  }
}
