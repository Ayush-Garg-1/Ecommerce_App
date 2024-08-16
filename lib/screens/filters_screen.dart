import 'package:ecommerce/bloc/filterBloc/filter_bloc.dart';
import 'package:ecommerce/bloc/filterBloc/filter_event.dart';
import 'package:ecommerce/bloc/filterBloc/filter_state.dart';
import 'package:ecommerce/utils/appWidgets/Circular_progress_indicator.dart';
import 'package:ecommerce/utils/appWidgets/category_button.dart';
import 'package:ecommerce/utils/appWidgets/horizontal-space.dart';
import 'package:ecommerce/utils/appWidgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/products_model.dart';
import '../services/database_helper.dart';
import '../utils/appWidgets/button.dart';
import '../utils/appWidgets/card.dart';
import '../utils/appWidgets/dropdown.dart';
import '../utils/appWidgets/searchbar.dart';

class FilterScreen extends StatelessWidget {


  List<String> menuItems = ['PRICE(LOWEST)','PRICE(HIGHEST)','A TO Z',
    'Z TO A'];


  Widget build(BuildContext context) {
    double lowerValue = context.read<FilterBloc>().lowerValue ;
    double upperValue = context.read<FilterBloc>().upperValue ;
    print(lowerValue);
    print(upperValue);
    return  SafeArea(
        child: Scaffold(
            body:
            BlocConsumer<FilterBloc,FilterState>(
              listener: (context,state){},
              builder: (context,state){
                if(state is FilterProductLoadingState){
                  return CustomCircularProgressIndicator();
                }else if(state is FilterProductLoadedState){
                  return ListView(
                    children: [
                      VerticalSpacing(size: 10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),

                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.7,
                              child: TextField(
                                onChanged: (value){
                                  context.read<FilterBloc>().add(FetchSearchProductEvent(
                                    searchValue: value
                                  ));
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                    hintText: "Search ...",
                                    hintStyle: TextStyle(fontWeight: FontWeight.bold),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                        color: Colors.orange,
                                        width: 3,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(
                                        color: Colors.orange,
                                        width: 3,
                                      ),
                                    )
                                ),
                              ),
                            ),
                            HorizontalSpacing(size: 20),
                            Center(
                                child:
                                PopupMenuButton(
                                  child:CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.orange,
                                    child: Icon(Icons.filter_list,color: Colors.white,size: 30,),
                                  ),
                                  onSelected: (value) async{
                                    context.read<FilterBloc>().add(
                                        FetchDropDownProductEvent(dropdownValue: value));
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return
                                      menuItems.map((String value) {
                                        return PopupMenuItem(
                                          value: value.toString(),
                                          child: Text(
                                            value.toString(),
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        );

                                      }).toList();

                                  },
                                )
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          child: RangeSlider(
                            activeColor: Colors.orange,
                            inactiveColor: Colors.orange.withOpacity(0.3),
                            values: RangeValues(lowerValue, upperValue),
                            labels: RangeLabels(
                            '$lowerValue',
                            '$upperValue',
                          ),
                            min: 0,
                              max: 1500,
                              divisions: 150,
                              onChanged: (val) async{

                                context.read<FilterBloc>().lowerValue = val.start;
                                context.read<FilterBloc>().upperValue  = val.end;
                                print(context.read<FilterBloc>().upperValue);

                          }, ),
                        ),
                      ),
                     VerticalSpacing(size: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Category Filter".toUpperCase(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                      VerticalSpacing(size: 10),
                      FutureBuilder(
                        future: DataBaseHelper().getProductsCategories(),
                        builder: (context,snapshot){
                          if(snapshot.hasData){
                            List<String> categories = snapshot.data;
                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: categories.map((category){
                                  return  CategoryButton(
                                    btnText: category,
                                    icon: Icons.star,
                                    callback: (){
                                      context.read<FilterBloc>().add(FetchCategoryProductEvent(category: category));
                                    },
                                  );
                                }).toList(),
                              ),
                            );
                          }
                          else{
                            return Container();
                          }
                        },

                      ),
                      SizedBox(height: 20,),
                       Center(
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 20,
                          runSpacing: 20,
                          children:
                          state.products.map((product){
                            return
                              CustomCard(product: product);
                          }).toList(),
                        ),
                      ),
                    ],
                  );
                }
                else{
                  return Container();
                }
              },
            )
        ),
      );
  }
}
