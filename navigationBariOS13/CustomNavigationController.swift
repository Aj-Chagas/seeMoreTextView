//
//  CustomNavigationController.swift
//  navigationBariOS13
//
//  Created by Anderson Chagas on 21/08/22.
//

import UIKit

final class CustomNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithDefaultBackground()
//        appearance.titleTextAttributes = [.foregroundColor: UIColor.blue]
//        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.blue]
//        navigationBar.standardAppearance = appearance

    }
}
