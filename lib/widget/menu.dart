const _path = 'assets/images';

class Menu {
  List<Items> menus = [
    Items(img: '$_path/sum.png', index: 0),
    Items(img: '$_path/minus.png', index: 1),
    Items(img: '$_path/multiply.png', index: 2),
    Items(img: '$_path/division.png', index: 3),
  ];
}

class Items {
  String img;
  int index;

  Items({
    required this.img,
    required this.index,
  });
}
