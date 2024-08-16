abstract class FilterEvent {}


class FetchAllProductEvent extends FilterEvent{
}

class FetchSearchProductEvent extends FilterEvent{
  String? searchValue;
  FetchSearchProductEvent({this.searchValue});
}

class FetchDropDownProductEvent extends FilterEvent{
  String? dropdownValue;
  FetchDropDownProductEvent({this.dropdownValue});
}

class FetchCategoryProductEvent extends FilterEvent{
  String? category;
  FetchCategoryProductEvent({this.category});
}