import 'package:ecommerce/bloc/homeBloc/home_bloc.dart';
import 'package:ecommerce/bloc/homeBloc/home_event.dart';
import 'package:ecommerce/bloc/homeBloc/home_state.dart';
import 'package:ecommerce/bloc/userScreenBloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/products_model.dart';
import '../utils/appWidgetFunction/snackbar.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(_)=>HomeBloc()..add(FetchProductsEvent()),
      child: Scaffold(
          body: BlocConsumer<HomeBloc,HomeState>(
            listener:(context,state){
              if(state is ProductErrorState){
                showCustomSnackbar(context: context,message:state.message,color: Colors.red);
              }
            } ,
            builder: (context,state){
              if(state is LoadingState){
                return CircularProgressIndicator();
              }else if(state is ProductLoadedState){
                return  Padding(
                    padding: const EdgeInsets.only(top: 20,bottom: 10,left: 10,right: 10),
                    child: GridView.builder(
                        itemCount:state.products?.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.6,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          ProductModel? product = state.products?[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, "/product-details-screen",arguments: product);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.orange.withOpacity(0.4),
                                        blurRadius: 5)
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: Image.network(
                                        product?.thumbnail ?? "",
                                        height: 150,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      product!.title.toString(),
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.star, color: Colors.orange),
                                        Icon(Icons.star, color: Colors.orange),
                                        Icon(Icons.star, color: Colors.orange),
                                        Icon(Icons.star_half, color: Colors.orange),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("${product?.price.toString()}",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        Icon(
                                          Icons.currency_rupee,
                                          color: Colors.green,
                                          size: 22,
                                        )
                                      ],
                                    )
                                  ]),
                            ),
                          );
                        })
                );
              }else{
                return  CircularProgressIndicator();
              }
            },
          )
      ),
    );
  }
}
