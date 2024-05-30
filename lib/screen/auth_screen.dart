import 'package:calendar_scheduler/component/login_text_field.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/provider/schedule_provider.dart';
import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScheduleProvider>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 세로로 중앙배치
            crossAxisAlignment: CrossAxisAlignment.stretch, // 가로로 최대
            children: [
              // 로고를 화면 너비의 절반크기로 그리고, 가운데 정렬
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/img/logo.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
              const SizedBox(height: 16.0),
              LoginTextField(
                onSaved: (String? val) {
                  email = val!;
                },
                validator: (String? val) {
                  if (val?.isEmpty ?? true) {
                    return '이메일을 입력해주세요.';
                  }

                  RegExp reg = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

                  if (!reg.hasMatch(val!)) {
                    return '이메일 형식이 올바르지 않습니다.';
                  }

                  // 입력값에 문제가 없다면 null을 반환
                  return null;
                },
                hintText: '이메일',
              ),
              const SizedBox(height: 8.0),
              LoginTextField(
                obscureText: true,
                onSaved: (String? val) {
                  password = val!;
                },
                validator: (String? val) {
                  if (val?.isEmpty ?? true) {
                    return '비밀번호를 입력해주세요.';
                  }

                  // 4~8자리 사이인지 확인
                  if (val!.length < 4 || val.length > 8) {
                    return '비밀번호는 4~8자 사이로 입력해주세요!';
                  }

                  // 입력값이 문제가 없다면 null을 반환
                  return null;
                },
                hintText: '비밀번호',
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: SECONDARY_COLOR,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                onPressed: () {
                  onRegisterPress(provider);
                },
                child: Text('회원가입'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: SECONDARY_COLOR,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                onPressed: () {
                  onLoginPress(provider);
                },
                child: Text('로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool saveAndValidateForm() {
    if (!formKey.currentState!.validate()) {
      return false;
    }

    formKey.currentState!.save();

    return true;
  }

  onRegisterPress(ScheduleProvider provider) async {
    if (!saveAndValidateForm()) {
      return;
    }

    String? message;

    try {
      await provider.register(
        email: email,
        password: password,
      );
    } on DioError catch (e) {
      message = e.response?.data['message'] ?? '알수없는 오류가 발생했습니다.';
    } catch (e) {
      message = '알 수 없는 오류가 발생했습니다!!!!.';
    } finally {
      if (message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      } else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => HomeScreen(),
        ));
      }
    }
  }

  onLoginPress(ScheduleProvider provider) async {
    if(!saveAndValidateForm()) {
      return;
    }

    String? message;

    try{
      await provider.login(
        email: email,
        password: password,
      );
    } on DioError catch(e) {
      message = e.response?.data['message'] ?? '알수 없는 오류가 발생했습니다.';
    } catch (e) {
      message = '알 수 없는 오류가 발생했습니다.';
    } finally {
      if(message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(message),
          ),
        );
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => HomeScreen(),
          ),
        );
      }
    }
  }
}
