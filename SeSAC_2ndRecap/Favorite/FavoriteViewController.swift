//
//  FavoriteViewController.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/28/24.
//

import UIKit
import Then
import SnapKit
import Kingfisher
import RealmSwift

class FavoriteViewController: BaseViewController {
    
    var list: Results<CoinRealmModel>!
    let repository = CoinRepository()

    let profileImage = UIImageView().then {
        $0.image = .tabUser
        $0.layer.borderColor = DesignSystemColor.purple.color.cgColor
        $0.layer.borderWidth = 2
    }
    
    let mainTitle = UILabel().then {
        $0.text = "Favorite Coin"
        $0.font = DesignSystemFont.main.font
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: FavoriteViewController.configureCollectionViewLayout()).then {
        $0.backgroundColor = DesignSystemColor.white.color
        $0.delegate = self
        $0.dataSource = self
        $0.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCollectionViewCell.identifier)

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = repository.favoriteItemsFilter()
        print(list.count)
//        list = repository.favoriteItemFilter(item: <#T##CoinModel#>)

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
    
    static func configureCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let cellWidth = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: cellWidth / 2.4, height: cellWidth / 2.4)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: spacing, left: 0, bottom: 0, right: spacing)
        return layout
    }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.identifier, for: indexPath) as! FavoriteCollectionViewCell
        
//        cell.icon.image = list[indexPath.row].
        
        return cell
    }
}
