// Fake DetailBodyExamWidget
import 'package:flutter/material.dart';

class QuestionExamEntity {
  final int idQuestion;
  final String questionText;
  QuestionExamEntity({required this.idQuestion, required this.questionText});
}

class ResultQuestionParam {
  final int questionId;
  final List<ResultQuestionEntity> listResultAnswerQuestion;
  ResultQuestionParam(
      {required this.questionId, required this.listResultAnswerQuestion});
}

class ResultQuestionEntity {
  final int answerId;
  ResultQuestionEntity({required this.answerId});
}

class DetailBodyExamWidget extends StatelessWidget {
  final QuestionExamEntity questionExamEntity;
  final VoidCallback onClickDone;
  final void Function(dynamic) onResultChange;
  final int intPosition;
  final bool isEndOfList;
  final PageController pageController;
  final bool disableTapToAdvance;
  final List<ResultQuestionEntity> listResultAnswerQuestion;

  const DetailBodyExamWidget({
    super.key,
    required this.questionExamEntity,
    required this.onClickDone,
    required this.onResultChange,
    required this.intPosition,
    required this.isEndOfList,
    required this.pageController,
    required this.disableTapToAdvance,
    required this.listResultAnswerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Q${questionExamEntity.idQuestion}: ${questionExamEntity.questionText}',
        style: const TextStyle(fontSize: 22),
      ),
    );
  }
}
