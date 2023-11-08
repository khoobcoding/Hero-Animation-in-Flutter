import 'package:flutter/material.dart';

class HeroApp extends StatefulWidget {
  const HeroApp({super.key});

  @override
  State<HeroApp> createState() => _HeroAppState();
}

class _HeroAppState extends State<HeroApp> {
  final imagespath = [
    'assets/img1.png', //!  Here is your image path 
    'assets/img2.png',
    'assets/img3.png',
    'assets/img4.png',
    'assets/img5.png',
    'assets/logo.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal,
          title: const Text(
            'Hero Animation',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.builder(
          itemCount: imagespath.length,
          itemBuilder: ((context, index) {
            return ListTile(
              title: Text('Image - ${index+1}'),
              leading: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context) {
                    return ImageDetail(image: imagespath[index],
                    tag: 'image$index',);
                  },));
                },
                child: HeroMode(
                  enabled: true,
                  child: Hero(
                    tag: 'image$index', //! Unique name tag
                    placeholderBuilder: (context, heroSize, child) {
                      return Container(width: 150,height: 150,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 106, 105, 105),
                        shape: BoxShape.circle
                      ),);
                    },
                    flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
                      if(flightDirection==HeroFlightDirection.push){
                        return const Icon(Icons.error,size: 150,);
                      }if(flightDirection==HeroFlightDirection.pop){
                        return const Icon(Icons.circle,size: 150,);
                      }
                      return const Icon(Icons.circle_outlined,size: 150,);
                    },
                    transitionOnUserGestures: true,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(imagespath[index]),
                    ),
                  ),
                ),
              ),
            );
          })));
  }
}

class ImageDetail extends StatefulWidget {
  final String image;
  final String tag;
  const ImageDetail({super.key, required this.image, required this.tag});

  @override
  State<ImageDetail> createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Detail',style: TextStyle(
          fontSize: 30,fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Hero(
          tag: widget.tag, //! same tag 
          child: Image.asset(widget.image)),
      ),
    );
  }
}


