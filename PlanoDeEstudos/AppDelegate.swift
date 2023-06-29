//
//  AppDelegate.swift
//  PlanoDeEstudos
//
//  Created by Pedro Henrique on 28/06/23.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let center = UNUserNotificationCenter.current()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        center.delegate = self
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .notDetermined {
                let options: UNAuthorizationOptions = [.alert,.sound,.badge,.carPlay]
                self.center.requestAuthorization(options: options) { success, error in
                    if error == nil {
                        print(success)
                    } else {
                        print(error!.localizedDescription)
                    }
                }
            } else if settings.authorizationStatus == .denied {
                print("Usuario negou a Notificação")
            }
        }
        
        let confirmAction = UNNotificationAction(identifier: "Confirm", title: "Já Estudei", options: [.foreground])
        let cancelAction = UNNotificationAction(identifier: "Cancel", title: "Cancelar", options: [])
        let category = UNNotificationCategory(identifier: "Lembrete", actions: [confirmAction,cancelAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: [.customDismissAction])
        
        center.setNotificationCategories([category])
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
}
