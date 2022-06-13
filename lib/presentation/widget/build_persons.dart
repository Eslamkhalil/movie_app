import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import '../../constants/end_point.dart';

class BuildPersons extends StatelessWidget {
  const  BuildPersons({required this.persons, Key? key}) : super(key: key);
  final dynamic  persons;

  @override
  Widget build(BuildContext context) {
    return  Padding(
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
                                          'assets/images/img_not_found.png'),
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
                 /* Center(
                    child: Text(
                      persons[index].knowForDepartment!,
                      style: const TextStyle(
                        fontFamily: 'muli',
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ),*/
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
}
