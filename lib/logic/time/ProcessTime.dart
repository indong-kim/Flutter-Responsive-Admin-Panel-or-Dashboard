import '../DataStructure/DTime.dart';
import '../interface/ITimeKeeper.dart';
import '../interface/ITimeSlave.dart';

class ProcessTime implements ITimeKeeper {
  static final ProcessTime _instance = ProcessTime._privateConstructor();

  factory ProcessTime() {
    return _instance;
  }

  List<ITimeSlave> timeSlaveList;

  int _day;
  int _month;
  int _year;

  final lastDay = <int>[31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  ProcessTime._privateConstructor() {
    this._day = 25;
    this._month = 5;
    this._year = 2022;
  }

  void Process() {
    _day++;
    if (_day > lastDay[_month - 1]) {
      _day = 1;
      _month++;
      if (_month > 12) {
        _month = 1;
        _year++;
        if (_year % 4 == 0) {
          lastDay[1] = 29; //leap year
        } else {
          lastDay[1] = 28;
        }
      }
    }

    updateTime();
  }

  DTime getToday() {
    return new DTime(_year, _month, _day);
  }

  @override
  void addTimeSlave(ITimeSlave newslave) {
    timeSlaveList.add(newslave);
  }

  @override
  void updateTime() {
    DTime newTime = new DTime(_year, _month, _day);
    for (int i = 0; i < timeSlaveList.length; i++) {
      ITimeSlave slave = timeSlaveList[i];
      slave.dayChange(newTime);
    }
  }
}
