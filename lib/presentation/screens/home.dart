import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
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
            ),
            buildTitles('Trending Movies', 'Get the Trending Movies ', (){}),
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
            buildTitles('Popular Movies', 'Get the Popular Movies ', (){}),
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

            buildTitles('Popular Movies', 'Get the Popular Movies ', (){}),
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
      ),
    );
  }

  Widget buildTitles(String title , String subtitle , Function onTap )=> Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
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
         TextButton( onPressed: () => onTap, child: const Text('view all',
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
