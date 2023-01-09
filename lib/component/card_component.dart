import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'item_model.dart';
import '../multiviewlist.dart';

class CardComponent extends StatefulWidget {
  final Axis contentAxis;
  final Color background;
  final Color imageBackground;
  final ItemModel data;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final TextStyle descriptionStyle;
  final TextStyle ratingStyle;
  final Color ratingClr;
  final bool isRating;
  final bool isFav;
  final double elevation;
  final Color favIconClr;
  final Alignment favIconAlignment;
  final double favIconSize;
  final Color selectedColor;
  final Color selectedIconColor;
  final bool isSelectableItem;
  final bool isSelectableList;
  final double height;

  const CardComponent({
    Key? key,
    required this.contentAxis,
    required this.background,
    required this.imageBackground,
    required this.data,
    required this.titleStyle,
    required this.subTitleStyle,
    required this.descriptionStyle,
    required this.ratingStyle,
    required this.ratingClr,
    required this.isRating,
    required this.isFav,
    required this.elevation,
    required this.favIconClr,
    required this.favIconAlignment,
    required this.favIconSize,
    required this.selectedColor,
    required this.selectedIconColor,
    required this.isSelectableItem,
    required this.isSelectableList,
    required this.height,
  }) : super(key: key);

  @override
  State<CardComponent> createState() => _CardComponentState();
}

class _CardComponentState extends State<CardComponent> {

  double? top, left, right, bottom;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height *
              widget.height, //0.32 for vertical // 0.22 for horizontal
          child: Card(
              color: widget.data.isSelected != true
                  ? widget.background
                  : widget.selectedColor,
              elevation: widget.elevation,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: widget.contentAxis == Axis.horizontal
                  ? horizontalContent()
                  : verticalContent()),
        ),
      ),
    );
  }

  enableSelect() {
    setState(() {
      isSelectableItem.value = true;
      debugPrint("enabled ${isSelectableItem.value}");
    });
  }

  Widget verticalContent() {
    return InkWell(
      onTap: () {
        debugPrint("clicked");
        isSelectableItem.value != true
            ? widget.data.onTab != null ? widget.data.onTab!(widget.data.id!):null
            : widget.data.onSelected!(widget.data.id!);
      },
      onLongPress: () {
        widget.isSelectableList == true ? enableSelect() : null;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(widget.data.image.toString(),
                      fit: BoxFit.contain, alignment: Alignment.center,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Container(); //shimmer
                      }, loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      }),
                ),
              ),
              Visibility(
                visible: widget.isFav,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: widget.favIconAlignment,
                    child: IconButton(
                      onPressed: () {
                        widget.data.onFav!=null?  widget.data.onFav!(widget.data.id!):null;
                      },
                      icon: Icon(
                        widget.data.isFav == true
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: widget.favIconClr,
                        size: widget.favIconSize,
                      ),
                    ),
                  ),
                ),
              ),
              Obx(() => Visibility(
                visible: isSelectableItem.isTrue,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, right: 8),
                      child: Icon(
                        widget.data.isSelected == true
                            ? Icons.check_box_rounded
                            : Icons.check_box_outline_blank_rounded,
                        color: widget.selectedColor,
                        //size: widget.favIconSize,
                      ),
                    ),
                  ),
                ),
              ))
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.data.title.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: widget.titleStyle,
                  ),
                ),
                Visibility(
                  visible: widget.isRating,
                  child: Row(
                    children: [
                      Text(
                        widget.data.rating??"",
                        style: widget.ratingStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                      Icon(
                        Icons.star,
                        color: widget.ratingClr,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.data.subTitle??"",
              style: widget.subTitleStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              widget.data.description??"",
              style: widget.descriptionStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget horizontalContent() {
    return InkWell(
      onTap: () {
        debugPrint("clicked");
        isSelectableItem.value != true
            ? widget.data.onTab != null ? widget.data.onTab!(widget.data.id!):null
            : widget.data.onSelected!(widget.data.id!);
      },
      onLongPress: () {
        widget.isSelectableList == true ? enableSelect() : null;
      },
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(widget.data.image.toString(),
                      fit: BoxFit.contain, alignment: Alignment.center,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Container(); //shimmer
                      }, loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      }),
                ),
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.data.title.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: widget.titleStyle,
                              ),
                            ),
                            Visibility(
                              visible: widget.isRating,
                              child: Row(
                                children: [
                                  Text(
                                    widget.data.rating??"",
                                    style: widget.ratingStyle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: widget.ratingClr,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          widget.data.subTitle??"",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: widget.subTitleStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          widget.data.description??"",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: widget.descriptionStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: widget.isFav,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.3,
              child: Align(
                alignment: widget.favIconAlignment,
                child: IconButton(
                  onPressed: () {
                    widget.data.onFav!=null?  widget.data.onFav!(widget.data.id!):null;
                  },
                  icon: Icon(
                    widget.data.isFav == true
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: widget.favIconClr,
                    size: widget.favIconSize,
                  ),
                ),
              ),
            ),
          ),
          Obx(() => Visibility(
            visible: isSelectableItem.isTrue,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, right: 8),
                  child: Icon(
                    widget.data.isSelected == true
                        ? Icons.check_box_rounded
                        : Icons.check_box_outline_blank_rounded,
                    color: widget.selectedIconColor,
                    //size: widget.favIconSize,
                  ),
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
