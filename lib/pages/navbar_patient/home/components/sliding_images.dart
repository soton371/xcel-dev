import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class SlidingImages extends StatelessWidget {
  const SlidingImages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    
    List<String> imageUrl = [
      'https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
      'https://images.unsplash.com/photo-1581093450021-4a7360e9a6b5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
      'https://images.unsplash.com/photo-1579154204601-01588f351e67?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80'
    ];

    return SizedBox(
      height: height / 3,
      width: width,
      child: Center(
        child: CarouselSlider.builder(
          itemCount: imageUrl.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Image.network(
            imageUrl[itemIndex],
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          options: CarouselOptions(
            height: height / 3,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            autoPlay: true,
          ),
        ),

      ),
    );
  }
}
