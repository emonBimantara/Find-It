class ItemCategory {
  final String id;
  final String name;

  const ItemCategory({required this.id, required this.name});
}

const itemCategories = [
  ItemCategory(id: "all", name: "All"),
  ItemCategory(id: "lost", name: "Lost"),
  ItemCategory(id: "found", name: "Found"),
];
