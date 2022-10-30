//
//  DetailViewController.swift
//  navigationBariOS13
//
//  Created by Anderson Chagas on 21/08/22.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.title = "Home"
        view.backgroundColor = .white
    }

}
