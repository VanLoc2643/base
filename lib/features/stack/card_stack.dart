import 'package:app_demo/core/theme/app_color.dart';
import 'package:app_demo/features/stack/data_fake.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionStack extends StatefulWidget {
  const QuestionStack({
    super.key,
    required this.questions,
    required this.currentIndex,
    required this.onChangeQuestion,
    required this.markAnswered,
    required this.onResultChange,
    required this.pageController,
    this.showSummaryAtLast = true,
    this.maxAheadCards = 3,
    this.swipeThreshold = 800.0,
    this.swipeOutDistance = -400.0,
    this.swipeRightDistance = 400.0,
    required this.listResultQuestion,
  });

  final List<QuestionExamEntity> questions;
  final int currentIndex;
  final void Function(int index) onChangeQuestion;
  final void Function(int index) markAnswered;
  final void Function(dynamic resultParam) onResultChange;
  final PageController pageController;
  final bool showSummaryAtLast;
  final int maxAheadCards;
  final double swipeThreshold;
  final double swipeOutDistance;
  final double swipeRightDistance;
  final List<ResultQuestionParam> listResultQuestion;
  @override
  State<QuestionStack> createState() => _QuestionStackState();
}

class _QuestionStackState extends State<QuestionStack>
    with TickerProviderStateMixin {
  double dx = 0.0;
  double _rotation = 0.0;
  double _opacity = 1.0;
  double _scale = 1.0;

  double _nextCardBottom = 0.0;
  double _nextCardLeft = 0.0;
  double _nextCardScale = 1.0;
  Color _nextCardColor = AppColors.light1;

  bool isAnimatingOut = false;
  bool isSwipingRight = false;
  bool isTransitioningCards = false;
  bool isPanning = false;
  int nextCardIndex = -1;

  late AnimationController _swipeOutController;
  late AnimationController _nextCardController;

  Animation<double>? _swipeAnimation;
  Animation<double>? _rotationAnimation;
  Animation<double>? _opacityAnimation;
  Animation<double>? _scaleAnimation;

  late Animation<double> _nextCardBottomAnimation;
  late Animation<double> _nextCardLeftAnimation;
  late Animation<double> _nextCardScaleAnimation;
  Animation<Color?>? _nextCardColorAnimation;

  static const _kSwipeOutDuration = Duration(milliseconds: 200);
  static const _kNextCardDuration = Duration(milliseconds: 350);

  static const double _kBottomStep = 16.0;
  static const double _kLeftStep = 13.0;
  static const double _kScaleStep = 0.02;
  static const double _kMinScale = 0.85;

  static const List<Color> _backgroundColors = [
    AppColors.light1,
    AppColors.primary5,
    AppColors.primary6,
    AppColors.light1,
  ];

  Color _getCardColor(int cardIndex) {
    if (cardIndex >= _backgroundColors.length) {
      return _backgroundColors.last;
    }
    return _backgroundColors[cardIndex];
  }

  Color _getCardBackgroundColor(int cardIndex) {
    if (isPanning && cardIndex == 1) {
      return AppColors.light1;
    }
    return _getCardColor(cardIndex);
  }

  @override
  void initState() {
    super.initState();
    debugPrint('[QS] init currentIndex=${widget.currentIndex}');
    _swipeOutController =
        AnimationController(vsync: this, duration: _kSwipeOutDuration);
    _nextCardController =
        AnimationController(vsync: this, duration: _kNextCardDuration);

    _swipeOutController.addListener(() {
      if (_swipeAnimation != null) {
        setState(() {
          dx = _swipeAnimation!.value;
          _rotation = isSwipingRight
              ? _rotationAnimation!.value
              : -_rotationAnimation!.value;
          _opacity = _opacityAnimation!.value;
          _scale = _scaleAnimation!.value;
        });
      }
    });

    _swipeOutController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final nextIdx = widget.currentIndex + 1;
        if (nextIdx < widget.questions.length) {
          if (isTransitioningCards) {
            _swipeOutController.reset();
            setState(() {
              dx = 0;
              _rotation = 0;
              _opacity = 1.0;
              _scale = 1.0;
              isAnimatingOut = false;
              isSwipingRight = false;
              isPanning = false;
              return;
            });
          }

          setState(() {
            isTransitioningCards = true;
            isPanning = false;
            nextCardIndex = nextIdx;

            _nextCardColor = AppColors.light1;
            _nextCardColorAnimation = null;

            _nextCardBottomAnimation = Tween<double>(
              begin: _kBottomStep,
              end: 0.0,
            ).animate(
              CurvedAnimation(
                  parent: _nextCardController, curve: Curves.easeOutQuad),
            );

            _nextCardLeftAnimation = Tween<double>(
              begin: _kLeftStep,
              end: 0.0,
            ).animate(
              CurvedAnimation(
                  parent: _nextCardController, curve: Curves.easeOutQuad),
            );

            _nextCardScaleAnimation = Tween<double>(
              begin: 1.0 - _kScaleStep,
              end: 1.0,
            ).animate(
              CurvedAnimation(
                  parent: _nextCardController, curve: Curves.easeOutQuad),
            );
          });

          _nextCardController.forward(from: 0.0);
        } else {
          _swipeOutController.reset();
          setState(() {
            dx = 0;
            _rotation = 0;
            _opacity = 1.0;
            _scale = 1.0;
            isAnimatingOut = false;
            isSwipingRight = false;
            isPanning = false;
          });
        }
      }
    });

    _nextCardController.addListener(() {
      setState(() {
        _nextCardBottom = _nextCardBottomAnimation.value;
        _nextCardLeft = _nextCardLeftAnimation.value;
        _nextCardScale = _nextCardScaleAnimation.value;
      });
    });

    _nextCardController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.microtask(() {
          if (nextCardIndex >= 0 && nextCardIndex < widget.questions.length) {
            widget.onChangeQuestion(nextCardIndex);
          }

          _nextCardController.reset();
          _swipeOutController.reset();

          if (mounted) {
            setState(() {
              dx = 0;
              _rotation = 0;
              _opacity = 1.0;
              _scale = 1.0;
              isAnimatingOut = false;
              isSwipingRight = false;
              isTransitioningCards = false;
              isPanning = false;
              nextCardIndex = -1;
              _nextCardColor = AppColors.light1;
            });
          }
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant QuestionStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _swipeOutController.stop();
      _nextCardController.stop();

      setState(() {
        dx = 0;
        _rotation = 0;
        _opacity = 1.0;
        _scale = 1.0;
        isAnimatingOut = false;
        isSwipingRight = false;
        isTransitioningCards = false;
        isPanning = false;
        nextCardIndex = -1;
        _nextCardColor = AppColors.light1;
      });
    }
  }

  @override
  void dispose() {
    _swipeOutController.dispose();
    _nextCardController.dispose();
    super.dispose();
  }

  void _cancelCurrentAnimationsAndGoNext() {
    if (isAnimatingOut || isTransitioningCards) {
      _swipeOutController.stop();
      _nextCardController.stop();

      final nextIdx = widget.currentIndex + 1;
      if (nextIdx < widget.questions.length) {
        widget.onChangeQuestion(nextIdx);
      }

      setState(() {
        dx = 0;
        _rotation = 0;
        _opacity = 1.0;
        _scale = 1.0;
        isAnimatingOut = false;
        isSwipingRight = false;
        isTransitioningCards = false;
        isPanning = false;
        nextCardIndex = -1;
      });
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (isTransitioningCards) {
      _cancelCurrentAnimationsAndGoNext();
    }

    if (isAnimatingOut) return;

    if (!isPanning) {
      setState(() {
        isPanning = true;
      });
    }

    setState(() {
      dx += details.delta.dx;
      _rotation = (dx / 1000).clamp(-0.2, 0.2);
      _opacity = (1.0 - (dx.abs() / 1000)).clamp(0.7, 1.0);
      _scale = (1.0 - (dx.abs() / 2000)).clamp(0.95, 1.0);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (isTransitioningCards) {
      _cancelCurrentAnimationsAndGoNext();
      return;
    }

    if (isAnimatingOut) return;

    final velocity = details.velocity.pixelsPerSecond.dx;
    final isQuickSwipe = velocity.abs() > 900;
    final threshold = widget.swipeThreshold.abs();

    if (dx.abs() >= threshold || (isQuickSwipe && dx.abs() > 40)) {
      isAnimatingOut = true;
      isSwipingRight = isQuickSwipe ? velocity > 0 : dx > 0;

      final targetX =
          isSwipingRight ? widget.swipeRightDistance : widget.swipeOutDistance;

      _swipeAnimation = Tween<double>(
        begin: dx,
        end: targetX,
      ).animate(
        CurvedAnimation(parent: _swipeOutController, curve: Curves.easeOutQuad),
      );

      _rotationAnimation = Tween<double>(
        begin: _rotation.abs(),
        end: 0.3,
      ).animate(
        CurvedAnimation(parent: _swipeOutController, curve: Curves.easeOutQuad),
      );

      _opacityAnimation = Tween<double>(
        begin: _opacity,
        end: 0.7,
      ).animate(
        CurvedAnimation(parent: _swipeOutController, curve: Curves.easeOutQuad),
      );

      _scaleAnimation = Tween<double>(
        begin: _scale,
        end: 0.95,
      ).animate(
        CurvedAnimation(parent: _swipeOutController, curve: Curves.easeOutQuad),
      );

      _swipeOutController.reset();
      _swipeOutController.forward();
    } else {
      setState(() {
        dx = 0;
        _rotation = 0;
        _opacity = 1.0;
        _scale = 1.0;
        isPanning = false;
      });
    }
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

  @override
  Widget build(BuildContext context) {
    final lastQuestionIndex = widget.questions.length - 1;
    final isLastIndex = widget.currentIndex == lastQuestionIndex;

    if (isLastIndex) {
      // Hiển thị thông báo khi hết câu hỏi
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Đã hết câu hỏi!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Quay lại'),
            ),
          ],
        ),
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        ...widget.questions
            .asMap()
            .entries
            .map((entry) {
              final index = entry.key;
              final question = entry.value;
              final currentIndex = widget.currentIndex;

              if (index < currentIndex ||
                  index >= lastQuestionIndex ||
                  index > currentIndex + widget.maxAheadCards) {
                return const SizedBox.shrink();
              }
              final cardIndex = index - currentIndex;

              if (cardIndex == 0) {
                final isEndOfList = index == lastQuestionIndex - 1;

                final selectedAnswerParam =
                    widget.listResultQuestion.firstWhere(
                  (result) => result.questionId == question.idQuestion,
                  orElse: () => ResultQuestionParam(
                      questionId: -1, listResultAnswerQuestion: []),
                );

                return Positioned(
                  left: dx,
                  bottom: 0,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onPanUpdate: _onPanUpdate,
                    onPanEnd: _onPanEnd,
                    child: Opacity(
                      opacity: _opacity,
                      child: Transform.scale(
                        scale: _scale,
                        child: Transform.rotate(
                          angle: _rotation,
                          child: _QuestionCard(
                            question: question,
                            index: index,
                            isEndOfList: isEndOfList,
                            intPosition: index + 1,
                            backgroundColor: AppColors.light1,
                            pageController: widget.pageController,
                            listResultAnswerQuestion:
                                selectedAnswerParam.listResultAnswerQuestion,
                            onDone: () {
                              if (isEndOfList && widget.showSummaryAtLast) {
                                widget.onChangeQuestion(lastQuestionIndex);
                                return;
                              }
                              if (!isAnimatingOut && !isTransitioningCards) {
                                isAnimatingOut = true;
                                isSwipingRight = false;

                                _swipeAnimation = Tween<double>(
                                  begin: 0,
                                  end: widget.swipeOutDistance,
                                ).animate(
                                  CurvedAnimation(
                                      parent: _swipeOutController,
                                      curve: Curves.easeOutQuad),
                                );

                                _rotationAnimation = Tween<double>(
                                  begin: 0.0,
                                  end: 0.3,
                                ).animate(
                                  CurvedAnimation(
                                      parent: _swipeOutController,
                                      curve: Curves.easeOutQuad),
                                );

                                _opacityAnimation = Tween<double>(
                                  begin: 1.0,
                                  end: 0.7,
                                ).animate(
                                  CurvedAnimation(
                                      parent: _swipeOutController,
                                      curve: Curves.easeOutQuad),
                                );

                                _scaleAnimation = Tween<double>(
                                  begin: 1.0,
                                  end: 0.95,
                                ).animate(
                                  CurvedAnimation(
                                      parent: _swipeOutController,
                                      curve: Curves.easeOutQuad),
                                );

                                _swipeOutController.reset();
                                _swipeOutController.forward();
                              }
                            },
                            onResultChange: (param) {
                              widget.markAnswered(index);
                              widget.onResultChange(param);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }

              if (cardIndex == 1 && isTransitioningCards) {
                final selectedAnswerParam =
                    widget.listResultQuestion.firstWhere(
                  (result) => result.questionId == question.idQuestion,
                  orElse: () => ResultQuestionParam(
                      questionId: -1, listResultAnswerQuestion: []),
                );

                return Positioned(
                  bottom: _nextCardBottom,
                  left: _nextCardLeft,
                  child: Transform.scale(
                    scale: _nextCardScale,
                    child: _QuestionCard(
                      question: question,
                      index: index,
                      isEndOfList: index == lastQuestionIndex - 1,
                      intPosition: index + 1,
                      pageController: widget.pageController,
                      backgroundColor: AppColors.light1,
                      listResultAnswerQuestion:
                          selectedAnswerParam.listResultAnswerQuestion,
                      onDone: () {},
                      onResultChange: (_) {},
                    ),
                  ),
                );
              }

              if (!isTransitioningCards || cardIndex > 1) {
                final adjustedCardIndex =
                    isTransitioningCards ? cardIndex - 1 : cardIndex;
                final bottomOffset = adjustedCardIndex * _kBottomStep;
                final leftOffset = adjustedCardIndex * _kLeftStep;
                final scale = (1 - adjustedCardIndex * _kScaleStep)
                    .clamp(_kMinScale, 1.0);

                final selectedAnswerParam =
                    widget.listResultQuestion.firstWhere(
                  (result) => result.questionId == question.idQuestion,
                  orElse: () => ResultQuestionParam(
                      questionId: -1, listResultAnswerQuestion: []),
                );

                return Positioned(
                  bottom: bottomOffset,
                  left: leftOffset,
                  child: Transform.scale(
                    scale: scale,
                    child: _QuestionCard(
                      question: question,
                      index: index,
                      isEndOfList: false,
                      intPosition: index + 1,
                      pageController: widget.pageController,
                      backgroundColor: _getCardBackgroundColor(cardIndex),
                      onDone: () {},
                      listResultAnswerQuestion:
                          selectedAnswerParam.listResultAnswerQuestion,
                      onResultChange: (_) {},
                    ),
                  ),
                );
              }

              return const SizedBox.shrink();
            })
            .toList()
            .reversed
            .toList(),
      ],
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.question,
    required this.index,
    required this.isEndOfList,
    required this.intPosition,
    required this.pageController,
    required this.onDone,
    required this.onResultChange,
    this.backgroundColor = AppColors.light1,
    this.listResultAnswerQuestion = const [],
  });

  final QuestionExamEntity question;
  final int index;
  final bool isEndOfList;
  final int intPosition;
  final PageController pageController;
  final VoidCallback onDone;
  final void Function(dynamic) onResultChange;
  final Color backgroundColor;
  final List<ResultQuestionEntity> listResultAnswerQuestion;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cardWidth = screenWidth * 0.80;
    final cardHeight = screenHeight * 0.80;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20.0),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.dark3.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 10,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: DetailBodyExamWidget(
              questionExamEntity: question,
              onClickDone: onDone,
              onResultChange: onResultChange,
              intPosition: intPosition,
              isEndOfList: isEndOfList,
              pageController: pageController,
              disableTapToAdvance: true,
              listResultAnswerQuestion: listResultAnswerQuestion),
        ),
      ),
    );
  }
}
