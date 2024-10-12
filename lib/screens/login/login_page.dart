import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshopapp/screens/login/login_cubit.dart';
import 'package:newshopapp/screens/login/login_states.dart';
import 'package:newshopapp/shared/color.dart';

import '../../routes/app_routes.dart';
import '../../shared/component.dart';

class LoginPage extends StatelessWidget {

  var emailContoller = TextEditingController();

  var passwordContoller = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        builder: (BuildContext context, LoginStates state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child:Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',style:Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Colors.black
                        ) ,),
                        Text('Login now to browse our hot offers',
                          style:Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey
                          ) ,),
                        const SizedBox(height: 30,),
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
                            isSecure: LoginCubit.get(context).isPassword,
                          prefix: Icons.lock_outline,
                          suffix:LoginCubit.get(context).suffix ,
                          suffixPressed: () {
                            // Handle suffix icon press
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                          onSubmit: (value){
                            if(formKey.currentState!.validate()){
                              LoginCubit.get(context).userLogin(
                                  email: emailContoller.text,
                                  password: passwordContoller.text);
                            }
                          }
                        ),
                        const SizedBox(height: 15,),
                        state is! LoginLoadingState?
                        defaultButton(text: 'Login',onPressed: (){
                          if(formKey.currentState!.validate()){
                            LoginCubit.get(context).userLogin(
                                email: emailContoller.text,
                                password: passwordContoller.text);
                          }

                        }) :Center(
                          child: CircularProgressIndicator(
                            color: defaultActiveColor,
                          ),
                        ) ,
                        const SizedBox(height: 15,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            defaultTextButton(
                                onPressed: () {
                                  navigateTo(context, AppRoutes.REGISTER);
                                },
                                text: 'Register'
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, LoginStates state) {  },
      ),
    );
  }
}
