import 'package:flutter/material.dart';
import 'package:m_whm/components/button_block.dart';
import 'package:m_whm/components/detail_information_question.dart';
import 'package:m_whm/components/layout.dart';
import 'package:m_whm/const/color.dart';
import 'package:m_whm/model/questions.dart';

class FormSurvey extends StatefulWidget {
  FormSurvey({this.questionList});
  final questionList;
  @override
  _FormSurveyState createState() => _FormSurveyState(questionList);
}

class _FormSurveyState extends State<FormSurvey> {
  _FormSurveyState(questionList) {
    currentQuestion = questionList['questions'];
  }
  double ratioHeight = 1.13;
  Questions questions = Questions();

  dynamic currentQuestion;

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dynamic currentQuestionModel = questions.getCurrentQuestions();
    return Scaffold(
      body: Layout(
        title: Text('Weekly Health Monitoring'),
        enabledPadding: false,
        isDrawer: false,
        ratioHeight: ratioHeight,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 18.0),
              child: Center(
                child: Text(
                  '$currentQuestionModel of ${currentQuestion.length ?? 0} Questions',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFF3F3F3),
              ),
              height: 10.0,
              width: MediaQuery.of(context).size.width * 0.9,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Text(
                          currentQuestion[currentQuestionModel - 1]
                                  ['question'] ??
                              'Error Fetch Questions',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 18.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 30.0,
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Radio<QuestionsChoice>(
                                    activeColor: BaseColors.primary,
                                    value: QuestionsChoice.ya,
                                    groupValue: questions.getCurrentAnswer(),
                                    onChanged: (QuestionsChoice value) {
                                      setState(() {
                                        questions.setAnswer(value);
                                      });
                                    },
                                  ),
                                  Text(
                                    'Ya',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Radio<QuestionsChoice>(
                                    activeColor: BaseColors.primary,
                                    value: QuestionsChoice.tidak,
                                    groupValue: questions.getCurrentAnswer(),
                                    onChanged: (QuestionsChoice value) {
                                      setState(() {
                                        questions.setAnswer(value);
                                      });
                                    },
                                  ),
                                  Text(
                                    'Tidak',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        showDetailInformation()
                      ],
                    ),
                    Column(
                      verticalDirection: VerticalDirection.up,
                      children: [
                        Container(
                          child: ButtonBlock(
                            isDisabled: questions.getCurrentAnswer() ==
                                    QuestionsChoice.belum_di_set
                                ? true
                                : false,
                            onPress: () {
                              setState(() {
                                if (!questions.isLast(
                                  currentQuestion ?? null,
                                )) {
                                  questions.nextQuestions();
                                } else {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      '/form-success',
                                      (Route<dynamic> route) => false);
                                  questions.clearQuestions();
                                }
                              });
                            },
                            text: 'NEXT',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget showDetailInformation() {
    return questions.getCurrentAnswer() ==
            questions.convertToQuestionChoice(
              currentQuestion[questions.getCurrentQuestions() - 1]
                  ['show_detail_when'],
            )
        ? Column(
            children: [
              Center(
                child: Divider(
                  color: Color(0xFFF4F4F4),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Detail Information',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            questions.numberForm++;
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              'Add Form',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Image.asset(
                              'assets/icons/Group.png',
                              height: 18,
                              width: 18,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: questions.numberForm,
                      itemBuilder: (context, index) {
                        return DetailInformationCard(
                          onPress: () {
                            setState(() {
                              if (questions.numberForm > 1) {
                                questions.numberForm--;
                              }
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          )
        : Container();
  }
}
