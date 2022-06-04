import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(color:  Colors.black45,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'muli',

          ),
        ),
      ),
      body: buildBody(context),
    );
  }


  Widget buildBody (BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      return ConstrainedBox(
        constraints:  BoxConstraints(minHeight: constraints.maxHeight),
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
                itemCount: 10,
                itemBuilder:
                    (BuildContext context, int index, int pageViewIndex) {
                  return GestureDetector(
                    child: Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        CachedNetworkImage(
                            imageUrl: 'https://picsum.photos/id/237/500/500'),
                        Text(
                          '$index',
                          style: const TextStyle(
                            fontFamily: 'muli',
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                  enableInfiniteScroll: true,
                  autoPlayInterval: const Duration(seconds: 1),
                  autoPlayAnimationDuration: const Duration(milliseconds: 200),
                  autoPlay: true,
                  pauseAutoPlayOnTouch: true,
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                )),
            buildTitles('Trending Movies', 'Get the Trending Movies ', () {}),
            SizedBox(
              height: 165,
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildNewReleassItem(),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 5,
                  ),
                  itemCount: 10),
            ),
            buildTitles('Popular Movies', 'Get the Popular Movies ', () {}),
            SizedBox(
              height: 165,
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildNewReleassItem(),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 5,
                  ),
                  itemCount: 10),
            ),
            buildTitles('Popular Movies', 'Get the Popular Movies ', () {}),
            SizedBox(
              height: 165,
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildNewReleassItem(),
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 5,
                  ),
                  itemCount: 10),
            )
          ],
        ),
      );



    });
  }

  Widget buildTitles(String title, String subtitle, Function onTap) => Padding(
        padding: const EdgeInsets.all(8.0),
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
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  const SizedBox(height: 5),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black26)),
                ],
              ),
            ),
            TextButton(
              onPressed: () => onTap,
              child: const Text('view all',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
            )
          ],
        ),
      );

  Widget buildNewReleassItem() => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: const [
            Image(
              image: AssetImage('assets/images/eslam.jpg'),
              fit: BoxFit.cover,
              height: 150,
              width: 140,
            ),
            Text(
              'Eslam',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      );
}
