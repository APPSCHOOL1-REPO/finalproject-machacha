# ๐ข ๋ง์ฐจ์ฑ 

<p align="center"><img src="https://user-images.githubusercontent.com/48436020/214490359-37a07b11-51cb-4045-b7e3-1ca9c141b07d.jpeg" width=30%></p>

## ์ค๋์ ๊ธฐ๋ก (23.01.20 ๊ธ)

## 1. DB ๊ตฌ์กฐ
<details>
<summary>FoodCart</summary>
<div markdown="5">
    
```swift
struct FoodCart {
    let id: String
    let createdAt: Timestamp    // ๊ฐ๊ฒ๊ฐ ๋ฑ๋ก๋ ์๊ฐ
    let updatedAt: Timestamp    // ๊ฐ๊ฒ์ ์ ๋ณด๊ฐ ์๋ฐ์ดํธ๋ ์๊ฐ
    let geoPoint: GeoPoint      // ๊ฐ๊ฒ์ ์ค์  ์ขํ
    let region: String          // ๋๊ธฐ์ค ex) ๋ช๋, ์์ง๋ก๋
    let name: String            // ์ฌ์ฉ์๊ฐ ๋ฑ๋กํ  ํฌ์ฅ๋ง์ฐจ์ ์ด๋ฆ
    let address: String         // ํฌ์ฅ๋ง์ฐจ์ ์ค์  ์์น
    let visitedCnt: Int         // ๊ฐ๊ฒ๋ฅผ ๋ฐฉ๋ฌธํ ์ด ์ ์  ์
    let favoriteCnt: Int        // ๊ฐ๊ฒ๋ฅผ ์ฆ๊ฒจ์ฐพ๊ธฐ๋ก ๋ฑ๋กํ ์ ์  ์
    let paymentOpt: [String]    // [์นด๋, ํ๊ธ, ๊ณ์ข์ด์ฒด]
    let openingDays: [Bool]     // [์, ํ, ์, ๋ชฉ, ๊ธ, ํ , ์ผ] ์คํํ ๋ ์ true๋ก ๋ฐ๊ฟ์ค
    let menu: [String: Int]     // ๋ฉ๋ด Ex(๋ถ์ด๋นต: 3000)
    let bestMenu: Int           // ์์ด์ฝ์ ์ํ ๋ณ์
    let imageId: [String]       // storage image
    let grade: Double           // ๊ฐ๊ฒ์ ํ์ 
    let reportCnt: Int          // ๊ฐ๊ฒ๊ฐ ์ ๊ณ ๋ ํ์
    let reviewId: [String]      // ๊ฐ๊ฒ์ ๋ํ ๋ฆฌ๋ทฐ ์ ๋ณด
}
```
  
</div>
</details>
<details>
<summary>Review</summary>
<div markdown="5">
    
```swift
struct Review {
    let id: String
    let foodCartId: String          // foodCart id
    let grade: Double               // ๋ฆฌ๋ทฐ์ ํ์ 
    let description: String         // ์ฌ์ฉ์ ํ๊ธฐ
    let reviewer: String            // ๋ฆฌ๋ทฐ์ด ์ฌ๋์ userID
    let createdAt: Timestamp
    let upadtedAt: Timestamp
    let imageId: [String]           // ์ฌ์ฉ์๊ฐ review ์ฌ๋ฆฐ ์ฌ์ง๋ค
}
```
  
</div>
</details>
<details>
<summary>User</summary>
<div markdown="5">
    
```swift
struct User {
    let id: String
    let createdAt: Timestamp
    let updatedAt: Timestamp
    let email: String
    let name: String            // ์ฌ์ฉ์๊ฐ ํ์๊ฐ์ ์ ๋ฑ๋กํ ์ด๋ฆ
    let favoriteId: [String]    // ์ฆ๊ฒจ์ฐพ๊ธฐํ foodCart id
    let visitedId: [String]     // ๋ด๊ฐ ๊ฐ๋ณธ foodCart id
    let profileId: String       // ์ ์ ์ ํ๋กํ ์ฌ์ง
    let isFirstLogin: Bool      // ์ต์ด ๋ก๊ทธ์ธ ์ฌ๋ถ
}
```
  
</div>
</details>
<details>
<summary>Magazine</summary>
<div markdown="5">
    
