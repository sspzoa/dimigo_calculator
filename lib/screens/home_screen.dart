import 'package:dimigo_calculator/main_theme.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: systemStyle,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Text(
              '디미고 교과점수계산기 2025',
              style: titleTextStyle(context),
            ),
            const SizedBox(height: 15),
            Text(
              '본 앱은 한국디털미디어고의 공식 앱이 아니며\n입력한 정보는 어디에도 저장되지 않습니다.',
              textAlign: TextAlign.center,
              style: subTitleTextStyle(context),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/input'),
                  child: const Text('점수 입력하기'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
