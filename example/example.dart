import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multiviewlist/multiviewlist.dart';

class ItemModel {
  int? id;
  String? image;
  String? title;
  String? subTitle;
  String? description;
  String? rating;
  Function(int)? onFav;
  Function(int)? onDelete;
  Function(int)? onTab;
  Function(int)? onSelected;
  bool? isFav;
  bool? isSelected;

  ItemModel(
      {this.id,
        this.image,
        this.title,
        this.subTitle,
        this.description,
        this.rating,
        this.onFav,
        this.onTab,
        this.onSelected,
        this.onDelete,
        this.isFav,
        this.isSelected
      });
}

class AnimatedCardList extends StatefulWidget {
  const AnimatedCardList({Key? key}) : super(key: key);

  @override
  State<AnimatedCardList> createState() => _AnimatedCardListState();
}

class _AnimatedCardListState extends State<AnimatedCardList> {
  List<ItemModel> items = [];
  List<ItemModel> lists = [];
  var isLoading = true.obs;

  changeFav(int id) {
    final singleItem = items.firstWhere((element) => element.id == id);
    if (singleItem.isFav == false) {
      singleItem.isFav = true;
    } else {
      singleItem.isFav = false;
    }
    setState(() {});
  }

  deleteItem(int index) {
    items.removeAt(index);
    setState(() {});
  }

  selectItem(int id) {
    final singleItem = items.firstWhere((element) => element.id == id);
    if (singleItem.isSelected == false) {
      singleItem.isSelected = true;
    } else {
      singleItem.isSelected = false;
    }
    setState(() {});
  }

  initData() {
    debugPrint("initializing");
    setState(() {
      isLoading.value = true;
      Future.delayed(const Duration(seconds: 5), () {
        items = [
          ItemModel(
            image:
            "https://miro.medium.com/max/1059/1*S_0zKU4NjU51GtuDOcWwVQ.png",
            id: 1,
            title: "first",
            description: "first item in card",
            rating: "4.5",
            subTitle: "card list",
            isFav: true,
            isSelected: false,
            onTab: (int id) {
              print("selected id $id");
            },
            onFav: (int id) {
              print("fav index $id");
              changeFav(id);
            },
            onSelected: (int id) {
              print("selected id $id");
              selectItem(id);
            },
            // onDelete: (int index) {
            //   print("deleted index $index");
            //   deleteItem(index);
            // },
          ),
          ItemModel(
            image:
            "https://miro.medium.com/max/1059/1*S_0zKU4NjU51GtuDOcWwVQ.png",
            id: 2,
            title: "second",
            description: "second item in card",
            rating: "4.5",
            subTitle: "card list",
            isFav: true,
            isSelected: false,
            onTab: (int id) {
              print("selected id $id");
            },
            onFav: (int id) {
              print("fav id $id");
              changeFav(id);
            },
            onSelected: (int id) {
              print("selected id $id");
              selectItem(id);
            },
            // onDelete: (int index) {
            //   print("deleted index $index");
            //   deleteItem(index);
            // },
          ),
          ItemModel(
            image:
            "https://miro.medium.com/max/1059/1*S_0zKU4NjU51GtuDOcWwVQ.png",
            id: 3,
            title: "third",
            description: "third item in card",
            rating: "4.5",
            subTitle: "card list",
            isFav: true,
            isSelected: false,
            onTab: (int id) {
              print("selected id $id");
            },
            onFav: (int id) {
              print("fav id $id");
              changeFav(id);
            },
            onSelected: (int id) {
              print("selected id $id");
              selectItem(id);
            },
            onDelete: (int index) {
              print("deleted index $index");
              deleteItem(index);
            },
          ),
          ItemModel(
            image:
            "https://miro.medium.com/max/1059/1*S_0zKU4NjU51GtuDOcWwVQ.png",
            id: 4,
            title: "fourth",
            //description: "fourth item in card",
            rating: "4.5",
            subTitle: "card list",
            isFav: true,
            isSelected: false,
            onTab: (int id) {
              print("selected id $id");
            },
            onFav: (int id) {
              print("fav id $id");
              changeFav(id);
            },
            onSelected: (int id) {
              print("selected id $id");
              selectItem(id);
            },
            onDelete: (int index) {
              print("deleted index $index");
              deleteItem(index);
            },
          ),
          ItemModel(
            image:
            "https://miro.medium.com/max/1059/1*S_0zKU4NjU51GtuDOcWwVQ.png",
            id: 5,
            title: "fifth",
            // description: "fifth item in card",
            rating: "4.5",
            subTitle: "card list",
            isFav: true,
            isSelected: false,
            onTab: (int id) {
              print("selected id $id");
            },
            onFav: (int id) {
              print("fav id $id");
              changeFav(id);
            },
            onSelected: (int id) {
              print("selected id $id");
              selectItem(id);
            },
            onDelete: (int index) {
              print("deleted index $index");
              deleteItem(index);
            },
          ),
          ItemModel(
            image:
            "https://miro.medium.com/max/1059/1*S_0zKU4NjU51GtuDOcWwVQ.png",
            id: 6,
            title: "sixth",
            //description: "sixth item in card",
            rating: "4.5",
            subTitle: "card list",
            isFav: true,
            isSelected: false,
            onTab: (int id) {
              print("selected id $id");
            },
            onFav: (int id) {
              print("fav id $id");
              changeFav(id);
            },
            onSelected: (int id) {
              print("selected id $id");
              selectItem(id);
            },
            onDelete: (int index) {
              print("deleted index $index");
              deleteItem(index);
            },
          ),
          ItemModel(
            image:
            "https://miro.medium.com/max/1059/1*S_0zKU4NjU51GtuDOcWwVQ.png",
            id: 7,
            title: "seventh",
            //description: "seventh item in card",
            rating: "4.5",
            subTitle: "card list",
            isFav: true,
            isSelected: false,
            onTab: (int id) {
              print("selected id $id");
            },
            onFav: (int id) {
              print("fav id $id");
              changeFav(id);
            },
            onSelected: (int id) {
              print("selected id $id");
              selectItem(id);
            },
            onDelete: (int index) {
              print("deleted index $index");
              deleteItem(index);
            },
          ),
        ];
        isLoading.value = false;
      });
    });
  }

  @override
  void initState() {
    initData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
            () => MultiViewList(
          data: items,
          scrollDirection: Axis.vertical,
          viewType: ViewType.gridView,
          contentAxis: Axis.vertical,
          background: Colors.white,
          isRating: true,
          isFav: true,
          isDismissible: false,
          isLoading: isLoading.value,
          isSelectableList: false,
          selectedColor: Colors.grey.shade200,
        ),
      ),
    );
  }
}