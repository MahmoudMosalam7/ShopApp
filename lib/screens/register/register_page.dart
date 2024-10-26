import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshopapp/screens/register/register_cubit.dart';
import 'package:newshopapp/screens/register/register_states.dart';

import '../../routes/app_routes.dart';
import '../../shared/color.dart';
import '../../shared/component.dart';

class RegisterPage extends StatelessWidget {
  var nameContoller = TextEditingController();

  var phoneContoller = TextEditingController();

  var emailContoller = TextEditingController();

  var passwordContoller = TextEditingController();

  var formKey = GlobalKey<FormState>();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        builder: (BuildContext context, RegisterStates state) {
          return Scaffold(
            appBar: AppBar(),
            body:Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child:Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('REGISTER',style:Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Colors.black
                        ) ,),
                        Text('Register now to browse our hot offers',
                          style:Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey
                          ) ,),
                        const SizedBox(height: 30,),
                        defaultTextFormField(
                          controller: nameContoller,
                          type: TextInputType.name,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                          label: 'User Name',
                          prefix: Icons.person,

                        ),
                        const SizedBox(height: 15,),
                        defaultTextFormField(
                          controller: phoneContoller,
                          type: TextInputType.phone,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your phone';
                            }
                            return null;
                          },
                          label: 'Phone Number',
                          prefix: Icons.phone,

                        ),
                        const SizedBox(height: 15,),
                        defaultTextFormField(
                          controller: emailContoller,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,

                        ),
                        const SizedBox(height: 15,),
                        defaultTextFormField(
                            controller: passwordContoller,
                            type: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'password is too short';
                              }
                              return null;
                            },
                            label: 'Password',
                            isSecure: RegisterCubit.get(context).isPassword,
                            prefix: Icons.lock_outline,
                            suffix:RegisterCubit.get(context).suffix ,
                            suffixPressed: () {
                              // Handle suffix icon press
                              RegisterCubit.get(context).changePasswordVisibility();
                            },
                            onSubmit: (value){
                              if(formKey.currentState!.validate()){
                                RegisterCubit.get(context).userRegister(
                                    name:nameContoller.text ,
                                    phone: phoneContoller.text,
                                    email: emailContoller.text,
                                    password: passwordContoller.text);
                              }
                            }
                        ),
                        const SizedBox(height: 15,),
                        state is! RegisterLoadingState?
                        defaultButton(text: 'Register',onPressed: (){
                          if(formKey.currentState!.validate()){
                            RegisterCubit.get(context).userRegister(
                                name:nameContoller.text ,
                                phone: phoneContoller.text,
                                email: emailContoller.text,
                                password: passwordContoller.text);
                          }

                        }):const Center(
                           child: CircularProgressIndicator(
                             color: defaultActiveColor,
                           ),
                         ) ,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, RegisterStates state) {
          if(state is RegisterSuccessState){
            if(state.loginModel.status != null && state.loginModel.status!){
              navigateAndFinish(context, AppRoutes.LOGIN);
              showToast(message: state.loginModel.message!,state:
              ToastStates.SUCCESS);
            }else{
              showToast(message: state.loginModel.message!,state:
              ToastStates.ERROR);
            }
          }
        },
      ),
    );
  }
}
