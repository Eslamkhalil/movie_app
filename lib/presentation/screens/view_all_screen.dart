import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/business/cubit/movie_cubit.dart';
import 'package:movie_app/business/cubit/movie_state.dart';

class ViewAllScreen extends StatelessWidget {

  const ViewAllScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocConsumer<MovieCubit, MovieState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black12,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(4.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                   mainAxisSpacing: 0,


                ),
                itemBuilder: (context, index) {
                  return Container(
                    height: 50,
                    width: 100,
                    child: const Image(
                      height: 50,
                          width: 400,
                        image: AssetImage('assets/images/img_not_found.jpg')),
                  );
                },
                itemCount: 15,
              ),
            ),
          ),
        );
      },
      listener: (context, state) {});
}
