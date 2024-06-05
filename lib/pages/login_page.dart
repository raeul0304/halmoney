import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:halmoney/myAppPage.dart';
import 'package:halmoney/pages/agreement_page.dart';

final storage = FirebaseStorage.instance;

class LoginPage extends StatelessWidget{
  LoginPage({super.key});

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final String id = _idController.text;
    final String password = _passwordController.text;

    //Firestore에서 사용자 문서(토큰) 가져오기
    try{
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('user')
          .where('id', isEqualTo: id)
          .where('password', isEqualTo: password)
          .get();

      final List<DocumentSnapshot> documents = result.docs;

      if(documents.isNotEmpty){
        //로그인 성공
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyAppPage(id:id)),
        );
      } else {
        //오류 처리
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('아이디 또는 비밀번호가 잘못되었습니다.')),
        );
      }
    } catch (e) {
      //오류 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류가 발생했습니다: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.red,),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(padding: (EdgeInsets.only(top: 100)),),
              const Center(
                child: Image(
                  image: AssetImage('assets/images/img_logo.png'),
                  width: 100,
                  height: 120,
                ),
              ),
              Form(child: Container(
                padding: const EdgeInsets.only(left: 60.0, right: 60.0, top:30.0),
                child: Column(
                  children: [
                    const Text(
                      "로그인",
                      style: TextStyle(
                        fontSize: 26,
                        fontFamily: 'NanumGothicExtraBold',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextField(
                      controller : _idController,
                      decoration: InputDecoration(
                          labelText: '아이디'

                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          labelText: '비밀번호'
                      ),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                    ),

                    const SizedBox( //위젯 사이에 간격두기
                      height: 20.0,
                    ),
                    ElevatedButton( //로그인 버튼
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(250, 51, 51, 255),
                            surfaceTintColor: const Color.fromARGB(100, 51, 51, 255),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(300,45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )
                        ),
                        onPressed: () => _login(context),
                        child: const Text(
                          "로그인",
                        )
                    ),

                    TextButton(onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AgreementPage())
                      );
                    },
                      style: TextButton.styleFrom(
                        foregroundColor: const Color.fromARGB(250, 51,51, 51),
                        padding: const EdgeInsets.only(left: 220),
                        textStyle: const TextStyle(fontSize: 13),
                      ), //회원가입 버튼
                      child: const Text("회원가입", textAlign: TextAlign.right),
                    ),

                    const SizedBox( //위젯 사이에 간격두기
                      height: 5.0,
                    ),
                    const Divider(
                      thickness: 1,
                      height: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox( //위젯 사이에 간격두기
                      height: 15.0,
                    ),
                    const Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black26,
                      ),
                    ),
                    const SizedBox( //위젯 사이에 간격두기
                      height: 15.0,
                    ),
                    ElevatedButton.icon(
                      onPressed: (){},
                      icon: const Icon(Icons.chat_bubble),
                      label: const Text('  카카오톡으로 로그인',),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(250, 255, 230, 0),
                          surfaceTintColor: const Color.fromARGB(100, 255, 230, 0),
                          foregroundColor: Colors.black,
                          minimumSize: const Size(300,45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        )
    );
  }
}
