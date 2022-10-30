//
//  ViewController.swift
//  navigationBariOS13
//
//  Created by Anderson Chagas on 21/08/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let mainView: HomeView = HomeView(frame: UIScreen.main.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func loadView() {
        super.loadView()
        self.view = mainView
    }



}

