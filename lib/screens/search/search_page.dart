import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshopapp/screens/search/search_cubit.dart';
import 'package:newshopapp/screens/search/search_states.dart';
import 'package:newshopapp/shared/component.dart';

import '../../shared/color.dart';

class SearchPage extends StatelessWidget {

  var searchContoller = TextEditingController();

  var formKey = GlobalKey<FormState>();

  SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit,SearchStates>(
      builder: (BuildContext context, SearchStates state) {
        var cubit = SearchCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultTextFormField(
                      controller: searchContoller,
                      type: TextInputType.text,
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'enter text to search';
                        }
                        return null;
                      },
                      label: 'Search',
                    prefix: Icons.search,
                    onSubmit: (String text){
                        SearchCubit.get(context).search(text);
                    }
                  ),
                  const SizedBox(height: 20.0,),
                  if(state is SearchLoadingState)
                    const LinearProgressIndicator(color: defaultActiveColor,),
                  if(state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                        scrollDirection: Axis.vertical ,
                        itemBuilder: (context,index) => buildListProductItem(
                            cubit.model!.data!.data![index],
                            context,
                            isOldPrice: false
                        ),
                        separatorBuilder: (context,index) =>myDivider(),
                        itemCount: cubit.model!.data!.data!.length
                    ),
                  )

                ],
              ),
            ),
          ),
        ) ;
      },
      listener: (BuildContext context, SearchStates state) {  },);
  }


}
