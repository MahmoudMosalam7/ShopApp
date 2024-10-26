import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshopapp/screens/shop_layout/shop_cubit.dart';
import 'package:newshopapp/screens/shop_layout/shop_states.dart';
import 'package:newshopapp/shared/component.dart';

import '../../shared/color.dart';

class SettingsPage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      builder: (BuildContext context, ShopStates state) {
        var cubit = ShopCubit.get(context);

        nameController.text = cubit.userModel!.data!.name!;
        emailController.text = cubit.userModel!.data!.email!;
        phoneController.text = cubit.userModel!.data!.phone!;
        return cubit.userModel != null ? Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              defaultTextFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (String? value){
                    if(value!.isEmpty){
                      return "name must not be empty";
                    }
                    return null;
                  },
                  label: "Name",
                  prefix: Icons.person
              ),
              const SizedBox(height: 20.0,),
              defaultTextFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: (String? value){
                    if(value!.isEmpty){
                      return "email address must not be empty";
                    }
                    return null;
                  },
                  label: "Email Address",
                  prefix: Icons.email
              ),
              const SizedBox(height: 20.0,),
              defaultTextFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate: (String? value){
                    if(value!.isEmpty){
                      return "phone  must not be empty";
                    }
                    return null;
                  },
                  label: "Phone Number",
                  prefix: Icons.phone
              ),
              const SizedBox(height: 20.0,),
              defaultButton(
                  onPressed: (){
                    signOut(context);
                  },
                  text: "Logout"
              ),
            ],
          ),
        ) :
        const Center(child: CircularProgressIndicator(
          color: defaultActiveColor,
        ),
        );
      },
      listener: (BuildContext context, ShopStates state) {

      },
    );
  }
}
