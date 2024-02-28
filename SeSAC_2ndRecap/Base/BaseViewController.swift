//
//  BaseViewController.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureConstraints()
        configureView()
    }

    func configureHierarchy() { }
    func configureConstraints() { }
    func configureView() { }
}
