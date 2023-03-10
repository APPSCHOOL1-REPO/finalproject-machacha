# 🍢 마차챠

<p align="center"><img src="https://user-images.githubusercontent.com/48436020/213593176-f76b18e1-246d-4d99-8061-095c5e550aad.png" width=30%></p>

## 오늘의 기록 (23.01.19 목)

## 공유할것

- 건형: 문서 정리, 팀원 코드 review, 세미나 준비(Firebase + Combine + Swift, Error Handling)
- 수현: 지현님과 함께 Image + splash 완성
- 정우: 네이버 MAP 연결, 위치권한, 이미지 클러스터링(네이버에서 제공되지 않아, 좋은 라이브러리 를 찾음)
- 지연: 수현님과 Splash, ‘기획’도 중요
- 두영: 로그인만 되는 기능(NAVER.com 로그인은 실패), auth 처리, Git branch issue

## 🌀 우리의 기획/디자인 어디로 가고 있는가?
### 1. 위치의 중복(같은 가게)

- (○) 관리(추합후 매주 목요일 발표)
- (○) 등록할때, 위치를 넣는데 지도에서 ‘혹시 등록하려는 포장마차가 여기가 아닐까요?’ → 폭을 넓게
- (○) 알림 기능(최초 등록자에게 알림)
- (X) 방생(사용자가 하고 싶은데로) → 신고 제거
- (X) 1. 구글 맵, 사용자의 커뮤니티 성을 사용자에게 요청받을 수 있음
- (X) 2. 신고기능 (게임, 재미, 뱃지 주기, 등급 업), 사용자에게 수치정보로 피드백해준다(신뢰도를 올린다)
- (△) 3. 보상에 대한 설계(Gamification)

### (○)임시 구현 방법
ViewModel → Create
1. Collection (관리자)
2. Collection (Detail)

### 2. 포장마차의 특성상 사라질 경우
1. 신고하기 기능
2. 지연님의 Detail : Map (누적신고수), 사용자에게 100% 믿지 말라는걸 표시하는거죠, Map에서 표시
3. 신고누적수 보여주기 ↔ 방문 누적수(가봤어요)

### 3. 굳이 이 앱을 써야하는 이유
1. `포장마차 관련 정보들(위치, 결제 수단, 기록 등)을 알려주기 위한 사용자 니즈를 파악하고 앱으로 구현하고자 한다.`
2. 포장마차 거리 활성화 장려
3. 숨은 달인 찾기
4. 불법노점상 검거 → OK
5. 꾸준히 사용되는 앱이 아닐수 있지만, 사용자의 니즈가 분명히 있기 때문에

### 4. (완) 피드백때, 포장마차 밀집되어 있을때, 어떻게 표현될 것인가?
→ Pin을 숫자 보여주고 ‘이미지 클러스터링’ 
→ 기준은 구현된 이후에 다시 토의
→ 정우님이 원하시는 라이브러리 (naver, google, apple)

## 📄 피드백 분석
### ✅ MSG(두영, 정우)
1. MSG팀의 목표 중 애플 로그인이 있음
2. MSG: Firebase Auth로 로그인 연동 및 Combine 적용이 있음
3. MSG: Kakao(EnvironmentObject kakaoVM 존재)연동 되어 있는듯함
4. MSG: kakaoVM에 import FirebaseStorageCombineSwift??
5. 알림: RealTime

### ✅ Check It!(지연, 수현) 
1. Check It!의 연구과제에 MapKit 정확도 올리기가 있음
    1. 반경 범위를 설정 (지금은 어림잡아 설정하셨다고 함)
    2. 네이버 지도를 쓰고 싶었지만 
    3. 저희 출시예정이라 네이버가 비싸서 ㅠ, 카카오 맵은 obj-c 써야해서 포기..
2. Check it: QRSheetView.swift의 import CoreImage.CIFilterBuiltins가 되어있음
    1. QR 만드는데 필요하다고 함
    2. 패키지 추가는 안했던 것 같음 (임포트만 해주면 사용 가능)
3. Check it: ViewModel이 아직 없음
4. 뷰는 아직 다 목업인듯..(더미 데이터)
- 여기 캘린더 직접 다 만드셨다고 함 (자랑)

## 🙋 건의사항