```swift
struct Magazine {
    let id: String
    let createdAt: Timestamp
    let updatedAt: Timestamp
    let foodCartId: [String]        // foodCart๋ค์ id
    let description: String         // ๋งค๊ฑฐ์ง์ ์ค๋ช
    let pickTitle: String           // ~~~'s PICK
    let title: String               // Main Title
    let subTitle: String            // SubTitle
    let comment: String             // ํ๋ ์ดํฐ์ ํ๋ง๋
		let thumbnail: String           // ๋งค๊ฑฐ์ง์ Main Image, storageId
}
```
  
</div>
</details>

## 2. ์ง๋ ๋ผ์ด๋ธ๋ฌ๋ฆฌ ์ ํ๊ธฐ
: Naver Map (๊ธฐ๋ฅ์ ์ธ ์ธก๋ฉด์์๋ ์ฒ์๋ถํฐ ๊ฐ๋ฐํด์ผํ์ง๋ง, ํ๊ตญ์ธ๋ค์๊ฒ๋ ์ต์ํ UI)

## 3. ์ธ๋ฏธ๋ ์ฃผ์  ์ ํ๊ธฐ (23.01.02 (๋ชฉ))
1. ๊ฑดํ : UniTest, TDD, UITest, A/B Test
2. ์ํ : Image Cashe(feat. stroage)
3. ์ ์ฐ : Tuist ๋ชจ๋ํ
4. ์ง์ฐ : Concurrency
5. ๋์ : login token(access, refresh), oauth, Jwt

## 4. ์ ์ฒด ์คํ๋ฆฐํธ
### ์ ์ฒด ๋ชฉํ
1. 20(๊ธ)~29(์ผ)
    1. ๊ฑดํ(27, 28) : Settings(Navigation ๊ฒ๋ค ๋๋ด๊ธฐ, ํ๋กํ ์์ , ์นด์นด์ค ๋น์ง๋์ค ๊ณ์  ์ฐพ์๋ณด๊ธฐ)
    2. ์ํ(28) : Naver Map(pin, zoom ๋ฑ) toy project
    3. ์ ์ฐ : Map Marker Custom, DB ์ฐ๊ฒฐ, Marker(modal๋ฅผ ํตํ Detail UI), MapView UI
    4. ์ง์ฐ(24~26, 28, 29) : Detail UI(Review์ถ๊ฐ ๊น์ง, Network ์ ์ธ)
    5. ๋์(24~28) : Login(Naver, Google, Kakao), Clean Code(UserDefaults) โ ๊ฒ์ ์ค์ค์ญ 
2. 30(์)~05(์ผ)
    1. ๊ฑดํ : Setting์ ๋ค ๋๋ด๊ณ  ์ถ์ด์
    2. ์ํ : ๋งค๊ฑฐ์ง ์์ฑ
    3. ์ ์ฐ : Map ๋ง๋ฌด๋ฆฌ(์ด๋ฏธ์ง ํด๋ฌ์คํฐ๋ง)
    4. ์ง์ฐ : Detail (Network)
    5. ๋์ : ๋ฑ๋ก UI + DB
3. 06(์)~12(์ผ) :
    1. ๊ฑดํ : ๊ด๋ฆฌ์ ์ฑ(๊ธฐ๋ฅ ์์ฃผ), openCV ๋ฑ๋ก OCR
    2. ์ํ : ์ ์ฐ๋์ชฝ ๋์์ค์ผํ ๋ฏํฉ๋๋ค.
    3. ์ ์ฐ : ์๋ฆผ, ์ ํ ๋ก๊ทธ์ธ
    4. ์ง์ฐ : HomeView ๋ฐ ์ถ์ฒ ์๊ณ ๋ฆฌ์ฆ
    5. ๋์ : ์๋ฆผ ์๋ฒ ๋ฐ ์๋ฆผ
4. 13(์)~14(ํ) : ์๋๊ฒ ๋ง๋ฌด๋ฆฌ
    1. ํ์คํธ ์ฝ๋ ์์ฑ, ๋ฐํ์ค๋น, ppt
    2. ๋์์ธ ํต์ผ

## 5. ์ถ๊ฐ ๊ธฐ๋ฅ ๊ณ ๋ ค
1. Map Zoom ๊ธฐ๋ฅ ์ ํ
2. ๊ฒ์ View (์ต๊ทผ ๊ฒ์์ด, ๋ง์ดํฌ ๊ธฐ๋ฅ ๋ฑ) ๋ง๋ค๊ธฐ
3. ๋ฐ๋ฉ ๋ถ๊ฐ ์ง์ญ
<p align="left"><img src="https://user-images.githubusercontent.com/48436020/214491743-931e0f27-96ad-48f6-973c-ff000efb6b13.png" width=30%></p>

## ๐ ๊ฑด์์ฌํญ
