import 'package:flutter/material.dart';
import 'package:m_whm/constants/color.dart';
import 'package:m_whm/widgets/button_block.dart';
import 'package:m_whm/widgets/detail_information_question.dart';
import 'package:m_whm/widgets/layout.dart';

import 'package:m_whm/state/question.dart';
import 'package:provider/provider.dart';

class FormSurvey extends StatefulWidget {
  @override
  _FormSurveyState createState() => _FormSurveyState();
}

class _FormSurveyState extends State<FormSurvey> {
  double ratioHeight = 1.13;
  dynamic currentQuestion;

  @override
  initState() {
    clearQuestion();

    super.initState();
  }

  clearQuestion() {
    Provider.of<QuestionData>(context, listen: false).clearQuestions();
    Provider.of<QuestionData>(context, listen: false).clearForm(null);
  }

  @override
  Widget build(BuildContext context) {
    QuestionData providerQuestioner = Provider.of<QuestionData>(context);
    QuestionData providerQuestionerListen =
        Provider.of<QuestionData>(context, listen: false);
    currentQuestion =
        Provider.of<QuestionData>(context, listen: false).quesionerList;

    return Scaffold(
      body: Layout(
        isHome: true,
        title: Text(providerQuestioner.title),
        enabledPadding: false,
        isDrawer: false,
        ratioHeight: ratioHeight,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 18.0),
              child: Center(
                child: Text(
                  '${providerQuestioner.currentQuestions} of ${currentQuestion.length ?? 0} Questions',
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
                          currentQuestion[providerQuestioner.currentQuestions -
                                  1]['question'] ??
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
                                    groupValue:
                                        providerQuestioner.currentAnswer,
                                    onChanged: (QuestionsChoice value) {
                                      setState(() {
                                        providerQuestioner.currentAnswer =
                                            value;
                                        // providerQuestioner.setAnswer(value);
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
                                    groupValue:
                                        providerQuestioner.currentAnswer,
                                    onChanged: (QuestionsChoice value) {
                                      setState(() {
                                        providerQuestioner.currentAnswer =
                                            value;
                                        providerQuestionerListen
                                            .clearForm(null);
                                        // providerQuestioner.setAnswer(value);
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
                        showDetailInformation(
                          currentQuestion,
                          providerQuestioner,
                          providerQuestionerListen,
                        )
                      ],
                    ),
                    Column(
                      verticalDirection: VerticalDirection.up,
                      children: [
                        Container(
                          child: ButtonBlock(
                            isDisabled: providerQuestioner.currentAnswer ==
                                    QuestionsChoice.belum_di_set
                                ? true
                                : false,
                            onPress: () async {
                              setState(() {
                                if (providerQuestionerListen.next()) {
                                  providerQuestionerListen.nextQuestions();
                                } else {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      '/form/success',
                                      (Route<dynamic> route) => false);
                                  providerQuestionerListen.insertToDb();
                                  providerQuestionerListen.clearQuestions();
                                  providerQuestioner.clearForm(null);
                                }
                              });
                            },
                            text: providerQuestionerListen.next()
                                ? 'NEXT'
                                : 'FINISH',
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

  Widget showDetailInformation(
      currentQuestion, providerQuestioner, providerQuestionerListen) {
    return providerQuestioner.currentAnswer ==
            providerQuestionerListen.convertToQuestionChoice(
              currentQuestion[providerQuestioner.currentQuestions - 1]
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
                            providerQuestionerListen.addForm();
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
                      itemCount: providerQuestioner.numberForm,
                      itemBuilder: (context, index) {
                        return DetailInformationCard(
                          index: index,
                          providerQuestioner: providerQuestioner,
                          onPress: () {
                            setState(() {
                              if (providerQuestioner.numberForm > 1) {
                                providerQuestionerListen.minusNumberForm(index);
                              } else {
                                providerQuestionerListen.clearForm(index);
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
