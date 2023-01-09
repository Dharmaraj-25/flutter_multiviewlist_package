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
