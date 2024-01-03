import 'package:flutter/material.dart';

class CustomCarousel extends StatefulWidget {
  final List<String> items;
  const CustomCarousel({Key? key, required this.items}) : super(key: key);

  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  int _currentItemIndex = 0;

  void _previousItem() {
    setState(() {
      _currentItemIndex = _currentItemIndex - 1;
      if (_currentItemIndex < 0) {
        _currentItemIndex = widget.items.length - 1;
      }
    });
  }

  void _nextItem() {
    setState(() {
      _currentItemIndex = _currentItemIndex + 1;
      if (_currentItemIndex >= widget.items.length) {
        _currentItemIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PageView(
          children: widget.items.map((item) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Text(item),
              ),
            );
          }).toList(),
          onPageChanged: (newIndex) {
            setState(() {
              _currentItemIndex = newIndex;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: _previousItem,
              child: const Text('Previous'),
            ),
            TextButton(
              onPressed: _nextItem,
              child: const Text('Next'),
            ),
          ],
        ),
      ],
    );
  }
}
