import 'package:dimigo_calculator/main_theme.dart';
import 'package:flutter/material.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  static const semesters = ['2학년 1학기', '2학년 2학기', '3학년 1학기', '3학년 2학기'];
  static const subjects = ['국어', '수학', '영어'];

  Map<String, Map<String, String>> semesterScores = {
    for (var semester in semesters)
      semester: {for (var subj in subjects) subj: ''}
  };

  final Map<String, TextEditingController> tempScoreControllers = {
    for (var subj in subjects) subj: TextEditingController()
  };

  @override
  void dispose() {
    for (var controller in tempScoreControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  bool areScoresEntered(String semester) =>
      semesterScores[semester]!.values.every((score) => score.isNotEmpty);

  bool get areAllScoresEntered => semesterScores.values
      .every((scores) => scores.values.every((score) => score.isNotEmpty));

  void _showScoreDialog(BuildContext context, String semester) {
    for (var subject in subjects) {
      tempScoreControllers[subject]!.text = semesterScores[semester]![subject]!;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(semester),
          content: SingleChildScrollView(
            child: ListBody(
              children: subjects
                  .map((subject) => Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: tempScoreControllers[subject],
                          decoration: InputDecoration(hintText: subject),
                          keyboardType: TextInputType.number,
                        ),
                      ))
                  .toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('취소'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('저장'),
              onPressed: () {
                setState(() {
                  for (var subject in subjects) {
                    semesterScores[semester]![subject] =
                        tempScoreControllers[subject]!.text;
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  int calculateAchievementScore(int score) {
    if (score >= 90) {
      return 5; // A
    } else if (score >= 80) {
      return 4; // B
    } else if (score >= 70) {
      return 3; // C
    } else if (score >= 60) {
      return 2; // D
    } else {
      return 1; // E
    }
  }

  double calculateSemesterScore(
      Map<String, String> scores, bool isSpecialSemester) {
    var totalAchievement = scores.values
        .where((score) => score.isNotEmpty)
        .map((score) => calculateAchievementScore(int.parse(score)))
        .reduce((a, b) => a + b);
    var totalRawScore = scores.values
        .where((score) => score.isNotEmpty)
        .map((score) => int.parse(score))
        .reduce((a, b) => a + b);

    var averageAchievement = totalAchievement / scores.length;
    var averageRawScore = totalRawScore / scores.length;

    if (isSpecialSemester) {
      return 4 + averageAchievement * 0.8 + averageRawScore * 0.04;
    } else {
      return 20 + averageAchievement * 1.6 + averageRawScore * 0.08;
    }
  }

  double calculateYearScores(String year) {
    var yearScore = 0.0;
    semesterScores.forEach((semester, scores) {
      if (semester.startsWith(year)) {
        var isLastSemester = semester == '3학년 2학기';
        yearScore += calculateSemesterScore(scores, isLastSemester);
      }
    });
    return yearScore;
  }

  void calculateAdmissionScores() {
    var secondGradeScore = calculateYearScores('2학년');
    var thirdGradeScore = calculateYearScores('3학년');

    var generalAdmissionScore = secondGradeScore + thirdGradeScore;
    var specialAdmissionScore = generalAdmissionScore / 2;

    var scores = AdmissionScores(
      secondGradeScore: secondGradeScore,
      thirdGradeScore: thirdGradeScore,
      generalAdmissionScore: generalAdmissionScore,
      specialAdmissionScore: specialAdmissionScore,
    );

    Navigator.pushNamed(context, '/result', arguments: scores);
  }

  Widget buildSemesterButton(BuildContext context, String semester) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            height: 50,
            child: ElevatedButton(
              onPressed: () => _showScoreDialog(context, semester),
              child: Text(semester),
            ),
          ),
          if (areScoresEntered(semester)) ...[
            const SizedBox(width: 10),
            const Icon(Icons.check_rounded, color: Colors.green, size: 40),
          ]
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('점수 입력'),
        systemOverlayStyle: systemStyle,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Container()),
            ...semesters
                .map((semester) => buildSemesterButton(context, semester))
                .toList(),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: areAllScoresEntered
                      ? () => calculateAdmissionScores()
                      : null,
                  child: const Text('점수 계산하기'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdmissionScores {
  final double secondGradeScore;
  final double thirdGradeScore;
  final double generalAdmissionScore;
  final double specialAdmissionScore;

  AdmissionScores({
    required this.secondGradeScore,
    required this.thirdGradeScore,
    required this.generalAdmissionScore,
    required this.specialAdmissionScore,
  });
}
