import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://thumbs.dreamstime.com/z/red-tulip-flowers-black-white-background-blossom-blured-96453957.jpg',
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Platform.isAndroid
                            ? const Center(child: CircularProgressIndicator())
                            : const Center(child: CupertinoActivityIndicator());
                      },
                      height: MediaQuery.of(context).size.height / 2,
                      width: double.infinity,
                      errorWidget: (context, url, error) => Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('assets/images/no_image_found.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow_outlined, size: 40),
                    color: Colors.black,
                  ),
                  Positioned(
                    bottom: 50,
                    child: const Text(
                      'Movie Title',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'muli',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                'Over View',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'muli',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
              child: Text(
                'all about the movie the movie will be having alot of  adavantages and disadvantages so it is the best movie you will eveer seen wallk aroud to fimd the gratest movie you will ever see',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'muli',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                'Screen Shots',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'muli',
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                'Cast',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'muli',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
