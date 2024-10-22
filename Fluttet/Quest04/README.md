# 쿠팡 앱 분석 및 역설계 하기        

## 앱 정보

- **앱 이름** 

  - 쿠팡앱   

- **시장(마켓)**  

  - 대한민국 국민이라면 한번쯤은 이용해봤을 만한 모바일 쇼핑앱으로, 다양한 상품, 저렴한 가격, 당일 배송까지, 
    핫한 상술을 보여주고 있는 편리한 쿠팡앱의 구조를 살펴보고 해당 화면구조를 이용하되(하단탭구조 이용)
    추가로 월사용액을 추가구성하여 구현해봄

- **타겟**  

  - 장보러 가기 힘들거나 시간이 애매한 경우에도 쇼핑이 가능하고 다음날 받아보기 원하는 장본인들의 한달소비 금액을 같이 보여주기

- **아이콘은 무료다운로드후 이용**   
  - 출처 : <a href="https://www.flaticon.com/kr/free-icons/" title="금액 아이콘">금액 아이콘 제작자: Vectors Tank - Flaticon</a>
  

## 앱 구조도
![image](https://github.com/user-attachments/assets/0feb8b2b-a3e9-4453-b9fe-d6f850622cdb)


## 앱 와이어프레임 (사용 툴 : 파워포인터)
![Wireframe_1](https://github.com/user-attachments/assets/47bc0df2-3110-4c12-913b-081c0f7374be)
![Wireframe_2](https://github.com/user-attachments/assets/0b59cb88-ed80-49e4-ac22-853a224fa559)

## 프로토타이핑 (사용 툴 : marvelapp)
![image](https://github.com/user-attachments/assets/f31daa2a-c89d-453d-8976-a7e1e02dbfb2)


## 페이지 구현
1. main.dart - 메인 화면으로 기본적인 구성으로만 작성 되어 있습니다.
2. loading.dart - 로딩페이지
3. mypage.dart - 나의페이지
4. my_location.dart - 위치정보를 포함한 런닝 기록
5. run_test.dart - 런냥이 테스트 페이지


## 구현영상 
https://github.com/eunhaday/AIFFEL_quest_cr/blob/master/Fluttet/Quest04/test%20%E2%80%93%20main_scr.jpg%20-%20Chrome%202024-10-22%2018-02-08.mp4


## 참고 학습 자료 


## 회고
쿠팡앱의 모바일앱 화면을 캡쳐후, 대략의 앱구조도를 그리고 앱와이어 프레임을 배치하고 수정, 보완하는 과정을 종이에 그리고
그림의 화면에 올리고 실제 프로토타입은 마블앱으로 구현해보고 그기능을 dart언어로 다시 구현하는 작업을 해봤다.

