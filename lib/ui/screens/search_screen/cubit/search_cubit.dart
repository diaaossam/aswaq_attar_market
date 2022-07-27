import 'package:aswaq_attar_market/model/product_model.dart';
import 'package:aswaq_attar_market/shared/helper/mangers/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);

  List<ProductModel> productList = [];

  void serachQuery({required String query}) {
    FirebaseFirestore.instance
        .collection(ConstantsManger.Products)
        .where('title',
            isGreaterThanOrEqualTo: query,
            isLessThan: query.substring(0, query.length - 1) +
                String.fromCharCode(query.codeUnitAt(query.length - 1) + 1))
        .get()
        .then((value) {
      productList.clear();
      value.docs.forEach((element) {
        productList.add(ProductModel.fromJson(element.data()));
      });
      emit(SeachListState());
    });
  }
}
