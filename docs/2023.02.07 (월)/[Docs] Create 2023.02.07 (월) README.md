# 🍢 마차챠

<p align="center"><img src="https://user-images.githubusercontent.com/48436020/217260600-ae7238d6-1d7b-4386-9775-65d818151cbc.png" width=30%></p>

## 오늘의 기록 (23.02.07 월)
### 🥘 오늘의 기분

- 건형: 아프다는 소식에 유감이다.. 마음이 아프다.. 굉장히 피곤 (노래방 이슈 + 게임 이슈)
- 수현: 졸립니다.. 어제 재밌고 집에 돌아오는게 힘들었다
- 정우: 피곤합니다.. 오랜만에 왔다갔다 컨디션난조, 코딩에 대한 압박감 (점심에 운동가자)
- 지연: 졸리다 사람이 많아서 기가 빨렸다.. 외국인 많다(중국인,일본인), 푸라닭 고추마요/블랙알리오 존맛탱 명동교자(칼국수 마넌.. 김치마늘 맛심함)
- 두영: 컨디션이 매우 좋지만 다리가 아프다..

### ☺️ 공유할 것
- 건형: 
  - 프로필 거의 끝냄, 중국어 다같이 번역해야함(다음주에 노가다작업)
  - 프로필쪽 알림 및 공지사항 
  - 새로운 매거진 알림
  - 내 근처 포장마차 등록 알림
  - 홈으로 추천받는것 하나?
  - 공지사항 빼고는 다른 탭으로 이동 가능 (공지사항 뷰 필요)
  - 리뷰 관리 탭 (리뷰에 대한것?을 보여줘야함)
  - 회원탈퇴/로그인/로그아웃 (우선순위 높음) - 두영작업 + 건형님작업

- 수현: 
  - 데이터 불러오는 문제 해결 (pr 참고바람)

- 정우: 
  - 고민한것 (등록시 태그필터 배열 필요 )
  - 컴바인 적용 및 updateUIView 고민 필요
- 지연:
  - 삭제할때, 댓글/신고
  - 리뷰 셀 UI 다듬기
  - StateObject → EnvironmentObject
- 두영: 
  - Alert +  SoundViewModel
  - 등록에 이미지 추가 및 이미지 다중선택 추가 필요
  - 필수에 대한 표시 필요? (떡볶잉 참조바람)
  - 베스트메뉴 에셋 다운받기
  - 등록과 제보가 애매 (제보로 가자)
  - 평점 제거 (0점으로 고정)
  - 사진추가는 사용자에게 부담이 될 수 있다 (대신 지연님이 고생)

### 💻 오늘 할 일
- 건형: 아주아주복잡귀찮 같이할.. 더미데이터 정제 (파이어스토어 이미지) 
- 정우: 검색 끝낼 예정
- 지연: 리뷰쓰기 기능
- 수현: 
- 두영: 

### 🙋 건의사항
1. 등록에서 region에 ‘동(명동, 을지로동)’으로 들어가야함 - 현재는 신주소?로 되어 있음
2. 강사님 피드백 전달(관리자, 일요일까지 pull 하심, 

### **저장 절차**
1. FoodCart의 id(가게의 고유 id) 복사 
2. 스토리지로 이동해서 images 폴더 아래 가게 id로 폴더 생성
3. 해당 폴더 아래 구글 드라이브에 있는 사진을 업로드해준다.
4. 사진의 이름(ex. IMG_2497.HEIC)을 FoodCart imageId 배열 안에 추가한다.

### 베스트 메뉴
- 붕어빵0
- 오뎅1
- 고구마2
- 떡볶이3
- 기타 (포장마차 이미지)
- 추가해야할것들
    - 음료 (버블티,석류주스) 8
    - 타꼬야끼 4
    - 호떡 5
    - 꼬치류 (탕후루,문어꼬치,닭꼬치,회오리감자,염통꼬치) 6
    - 디저트 (크로아상, 계란빵, 크로플, 크레페, 츄러스) 7 - 지연님
    - 기타 (십원빵) 9

### 베스트 이미지 넣을 때
- command + a 전체 선택
- shift 누르고 정사각형 최대한 꽉 채워주세요.
- command + k 누르면 잘림
- 1x, 2x, 3x로 이미지로 변환해서 asset에 넣어주세요
- https://www.appicon.co/#image-sets

## 데이터 다듬기 - 더미데이터 정제
FoodCart Collection 25개 데이터 수정 
- 베스트 메뉴
- 좋아요
- 평점 (grade)
- imageId
- menu
- name 조금 수정 (ex. 옆 , 뒤 앞)
- openingDays
- paymetOpt // [현금, 계좌이체, 카드]
- reportCnt (0, 1, 2)
- visitedCnt

<img width="100%" alt="image" src="https://user-images.githubusercontent.com/48436020/217272544-6ac4fcd3-a4b2-438c-bdc7-080e95b659d8.png">

### 베스트 메뉴 index 처리
- 붕어빵0
- 오뎅1
- 고구마2
- 떡볶이3
- 타꼬야끼 4
- 호떡 5
- 꼬치류 (탕후루,문어꼬치,닭꼬치,회오리감자,염통꼬치) 6
- 디저트 (크로아상, 계란빵, 크로플, 크레페, 츄러스) 7
- 음료 (버블티,석류주스) 8
- 기타 (십원빵) 9

### 베스트 이미지 넣을 때
- command + a 전체 선택
- shift 누르고 정사각형 최대한 꽉 채워주세요.
- command + k 누르면 잘림
- 1x, 2x, 3x로 이미지로 변환해서 asset에 넣어주세요

## icon 설정
|<img src="https://user-images.githubusercontent.com/48436020/217273319-ed2f70c4-071b-41e3-bcff-af9b86737aa4.png" width=30%>|<img src="https://user-images.githubusercontent.com/48436020/217273375-374064aa-6d54-4632-b20c-8d4074b619bf.png" width=30%>|<img src="https://user-images.githubusercontent.com/48436020/217273420-06ce021e-c931-4ecc-9b18-f502ec11ed8b.png" width=30%>|<img src="https://user-images.githubusercontent.com/48436020/217273505-f100a1d4-284e-4650-986b-3c0abd375617.png" width=30%>|<img src="https://user-images.githubusercontent.com/48436020/217273555-e67353ec-75d7-44d3-8003-d3d50a678d96.png" width=30%>
|:-:|:-:|:-:|:-:|:-:|






