import 'package:flutter/material.dart';
import 'package:dimigo_calculator/main_theme.dart';
import 'package:dimigo_calculator/screens/input_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.scores});

  final AdmissionScores scores;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('계산 결과'),
      ),
      body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: GridView.count(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              mainAxisSpacing: 30,
              crossAxisSpacing: 0,
              children: [
                ScoreIndicator(
                  score: scores.secondGradeScore,
                  maxScore: 72,
                  label: '2학년 점수',
                  primaryColor: Theme.of(context).primaryColor,
                ),
                ScoreIndicator(
                  score: scores.thirdGradeScore,
                  maxScore: 48,
                  label: '3학년 점수',
                  primaryColor: Theme.of(context).primaryColor,
                ),
                ScoreIndicator(
                  score: scores.generalAdmissionScore,
                  maxScore: 120,
                  label: '일반 전형 점수',
                  primaryColor: Theme.of(context).primaryColor,
                ),
                ScoreIndicator(
                  score: scores.specialAdmissionScore,
                  maxScore: 60,
                  label: '특별 전형 점수',
                  primaryColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Text('1단계 경쟁 가능 예상 교과점수는', style: subTitleTextStyle(context)),
          Text('일반전형 116점 내외, 특별전형 55점 내외입니다.',
              style: subTitleTextStyle(context)),
        ]),
      ),
    );
  }
}

class ScoreIndicator extends StatelessWidget {
  const ScoreIndicator({
    super.key,
    required this.score,
    required this.maxScore,
    required this.label,
    required this.primaryColor,
  });

  final double score;
  final double maxScore;
  final String label;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(
            value: score / maxScore,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            strokeWidth: 5,
          ),
        ),
        const SizedBox(height: 10),
        Text('${score.toStringAsFixed(2)} / ${maxScore.toStringAsFixed(2)} 점'),
      ],
    );
  }
}
