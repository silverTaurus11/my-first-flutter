
import 'package:flutter/material.dart';
import 'package:my_first_flutter/my_helper.dart';
import 'package:my_first_flutter/model/profile_item.dart';
import 'package:my_first_flutter/page/base_page.dart';
import 'package:my_first_flutter/page/dashboard/main_page.dart';
import 'package:my_first_flutter/style.dart';


class LoginPage extends BasePage{
  static const routeName = '/login_page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}
class LoginPageState extends BasePageState<LoginPage>{
  bool _isObscure = true ;
  bool _isChecked = false;
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  ProfileItem loginItem = ProfileItem();

  @override
  Widget createLayout(BuildContext context) {

    void setEye(){
      setState(() {
        _isObscure = !_isObscure;
      });
    }

    return Scaffold(
      body: Center(
        child: Padding(padding: const EdgeInsets.only(
            top: 50,
            right: 20,
            left: 20,
            bottom: 50
        ),
        child: Wrap(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              color: const Color(0x33000000),
              child: Form(
                key: _loginFormKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Login', style: Theme.of(context).textTheme.headline4),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      TextFormField(
                          controller: _userNameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Username"
                          ),
                          style: CustomStyle.formEditText(context),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Name';
                            }
                            return null;
                          }
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      TextFormField(
                          controller: _passwordController,
                          obscureText: _isObscure,
                          obscuringCharacter: "*",
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: "Password",
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure ? Icons.visibility : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ), onPressed: () {
                                setEye();
                              })
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Password';
                            }
                            return null;
                          }
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      Row(
                          mainAxisSize: MainAxisSize.min,
                          children:<Widget> [
                            Expanded(
                                flex: 7,
                                child: CheckboxListTile(
                                  title: const Text("Remember Me"),
                                  checkColor: Colors.white,
                                  value: _isChecked,
                                  controlAffinity: ListTileControlAffinity.leading,
                                  onChanged: (bool? value){
                                    setState(() {
                                      _isChecked = value!;
                                    });
                                  },
                                )),
                            Expanded(
                                flex: 3,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: const Color(0xFF6200EE),
                                      textStyle: const TextStyle(fontSize: 14)),
                                  onPressed: () {
                                    if (_loginFormKey.currentState!.validate()) {
                                      loginItem.userName = _userNameController.text;
                                      loginItem.password = _passwordController.text;
                                      loginItem.tokenThirdParty = "null";
                                      loginItem.loginWith = "normal";
                                      Navigator.pushReplacementNamed(context, MainPage.routeName);
                                      MyHelper.saveProfileItemToLocal(loginItem);

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("You're logged in now")),
                                      );
                                    }
                                  },
                                  child: const Text('Sign In'),
                                ))

                          ])
                    ]),
              )
          )],
        )),
      ));
  }

}