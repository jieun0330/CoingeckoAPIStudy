//
//  SearchViewController.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import UIKit
import Then
import SnapKit

class SearchViewController: BaseViewController {
    
    let profileImage = UIImageView().then {
        $0.image = .tabUser
//        $0.layer.borderColor = 
    }
    
    let mainTitle = UILabel().then {
        $0.text = "Search"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureHierarchy() {
        [profileImage, mainTitle].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        profileImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(30)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .white
    }

}
