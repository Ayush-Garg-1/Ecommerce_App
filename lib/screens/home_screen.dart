import 'package:ecommerce/bloc/homeBloc/home_bloc.dart';
import 'package:ecommerce/bloc/homeBloc/home_state.dart';
import 'package:ecommerce/utils/appWidgetFunction/snackbar.dart';
import 'package:ecommerce/utils/appWidgets/Circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/homeBloc/home_event.dart';
import '../models/products_model.dart';
import '../utils/appWidgets/bigProductCard.dart';
import '../utils/appWidgets/cardHeading.dart';
import '../utils/appWidgets/circle_avatar.dart';
import '../utils/appWidgets/image_slider.dart';
import '../utils/appWidgets/slider.dart';
import '../utils/appWidgets/smallCard.dart';
import '../utils/appWidgets/vertical_space.dart';
import '../utils/themes/colors.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(
          create: (_)=>HomeBloc()..add(FetchProductsEvent()),
        child: Scaffold(
            body:
            BlocConsumer<HomeBloc,HomeState>(
                listener:(context,state){
                  if(state is ProductErrorState){
                    showCustomSnackbar(context: context,message:state.message,color: RED_COLOR);
                  }
                } ,
              builder: (context,state){
              if(state is ProductLoadingState){
                return CustomCircularProgressIndicator();
              }else if(state is ProductLoadedState){
                return  Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          LITE_RED_COLOR,
                          LITE_YELLOW_COLOR

                        ],
                        begin:Alignment.topRight,
                        end: Alignment.bottomLeft
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        VerticalSpacing(size: 15),
                        Container(
                          height: 90,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:state.products?.length,
                              itemBuilder: (context, index) {
                                ProductModel product = state.products![index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/product-details-screen",arguments: product);
                                  },
                                  child: CustomCircleAvatar(
                                    imagePath: product.thumbnail,
                                  ),
                                );
                              }),
                        ),
                        VerticalSpacing(size: 10),
                        CustomCarouselSlider(
                          images: [
                            "assets/images/f1.jpg",
                            "assets/images/f2.jpg",
                            "assets/images/fu1.jpg",
                            "assets/images/fu2.jpg",
                            "assets/images/b1.jpg",
                            "assets/images/b2.jpg",
                            "assets/images/g1.jpg",
                            "assets/images/g3.jpg"
                          ],
                        ),
                        FutureBuilder(future: context.read<HomeBloc>().getCategoryWiseProducts("beauty", true),
                            builder: (context,snapshot){
                              if(snapshot.hasData){
                                List<ProductModel>? products = snapshot.data;
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                  color: LITE_PINK,
                                  child: Column(children: [
                                    VerticalSpacing(size: 15),
                                    CardBoxHeading(heading:"Explore new selection"),
                                    VerticalSpacing(size: 15),
                                    Wrap(
                                      runSpacing: 20,
                                      children: products!.map((product){
                                        return  InkWell(
                                          onTap: (){
                                            Navigator.pushNamed(context, "/product-details-screen",arguments: product);
                                          },
                                          child:BigProductCard(
                                            imageUrl: product.thumbnail,
                                            title: product.title,
                                            price:product.price,
                                            discount: product.discountPercentage,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                    VerticalSpacing(size: 20),
                                  ]),
                                );
                              }else{
                                return CustomCircularProgressIndicator();
                              }
                            }
                        ),
                        VerticalSpacing(size: 30),
                        CustomImageCarouselSlider(
                            products: state.products
                            as List<ProductModel>),
                        VerticalSpacing(size: 10),
                        Wrap(
                          runSpacing: 20,
                          children: state.products!.map((product){
                            return  InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, "/product-details-screen",arguments: product);
                              },
                              child: SmallProductCard(
                                imageUrl: product.thumbnail,
                                title: product.title,
                                content: product.price.toString(),
                              ),
                            );
                          }).toList(),
                        ),
                        VerticalSpacing(size: 30),

                      ],
                    ),
                  ),
                );
              }else{
                return Container();
              }
            },)
        ),
      );
  }
}
