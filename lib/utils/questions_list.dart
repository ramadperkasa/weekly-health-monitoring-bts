import 'package:mock_data/mock_data.dart';

class QuestionsList {
  String title;
  DateTime expiredDate;
  //status 1 = Selesai, status 2 = expired
  int status;
  int id;

  QuestionsList({this.title, this.expiredDate, this.status, this.id});
}

List<QuestionsList> questionsList = [
  QuestionsList(
    id: 1,
    title: 'Weekly Health Monitoring Minggu 1',
    expiredDate: mockDate(DateTime(2020, 7, 26)),
    status: 1,
  ),
  QuestionsList(
    id: 2,
    title: 'Weekly Health Monitoring Minggu 2',
    expiredDate: mockDate(DateTime(2020, 7, 26)),
    status: 1,
  ),
  QuestionsList(
    id: 3,
    title: 'Weekly Health Monitoring Minggu 3',
    expiredDate: mockDate(DateTime(2020, 7, 26)),
    status: 1,
  ),
  QuestionsList(
    id: 4,
    title: 'Weekly Health Monitoring Minggu 4',
    expiredDate: mockDate(DateTime(2020, 7, 26)),
    status: 1,
  ),
  QuestionsList(
    id: 5,
    title: 'Weekly Health Monitoring Minggu 1',
    expiredDate: mockDate(DateTime(2020, 7, 26)),
    status: 1,
  ),
  QuestionsList(
    id: 6,
    title: 'Weekly Health Monitoring Minggu 2',
    expiredDate: mockDate(DateTime(2020, 7, 26)),
    status: 1,
  ),
  QuestionsList(
    id: 7,
    title: 'Weekly Health Monitoring Minggu 3',
    expiredDate: mockDate(DateTime(2020, 7, 26)),
    status: 1,
  ),
  QuestionsList(
    id: 8,
    title: 'Weekly Health Monitoring Minggu 4',
    expiredDate: mockDate(DateTime(2020, 7, 26)),
    status: 1,
  ),
  QuestionsList(
    id: 9,
    title: 'Weekly Health Monitoring Minggu 1',
    expiredDate: mockDate(DateTime(2020, 7, 26)),
    status: 1,
  ),
  QuestionsList(
    id: 10,
    title: 'Weekly Health Monitoring Minggu 2',
    expiredDate: mockDate(DateTime(2020, 7, 26)),
    status: 1,
  ),
  QuestionsList(
    id: 11,
    title: 'Weekly Health Monitoring Minggu 3',
    expiredDate: mockDate(DateTime(2020, 7, 26)),
    status: 1,
  ),
  QuestionsList(
    id: 12,
    title: 'Weekly Health Monitoring Minggu 4',
    expiredDate: mockDate(DateTime(2020, 7, 26)),
    status: 1,
  ),
  QuestionsList(
    id: 13,
    title: 'Weekly Health Monitoring Minggu 1',
    expiredDate: mockDate(DateTime(2020, 7, 26)),
    status: 1,
  ),
  QuestionsList(
    id: 14,
    title: 'Weekly Health Monitoring Minggu 2',
    expiredDate: mockDate(DateTime(2020, 7, 26)),
    status: 1,
  ),
  QuestionsList(
    id: 15,
    title: 'Weekly Health Monitoring Minggu 3',
    expiredDate: mockDate(DateTime(2020, 7, 26)),
    status: 1,
  )
];
