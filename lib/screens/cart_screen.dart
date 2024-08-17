import 'package:ecommerce/bloc/cartBloc/cart_bloc.dart';
import 'package:ecommerce/bloc/cartBloc/cart_event.dart';
import 'package:ecommerce/bloc/cartBloc/cart_state.dart';
import 'package:ecommerce/models/cart_model.dart';
import 'package:ecommerce/utils/appWidgetFunction/dialog.dart';
import 'package:ecommerce/utils/appWidgets/Circular_progress_indicator.dart';
import 'package:ecommerce/utils/appWidgets/dismisssible_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/themes/colors.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CartBloc()..add(FetchCartProductEvent()),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return Scaffold(
            body: buildBody(context, state),
            floatingActionButton: buildFloatingActionButton(context, state),
          );
        },
      ),
    );
  }

  Widget buildBody(BuildContext context, CartState state) {
    if (state is CartLoadingState) {
      return CustomCircularProgressIndicator();
    } else if (state is EmptyCartProductsState) {
      return Center(child: Image.asset("assets/images/sp1.gif"));
    } else if (state is CartProductLoadedState) {
      return ListView.builder(
        itemCount: state.products.length,
        itemBuilder: (context, index) {
          CartProductModel product = state.products[index];
          return CustomDismissibleWidget(
            context: context,
            product: product,
            cartBloc: BlocProvider.of<CartBloc>(context),
          );
        },
      );
    } else {
      return Container();
    }
  }

  Widget? buildFloatingActionButton(BuildContext context, CartState state) {
    if (state is CartProductLoadedState && state.products.isNotEmpty) {
      return FloatingActionButton(
        onPressed: () {
          productOrderDialog(
            context: context,
            products: state.products,
          );
        },
        foregroundColor: Theme.of(context).secondaryHeaderColor,
        backgroundColor: Theme.of(context).primaryColor,
        hoverColor: RED_COLOR,
        child: Icon(
          Icons.payments,
          color: Theme.of(context).secondaryHeaderColor,
          size: 30,
        ),
      );
    }
    return null;
  }
}
