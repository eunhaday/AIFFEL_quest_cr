/*==================================================
* [퀘스트 1] Pomodoro Timer를 만들어보자!
*
*  1) Pomodoro timer란?
*   - 몰입훈련을 위한 타이머입니다.
*   - 25분작업, 5분 휴식을 한 회차(사이클)로 판단합니다.
*   - 단 4회차는 25분 작업, 15분 휴식을 진행합니다.
*   * hint: 시간측정은 Timer.periodic키워드로 검색
*
* 안진덕 회고: GPT의 도움으로 아니 GPT의 개인기로 코드를 작성하긴 하였으나 이걸 읽고 해석하는 능력을 무조건 길러야겠다.
* 노은하 회고: 결국 gpt의 도움을 받았지만 소스는 분석하여 이해할려고 노력했다.
*================================================== */
import 'dart:async';

//PomodoroTimer class
class PomodoroTimer {

  //변수 초기화
  final int workMinutes = 25;  //25분작업
  final int shortBreakMinutes = 5; //5분휴식
  final int longBreakMinutes = 15; //15분 휴식
  int cycleCount = 0;   //사이클횟수
  int _currentSeconds = 0; //작업시간
  Timer? _timer;
  bool _isWorkTime = true;

  //timer 시작함수
  void start() {
    print('flutter: Pomodoro 타이머를 시작합니다.');

    _startTimer(workMinutes * 60);
  }

  //매초마다 시간을 카운트다운하는 주기적 타이머
  void _startTimer(int seconds) {
    _currentSeconds = seconds;  // seconds = workMinutes * 60 (25ㅌ60=1500초)

    //지정된 기간마다 콜백 함수를 실행하는 반복 타이머를 생성 (Timer.periodic)
    //콜백을 1초마다 실행하도록 타이머를 설정 ( Duration(seconds: 1) )
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _currentSeconds--;  //1초씩 빼고
      _printTime(); //화면에 표시할 분:초계산 및 표시

      if (_currentSeconds == 0) { //25분이 다 진행되고 나면
        _switchMode(); //업무와 휴식 시간을 변경하기 위해 시간이 0이 되면 호출
      }
    });
  }

  //화면의 분:초를 표시하는 값 설정
  void _printTime() {
    int minutes = _currentSeconds ~/ 60;  //분을 정수표시 (24.98.. -> 24분)
    int seconds = _currentSeconds % 60;   //초를 나머지 값으로 표시( 1499 %60 = 59초)

    String timeDisplay =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}'; //24:59초

    print('$_currentMode: $timeDisplay');  //"Work Time" : "Break Time";
    //Work Time: 11:44로 표시

  }

  //30분이 1사이클, 1시간 : 2사이클이 된다. 2시가 되면 4회차로 이때는 휴식을 15분으로 늘린다.
  //각 작업처리후 _isWorkTime 값을 t->f, 휴식시간처리후 f ->t로 계속 값을 변경하며 timer를 호출함
  void _switchMode() {
    _timer?.cancel(); //변수 초기화(null허용)

    if (_isWorkTime) { //최초는 true임
      cycleCount++;  //사이클횟수=0에서 1로 증가
      print("작업시간이 종료되었습니다. 휴식 시간을 시작합니다.");

      if (cycleCount % 4 == 0) { //4회차이면 15분휴식
        print("4회차는 15분 휴식시간 시작!");
        _startTimer(longBreakMinutes * 60); //15분 휴식 (15 x 60초)

      } else { //1,2,3 5분휴식
        print("5분 휴식시간 시작!");
        _startTimer(shortBreakMinutes * 60); //5분휴식 (5x60초)

      }
    } else { //25분작업
      print("휴식 완료! 다시 일할 시간 입니다.");
      _startTimer(workMinutes * 60);
    }
    _isWorkTime = !_isWorkTime; //1사이클 돌고나면 _isWorkTime = false로 값을 변경
  }

  //getter함수로 _isWorkTime에 따라 Work Time, Break Time으로 나뉘어진다.
  String get _currentMode => _isWorkTime ? "flutter(Work Time)" : "flutter(Break Time)";

  void stop() {
    _timer?.cancel();
    print("타이머 종료.");
  }
}

//main함수
void main() {

  //PomodoroTimer 객체선언
  PomodoroTimer timer = PomodoroTimer();

  timer.start(); //시작함수

  // Press CTRL+C in the console to stop the program.

}