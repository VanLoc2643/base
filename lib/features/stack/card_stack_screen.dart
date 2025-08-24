import 'package:flutter/material.dart';
import 'card_stack.dart';
import 'data_fake.dart';

class CardStackScreen extends StatefulWidget {
  const CardStackScreen({super.key});

  @override
  State<CardStackScreen> createState() => _CardStackScreenState();
}

class _CardStackScreenState extends State<CardStackScreen> {
  int currentIndex = 0;
  final PageController pageController = PageController();

  List<QuestionExamEntity> questions = [];
  List<ResultQuestionParam> listResultQuestion = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  Future<List<QuestionExamEntity>> fetchQuestionsMock() async {
    await Future.delayed(
        const Duration(milliseconds: 500)); // giả lập thời gian mạng
    return List.generate(
      5,
      (i) => QuestionExamEntity(idQuestion: i, questionText: 'Câu hỏi số $i'),
    );
  }

  Future<List<ResultQuestionParam>> fetchResultsMock() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.generate(
      5,
      (i) => ResultQuestionParam(
        questionId: i,
        listResultAnswerQuestion: [ResultQuestionEntity(answerId: i)],
      ),
    );
  }

  Future<void> _loadMockData() async {
    final q = await fetchQuestionsMock();
    final r = await fetchResultsMock();
    setState(() {
      questions = q;
      listResultQuestion = r;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Card Stack')),
      body: QuestionStack(
        questions: questions,
        currentIndex: currentIndex,
        onChangeQuestion: (index) => setState(() => currentIndex = index),
        markAnswered: (_) {},
        onResultChange: (_) {},
        pageController: pageController,
        listResultQuestion: listResultQuestion,
      ),
    );
  }
}
