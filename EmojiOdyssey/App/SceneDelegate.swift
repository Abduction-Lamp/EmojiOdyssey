//
//  SceneDelegate.swift
//  EmojiMatchingGame
//
//  Created by Vladimir Lesnykh on 05.07.2023.
//

import UIKit
import AVFAudio

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var router: Routable?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let emoji = Emoji()
        let user: any UserStorageable = User.shared
        let appearance: AppearanceStorageable = Appearance.shared
        let audio = AudioEngine(appearance)
        appearance.fetchOnlyMode()
        
        let builder: Buildable = Builder(storage: (user, appearance), emoji: emoji, audio: audio)
        let navigation = NavigationController()
        router = Router(navigation: navigation, builder: builder)
        router?.initVC()
        
        window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = appearance.mode
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }

    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        audioSessionActive()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}



extension SceneDelegate {
    
    private func audioSessionActive() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setActive(true)
        } catch let error {
            print("⚠️ Failed to set active audio session route sharing policy: \(error)")
        }
    }
}
