import 'dart:io';

///
/// Dart语言概述
///


/// main函数作为程序主入口
void main() {
  print('Hello World');
}

/// 变量, 支持类型推断
var name = 'WokeBryant';  // String
var year = 1747;    // int
var pi = 3.1415926; // double
var colorList = ['yellow', 'blue', 'red'];  // array, dart中list和array是一样的
var fruitSet = {'orange', 'apple', 'banana'};   // Set
var userMap = {
  'mike': ['name', 'age'],
  'url': 'www.baidu.com'
};    // Map

/// 流程控制
void processControl() {
  if (year >= 2001) {
    print('21st century');
  } else if (year >= 1901) {
    print('20th century');
  }

  for (final color in colorList) {
    print(color);
  }

  for (int month = 1; month <= 12; month++) {
    print(month);
  }

  while (year < 2016) {
    year += 1;
  }
}

/// 函数
int studyDartDays() {
  return 0;
}

// 胖箭头为简写语法, 仅用于包含一条语句的函数
int studyFlutterDays() => 0;

/// 类
class DartClass {
  String name;
  DateTime? dateTime;

  // getter方法
  int? get currentYear => dateTime?.year;

  // 构造器
  DartClass(this.name, this.dateTime) {
    // 初始化
  }

  DartClass.oneParams(String name) : this(name, null);
  DartClass.emptyParams() : this('wokebryant', null);


  void letStudy() {
  }

}

// 使用类
var dartClassEmpty = DartClass.emptyParams();
var dartClassOne = DartClass.oneParams('wokebryant');
var dartClass = DartClass('wokebryant', null);


/// 扩展类(继承)
class FlutterClass extends DartClass with Piloted {

  FlutterClass(String name, DateTime? dateTime)
      : super(name, dateTime);

  void letStudyFlutter() {
    describeCrew();
    letStudy();
  }

}

/// Mixins, 一种在多个类层次结构中重用代码的方法
mixin Piloted {
  var astronauts = 1;

  void describeCrew() {
    print('Number of astronauts: $astronauts');
  }
}

/// 接口和抽象类
/// Dart没有[interface]关键字。相反, 所有类都隐式定义了一个接口。因此，任何类都可以作为接口被实现
abstract class Describable {
  void describe();

  void describeWithEmphasis() {
    print('=========');
    describe();
    print('=========');
  }

}

// 抽象类实现
class ImplDescribable extends Describable {
  @override
  void describe() {
    print("im ImplDescribable");
  }

  void letDo () {
    describeWithEmphasis();
  }

}

/// 异步, 使用[async]和[await]关键字
const oneSecond = Duration(seconds: 1);

Future<void> printWithDelay(String message) async {
  await Future.delayed(oneSecond).then((value) => print(message));
}

Future<void> createDescriptions(Iterable<String> objects) async {
  for (final object in objects) {
    try {
      var file = File('$object.txt');
      if (await file.exists()) {
        var modified = await file.lastModified();
        print('File for $object already exists. It was modified on $modified.');
        continue;
      }
      await file.create();
      await file.writeAsString('Start describing $object in this file.');
    } on IOException catch (e) {
      print('Cannot create description for $object: $e');
    }
  }
}

/// 异常

// 使用[throw]关键字抛出异常
void useThrowException() {
  var state = 0;
  if (state == 0) {
    throw "state error";
  }
}

// 使用try on catch
void useTryCatch () {
  try {

  } on IOException catch (e) {
    print(e);
  } finally {
    print('finally');
  }
}

/// Const和final
const map = {
  "": "",

};