library multiviewlist;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'component/card_component.dart';
import 'component/item_model.dart';
import 'component/shimmer.dart';

enum ViewType { listView, gridView }

TextStyle textStyle = const TextStyle(color: Colors.black, fontSize: 14);

var isSelectableItem = false.obs;

class MultiViewList extends StatefulWidget {
  /// you can pass a data with this structure
  // class ItemModel {
  // int? id;
  // String? image;
  // String? title;
  // String? subTitle;
  // String? description;
  // String? rating;
  // Function(int)? onFav;
  // Function(int)? onDelete;
  // Function(int)? onTab;
  // bool? isFav;
  // }
  final List<ItemModel> data;

  /// to set scroll direction for horizontal or vertical
  final Axis scrollDirection;

  /// content Axis is used for how the content shown in the card.
  /// because its have two type of view.
  /// one is all the components are aligned with vertical
  /// another one is horizontal like list tile
  final Axis contentAxis;

  /// view type is set to listview or gridview
  final ViewType viewType;

  /// set card background
  final Color background;

  /// set image background color
  final Color imageBackground;

  /// changing a textStyle. default text color is black and size is 14
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final TextStyle? descriptionStyle;
  final TextStyle? ratingStyle;

  /// if u want show rating icon enable isRating and you can change the color for icon
  /// default rating icon color is deepOrange
  final Color ratingClr;
  final bool isRating;

  ///set elevation to the card. default elevation value is 6.
  final double elevation;

  /// Dismissible is delete item from array.
  /// if u want delete an item please set dismissible true.
  /// default value is true
  final bool isDismissible;

  /// if u want show fav icon enable isFav and you can change the color for icon
  /// default fav icon color is deepPurple
  /// if user want to place icon top Left, top Right,bottom Left, or bottom right user can use favIconAlignment
  /// also change a icon size. default size is 25
  final bool isFav;
  final Color favIconClr;
  final Alignment favIconAlignment;
  final double favIconSize;

  final ScrollPhysics? physics;
  final bool isLoading;
  final Color selectedColor;
  final Color selectedIconColor;
  final bool isSelectableList;
  final Widget? errorWidget;
  final double? height;
  final double? mainAxisExtent;

  const MultiViewList({
    Key? key,
    required this.data,
    this.scrollDirection = Axis.vertical,
    this.contentAxis = Axis.vertical,
    required this.viewType,
    required this.background,
    this.imageBackground = Colors.white,
    this.titleStyle,
    this.subTitleStyle,
    this.descriptionStyle,
    this.ratingStyle,
    this.ratingClr = Colors.deepOrange,
    this.isRating = false,
    this.isFav = false,
    this.elevation = 6,
    this.physics,
    this.isDismissible = false,
    this.favIconClr = Colors.deepPurple,
    this.favIconSize = 25,
    this.isLoading = false,
    this.isSelectableList = false,
    this.selectedColor = Colors.green,
    this.selectedIconColor = Colors.green,
    this.favIconAlignment = Alignment.topLeft,
    this.errorWidget,
    this.height,
    this.mainAxisExtent,
  }) : super(key: key);

  @override
  State<MultiViewList> createState() => _MultiViewListState();
}

class _MultiViewListState extends State<MultiViewList> {

  double? cardHeight;
  @override
  void initState() {
    cardHeight = widget.height ?? (widget.contentAxis == Axis.horizontal ? 0.22 : 0.32);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.viewType == ViewType.listView ? listView() : gridView();
  }

