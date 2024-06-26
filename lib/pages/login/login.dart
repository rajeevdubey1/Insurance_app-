import 'package:book_insurance/pages/Dashboard/plan_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late Color myColor;
  late Size mediumSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
   bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediumSize = MediaQuery.of(context).size;
    debugPrint(mediumSize.width.toString());

    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
            image: const AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
            colorFilter:
                ColorFilter.mode(myColor.withOpacity(0.2), BlendMode.dstATop)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: (mediumSize.width > 400) ? 80 : 40,
              child: _buildTop(),
            ),
            Positioned(
              bottom: 0,
              child: _buildBottom(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediumSize.width,
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on_sharp,
            size: (mediumSize.width > 400) ? 100 : 50,
            color: Colors.white,
          ),
          Text(
            'ABNIC',
            style: TextStyle(
              color: Colors.white,
              fontSize: (mediumSize.width > 400) ? 40 : 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediumSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome',
          style: TextStyle(
            color: myColor,
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
        _buildGrayText('Please login with your details'),
        const SizedBox(
          height: 60,
        ),
        _buildGrayText('Email address'),
        _buildInputField(emailController),
        const SizedBox(
          height: 40,
        ),
        _buildGrayText('Password'),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 20,),
        _buildRememberForgot(),
        const SizedBox(height: 20,),
        _buildLoginbutton(),
        // const SizedBox(height: 20,),
        //_buildOtherButtons(),
      ],
    );
  }

  Widget _buildGrayText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Checkbox(
                  value: rememberUser,
                  onChanged: (value) {
                    setState(() {
                      rememberUser = value!;
                    });
                  }),
              _buildGrayText('remember me'),
            ],
          ),
        ),
        Expanded(child: TextButton(onPressed: () {}, child: const Text('I forgot my password'))),
      ],
    );
  }

  Widget _buildLoginbutton() {
    return isLoading ? const Center(
      child: CircularProgressIndicator(),
    ) : ElevatedButton(
      onPressed: () {
        if(emailController.text == 'rajeev@click2secure.me' && passwordController.text == '123456'){ 
          // start loading indecator when redirecting to plan page
          setState(() {
          isLoading = true;
        });

          // redirect to plan page after 1000 milisecond
          Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const PlanPage(),),);
          });
        }
        else
        {
          // reset email and password fields and show error message
          emailController.clear();
          passwordController.clear();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter correct details!'), backgroundColor: Colors.red,),);
        }
        
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        shadowColor: myColor,
        backgroundColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text('LOGIN', style: TextStyle(color: Colors.white),),
    );
  }

// Widget _buildOtherButtons(){
//   return Center(
//     child: Column(
//       children: [
//         _buildGrayText('Or Login with'),
//         const SizedBox(height: 10,),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Tab(icon: Image.asset('assets/images/facebook.png'),),
//             Tab(icon: Image.asset('assets/images/twitter.png'),),
//             Tab(icon: Image.asset('assets/images/github.png'),),
//           ],
//         )
//       ],
//     ),
//   );
// }

}
