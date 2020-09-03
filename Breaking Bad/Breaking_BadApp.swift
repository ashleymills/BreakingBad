//
//  Breaking_BadApp.swift
//  Breaking Bad
//
//  Created by Ashley Mills on 02/09/2020.
//

import SwiftUI

@main
struct Breaking_BadApp: App {

    init() {
        configureAppearance()
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeScreen()
            }
        }
    }

    func configureAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(.bbBackground)
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(.bbHighlight)]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(.bbHighlight)]

        let barButtonAppearance = UIBarButtonItemAppearance()
        barButtonAppearance.configureWithDefault(for: .plain)
        barButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(.bbHighlight)]

        navBarAppearance.buttonAppearance = barButtonAppearance

        let navBarProxy = UINavigationBar.appearance()

        navBarProxy.standardAppearance = navBarAppearance
        navBarProxy.compactAppearance = navBarAppearance
        navBarProxy.scrollEdgeAppearance = navBarAppearance
    }
}
