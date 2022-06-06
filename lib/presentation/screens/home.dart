import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/business/cubit/movie_state.dart';
import 'package:movie_app/data/models/movie_model.dart';
import 'dart:io';
import '../../business/cubit/movie_cubit.dart';
import '../../constants/end_point.dart';
import '../../data/models/person.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.white60,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'muli',
          ),
        ),
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return BlocConsumer<MovieCubit, MovieState>(
        builder: (context, state) =>
            LayoutBuilder(builder: (context, constraints) {
              var cubit = BlocProvider.of<MovieCubit>(context);
              return ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    /* Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                    onPressed: () {}, icon: const Icon(Icons.search)),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),*/

                      CarouselSlider.builder(
                          itemCount: cubit.nowPlayingMovies.length,
                          itemBuilder: (BuildContext context, int index,
                              int pageViewIndex) {
                            return GestureDetector(
                              child: Stack(
                                alignment: Alignment.bottomLeft,
                                children: [
                                  ClipRRect(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '$imagePath${cubit.nowPlayingMovies[index].posterPath}',
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      placeholder: (context, url) => Platform
                                              .isAndroid
                                          ? const CircularProgressIndicator()
                                          : const CupertinoActivityIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/img_not_found.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, bottom: 10),
                                    child: Text(
                                      cubit.nowPlayingMovies[index].title!.toUpperCase(),
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontFamily: 'muli',
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          options: CarouselOptions(
                            enableInfiniteScroll: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 500),
                            autoPlay: true,
                            pauseAutoPlayOnTouch: true,
                            viewportFraction: 0.8,
                            enlargeCenterPage: true,
                          )),
                    buildTitles(
                        'Trending Movies', 'Get the Trending Movies ', () {}),
                    SizedBox(
                      height: 165,
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              buildNewReleassItem(context,cubit.trendingMovies[index]),
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 5,
                              ),
                          itemCount: cubit.trendingMovies.length),
                    ),
                    buildTitles(
                        'Upcoming Movies', 'Get the Upcoming Movies ', () {}),
                    SizedBox(
                      height: 165,
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              buildNewReleassItem(context , cubit.upcomingMovies[index]),
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 5,
                              ),
                          itemCount: cubit.upcomingMovies.length),
                    ),
                     Padding(
                      padding: const EdgeInsets.only(left: 10.0 , top: 8.0),
                      child: Text('Trending persons on this week'.toUpperCase(),
                          style: const TextStyle(
                            fontFamily: 'muli',
                            color: Colors.white,
                            fontSize: 14,
                          )),
                    ),


                    buildPersons(cubit.persons),

                  ],
                ),
              );
            }),
        listener: (context, state) {});
  }

  Widget buildTitles(String title, String subtitle, Function onTap) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          fontFamily: 'muli',
                          color: Colors.white)),
                  const SizedBox(height: 5),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'muli',
                          color: Colors.grey)),
                ],
              ),
            ),
            TextButton(
              onPressed: () => onTap,
              child: const Text('view all',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'muli',
                      color: Colors.white)),
            )
          ],
        ),
      );

  Widget buildNewReleassItem(BuildContext context , Results results) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl:
                    '$imagePath${results.posterPath}',
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width /1.5,
                placeholder: (context, url) => Platform.isAndroid
                    ? const CircularProgressIndicator()
                    : const CupertinoActivityIndicator(),
                errorWidget: (context, url, error) => Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                  image: AssetImage('assets/images/img_not_found.jpg'),
                  fit: BoxFit.cover,
                ))),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 10),
              child: Text(
                results.title!,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'muli',
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildPersons(List<Person> persons) =>  Padding(
    padding: const EdgeInsets.only(top:8.0),
    child: SizedBox(
      height: 120,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  elevation: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                      imageUrl:
                      '$profileImagePath${persons[index].profilePath}',
                      imageBuilder:
                          (context, imageProvider) =>
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      fit: BoxFit.cover,

                      placeholder: (context, url) => Platform
                          .isAndroid
                          ? const CircularProgressIndicator()
                          : const CupertinoActivityIndicator(),
                      errorWidget: (context, url, error) =>
                          Container(
                              height: 80,
                              width: 80,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/img_not_found.jpg'),
                                    fit: BoxFit.cover,
                                  ))),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    persons[index].name!,
                    style: const TextStyle(
                      fontFamily: 'muli',
                      color: Colors.white,
                      fontSize:12,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    persons[index].knowForDepartment!,
                    style: const TextStyle(
                      fontFamily: 'muli',
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) =>
          const VerticalDivider(
            width: 5,
            color: Colors.transparent,
          ),
          itemCount: persons.length),
    ),
  );
}
