//
//  FavoriteViewController.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/28/24.
//

import UIKit
import Then

class FavoriteViewController: BaseViewController {
    
    let profileImage = UIImageView().then {
        $0.image = .tabUser
        $0.layer.borderColor = DesignSystemColor.purple.color.cgColor
        $0.layer.borderWidth = 2
    }
    
    let mainTitle = UILabel().then {
        $0.text = "Favorite Coin"
        $0.font = DesignSystemFont.main.font
    }
    
    lazy var collectionView = UICollectionView().then {
        $0.backgroundColor = .orange
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureHierarchy() {
        [profileImage, mainTitle, collectionView].forEach {
            view.addSubview($0)
        }    }
    
    override func configureConstraints() {
        profileImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(35)
        }
        
        mainTitle.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }
        
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.top.equalTo(mainTitle.snp.bottom).offset(10)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        view.backgroundColor = DesignSystemColor.white.color
    }
}
