import 'package:flutter/material.dart';
import 'package:smart_fridge_monitoring/data/dtb.dart';
import 'package:uuid/uuid.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key});

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController usertype = TextEditingController();
  bool _isPasswordVisible = false;

  void _addaccount() {
    if (username.text.isNotEmpty &&
        email.text.isNotEmpty &&
        phone.text.isNotEmpty &&
        password.text.isNotEmpty &&
        usertype.text.isNotEmpty) {
      String userid = Uuid().v4();
      DataBase.adduser(
          userid: userid,
          username: username.text,
          email: email.text,
          phone: phone.text,
          password: password.text,
          usertype: usertype.text);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("User Added Successfully")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Check Missing Fields")));
    }
  }

  void _cleardata() {
    username.text = "";
    email.text = "";
    phone.text = "";
    password.text = "";
    usertype.text = "";
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    usertype.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/addaccount.jpg'), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: TextField(
              controller: username,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Username",
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  prefixIcon: Icon(Icons.person)),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          SizedBox(
            width: 300,
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  prefixIcon: Icon(Icons.email)),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          SizedBox(
            width: 300,
            child: TextField(
              controller: phone,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Phone",
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  prefixIcon: Icon(Icons.phone)),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          SizedBox(
            width: 300,
            child: TextField(
              controller: password,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Password",
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15)),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(_isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off)),
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          SizedBox(
            width: 300,
            child: TextField(
              controller: usertype,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Role",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  prefixIcon: Icon(Icons.manage_accounts_sharp)),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: _addaccount,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: Text(
                    "Add",
                    style: TextStyle(fontSize: 30, color: Colors.blue[300]),
                  ),
                ),
              ),
              SizedBox(
                width: 60,
              ),
              SizedBox(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: _cleardata,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: Text(
                    "Clear",
                    style: TextStyle(fontSize: 30, color: Colors.blue[300]),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
