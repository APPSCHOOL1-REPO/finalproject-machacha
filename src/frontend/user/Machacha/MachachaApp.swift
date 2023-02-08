//
//  MachachaApp.swift
//  Machacha
//
//  Created by geonhyeong on 2023/01/17.
//

import SwiftUI
import NaverThirdPartyLogin
import KakaoSDKCommon
import KakaoSDKAuth
import GoogleSignIn
import Firebase
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //파이어베이스 초기화
        FirebaseApp.configure()
        
        // 원격 알림 등록
        UNUserNotificationCenter.current().delegate = self
        
                let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                UNUserNotificationCenter.current().requestAuthorization(
                    options: authOptions,
                    completionHandler: { _, _ in }
                )
        
        application.registerForRemoteNotifications()
        // 메세징 델리게이트
        Messaging.messaging().delegate = self
        
        // 푸시 포그라운드 설정
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    //구글의 인증프로세스가 끝날때 앱이 수신하는 URL을 처리하는 역활
    //    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    //        return GIDSignIn.sharedInstance.handle(url)
    //    }
    
    // fcm 토큰이 등록 되었을 때
        func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            Messaging.messaging().apnsToken = deviceToken
        }
    // SceneDelegate  연결을 위한 함수
        func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    
            let sceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
    
            sceneConfiguration.delegateClass = SceneDelegate.self
    
            return sceneConfiguration
        }
}

extension AppDelegate: MessagingDelegate {
    // fcm 등록 토큰을 받았을 때
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("AppDelegate - 파베 토큰 받음")
        print("AppDelegate - Firebase registration token: \(String(describing: fcmToken))")
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // 푸시메세지가 앱이 켜져 있을 때 나옴
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        completionHandler([.banner, .sound, .badge])
    }
    
    // 백그라운드에서 푸시메세지를 받았을 때
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("didReceive: userInfo: ", userInfo)
        completionHandler()
    }
}

// MARK: - 앱 실행시 앱 아이콘의 뱃지 알림 초기화
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    func sceneDidBecomeActive(_ scene: UIScene) {
        if UIApplication.shared.applicationIconBadgeNumber != 0 {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
    }
}

@main
struct MachachaApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var profileVM: ProfileViewModel = ProfileViewModel()
    @StateObject var mapSearchVM: MapSearchViewModel = MapSearchViewModel()
    @State var splashIsActive = false
    init() {
        // Naver SDK Initializing
        
        // 네이버 앱으로 로그인 허용
        NaverThirdPartyLoginConnection.getSharedInstance()?.isNaverAppOauthEnable = true
        // 브라우저 로그인 허용
        NaverThirdPartyLoginConnection.getSharedInstance()?.isInAppOauthEnable = true
        
        // 네이버 로그인 세로모드 고정
        NaverThirdPartyLoginConnection.getSharedInstance().setOnlyPortraitSupportInIphone(true)
        
        // NaverThirdPartyConstantsForApp.h에 선언한 상수 등록
        NaverThirdPartyLoginConnection.getSharedInstance().serviceUrlScheme = kServiceAppUrlScheme
        NaverThirdPartyLoginConnection.getSharedInstance().consumerKey = kConsumerKey
        NaverThirdPartyLoginConnection.getSharedInstance().consumerSecret = kConsumerSecret
        NaverThirdPartyLoginConnection.getSharedInstance().appName = kServiceAppName
        
        // Kakao SDK 초기화
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        KakaoSDK.initSDK(appKey: kakaoAppKey as! String)
    }
    
    var body: some Scene {
        WindowGroup {
            if splashIsActive {
                AuthView()
                    .environmentObject(LocationManager())
                    .environmentObject(FoodCartViewModel())
                    .environmentObject(ReviewViewModel())
                    .environmentObject(mapSearchVM)
                    .preferredColorScheme(profileVM.isDarkMode ? .dark : .light)
                    .environmentObject(ProfileViewModel()) // 프로필 탭에서 사용할 environmentObject
                
                    .onOpenURL { url in
                        //네이버
                        if NaverThirdPartyLoginConnection
                            .getSharedInstance()
                            //임의로 아무거나 넣어봄
                            .isNaverAppOauthEnable
                        //.isInAppOauthEnable
                        //.isNaverThirdPartyLoginAppschemeURL(url)
                        {
                            // Token 발급 요청
                            NaverThirdPartyLoginConnection
                                .getSharedInstance()
                                .receiveAccessToken(url)
                        }

                        //카카오
                        if (AuthApi.isKakaoTalkLoginUrl(url)){
                            _ = AuthController.handleOpenUrl(url: url)
                        }
                        
                        // 구글
                        GIDSignIn.sharedInstance.handle(url)
                    }
                    .onAppear {
                        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                            // Check if `user` exists; otherwise, do something with `error`
                        }
                    }
            } else {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            self.splashIsActive = true
                        }
                    }
            }
            

        }
    }
}