  Widget listView() {
    return widget.isLoading == false
        ? widget.data.isNotEmpty
        ? ListView.builder(
      itemCount: widget.data.length,
      shrinkWrap: true,
      scrollDirection: widget.scrollDirection,
      physics: widget.physics ?? const BouncingScrollPhysics(),
      itemBuilder: (_, index) {
        return widget.isDismissible
            ? Dismissible(
          key: UniqueKey(),
          direction: widget.scrollDirection == Axis.horizontal
              ? DismissDirection.vertical
              : DismissDirection.horizontal,
          onDismissed: (d) {
            debugPrint("dismissed item ${widget.data[index]}");
            widget.data[index].onDelete!(index);
          },
          child: CardComponent(
            height: cardHeight!,
            contentAxis: widget.contentAxis,
            background: widget.background,
            imageBackground: widget.imageBackground,
            data: widget.data[index],
            titleStyle: widget.titleStyle ?? textStyle,
            subTitleStyle: widget.subTitleStyle ?? textStyle,
            descriptionStyle:
            widget.descriptionStyle ?? textStyle,
            ratingStyle: widget.ratingStyle ?? textStyle,
            isRating: widget.isRating,
            isFav: widget.isFav,
            ratingClr: widget.ratingClr,
            elevation: widget.elevation,
            favIconClr: widget.favIconClr,
            favIconAlignment: widget.favIconAlignment,
            favIconSize: widget.favIconSize,
            selectedColor: widget.selectedColor,
            isSelectableList: widget.isSelectableList,
            isSelectableItem: isSelectableItem.value,
            selectedIconColor: widget.selectedIconColor,
          ),
        )
            : CardComponent(
          height: cardHeight!,
          contentAxis: widget.contentAxis,
          background: widget.background,
          imageBackground: widget.imageBackground,
          data: widget.data[index],
          titleStyle: widget.titleStyle ?? textStyle,
          subTitleStyle: widget.subTitleStyle ?? textStyle,
          descriptionStyle:
          widget.descriptionStyle ?? textStyle,
          ratingStyle: widget.ratingStyle ?? textStyle,
          isRating: widget.isRating,
          isFav: widget.isFav,
          ratingClr: widget.ratingClr,
          elevation: widget.elevation,
          favIconClr: widget.favIconClr,
          favIconAlignment: widget.favIconAlignment,
          favIconSize: widget.favIconSize,
          selectedColor: widget.selectedColor,
          isSelectableList: widget.isSelectableList,
          isSelectableItem: isSelectableItem.value,
          selectedIconColor: widget.selectedIconColor,
        );
      },
    )
        : widget.errorWidget ??
        const Center(
          child: Text(
            "Oops! There Is No Data",
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        )
        : buildListShimmer();
  }

  Widget gridView() {
    return widget.isLoading == false
        ? widget.data.isNotEmpty
        ? GridView.builder(
      physics: widget.physics ?? const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          //childAspectRatio: 10 / 15,
          mainAxisExtent: widget.mainAxisExtent ?? (widget.scrollDirection == Axis.horizontal ? 200 : 275),
          //mainAxisExtent 275 for verticle and 200 for horizontal
          crossAxisSpacing: 1,
          mainAxisSpacing: 1),
      scrollDirection: widget.scrollDirection,
      itemCount: widget.data.length,
      itemBuilder: (_, index) {
        return widget.isDismissible
            ? Dismissible(
          key: UniqueKey(),
          direction: widget.scrollDirection == Axis.horizontal
              ? DismissDirection.vertical
              : DismissDirection.horizontal,
          onDismissed: (d) {
            debugPrint("dismissed item ${widget.data[index]}");
            widget.data[index].onDelete!(index);
          },
          child: CardComponent(
            height: cardHeight!,
            contentAxis: Axis.vertical,
            background: widget.background,
            imageBackground: widget.imageBackground,
            data: widget.data[index],
            titleStyle: widget.titleStyle ?? textStyle,
            subTitleStyle: widget.subTitleStyle ?? textStyle,
            descriptionStyle:
            widget.descriptionStyle ?? textStyle,
            ratingStyle: widget.ratingStyle ?? textStyle,
            isRating: widget.isRating,
            isFav: widget.isFav,
            ratingClr: widget.ratingClr,
            elevation: widget.elevation,
            favIconClr: widget.favIconClr,
            favIconAlignment: widget.favIconAlignment,
            favIconSize: widget.favIconSize,
            selectedColor: widget.selectedColor,
            isSelectableList: widget.isSelectableList,
            isSelectableItem: isSelectableItem.value,
            selectedIconColor: widget.selectedIconColor,
          ),
        )
            : CardComponent(
          height: cardHeight!,
          contentAxis: Axis.vertical,
          background: widget.background,
          imageBackground: widget.imageBackground,
          data: widget.data[index],
          titleStyle: widget.titleStyle ?? textStyle,
          subTitleStyle: widget.subTitleStyle ?? textStyle,
          descriptionStyle:
          widget.descriptionStyle ?? textStyle,
          ratingStyle: widget.ratingStyle ?? textStyle,
          isRating: widget.isRating,
          isFav: widget.isFav,
          ratingClr: widget.ratingClr,
          elevation: widget.elevation,
          favIconClr: widget.favIconClr,
          favIconAlignment: widget.favIconAlignment,
          favIconSize: widget.favIconSize,
          selectedColor: widget.selectedColor,
          isSelectableList: widget.isSelectableList,
          isSelectableItem: isSelectableItem.value,
          selectedIconColor: widget.selectedIconColor,
        );
      },
    )
        : widget.errorWidget ??
        const Center(
          child: Text(
            "Oops! There Is No Data",
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        )
        : buildGridShimmer();
  }

  ///shimmer content
  Widget buildListShimmer() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: (_, index) {
          return Container(
              height: 200,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Row(
                children: [
                  CustomWidget.rectangular(
                    height: 200,
                    width: 100,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomWidget.rectangular(
                        height: 25,
                        width: 280,
                      ),
                      CustomWidget.rectangular(
                        height: 25,
                        width: 280,
                      ),
                      CustomWidget.rectangular(
                        height: 25,
                        width: 280,
                      ),
                    ],
                  ),
                ],
              ));
        });
  }

  Widget buildGridShimmer() {
    return GridView.builder(
      itemCount: 6,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          //childAspectRatio: 10 / 15,
          mainAxisExtent:
          widget.scrollDirection == Axis.horizontal ? 235 : 275,
          //mainAxisExtent 275 for verticle and 200 for horizontal
          crossAxisSpacing: 1,
          mainAxisSpacing: 1),
      itemBuilder: (_, index) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.18,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomWidget.rectangular(
                height: MediaQuery.of(context).size.height * 0.16,
              ),
              CustomWidget.rectangular(
                height: 25,
                width: 280,
              ),
              CustomWidget.rectangular(
                height: 25,
                width: 280,
              ),
              CustomWidget.rectangular(
                height: 25,
                width: 280,
              ),
            ],
          ),
        );
      },);
  }
}
