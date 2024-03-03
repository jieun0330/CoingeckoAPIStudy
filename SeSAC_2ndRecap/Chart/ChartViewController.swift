//
//  ChartViewController.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/28/24.
//

import UIKit
import Then
import SnapKit
import RealmSwift
import Kingfisher
import Toast

final class ChartViewController: BaseViewController {
    
    let repository = RepositoryRealm()
    let viewModel = ViewModel()
    var data: Market!
    
    lazy var rightFavoriteButton = UIBarButtonItem(image: DesignSystemImage.starFill.image,
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(rightFavoriteButtonClicked)).then { _ in
        
    }
    
    let icon = UIImageView().then { _ in
        
    }
    
    var name = UILabel().then {
        $0.font = DesignSystemFont.allMainTitle.font
    }
    
    let price = UILabel().then {
        $0.font = DesignSystemFont.allMainTitle.font
    }
    
    let percentage = UILabel().then {
        $0.textColor = DesignSystemColor.red.color
        $0.font = DesignSystemFont.allPercentageBold.font
    }
    
    let today = UILabel().then {
        $0.text = "Today"
        $0.font = DesignSystemFont.allPercentageBold.font
        $0.textColor = DesignSystemColor.gray.color
    }
    
    lazy var collectionView = UICollectionView(
        frame: .zero, collectionViewLayout: ChartViewController.configureCollectionViewLayout()).then {
            $0.delegate = self
            $0.dataSource = self
            $0.register(ChartPriceCollectionViewCell.self,
                        forCellWithReuseIdentifier: ChartPriceCollectionViewCell.identifier)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureHierarchy() {
        [icon, name, price, percentage, today, collectionView].forEach {
            view.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        icon.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.size.equalTo(35)
        }
        
        name.snp.makeConstraints {
            $0.leading.equalTo(icon.snp.trailing).offset(10)
            $0.top.equalTo(icon.snp.top)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        price.snp.makeConstraints {
            $0.leading.equalTo(icon.snp.leading).offset(5)
            $0.top.equalTo(icon.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        percentage.snp.makeConstraints {
            $0.leading.equalTo(price.snp.leading)
            $0.top.equalTo(price.snp.bottom).offset(10)
            $0.width.equalTo(70)
        }
        
        today.snp.makeConstraints {
            $0.top.equalTo(percentage.snp.top)
            $0.leading.equalTo(percentage.snp.trailing)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(percentage.snp.bottom).offset(30)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(150)
        }
    }
    
    override func configureView() {
        view.backgroundColor = DesignSystemColor.white.color
        navigationItem.title = ""
        navigationItem.rightBarButtonItem = rightFavoriteButton
        
        icon.kf.setImage(with: URL(string: data.image))
        name.text = data.name
        percentage.text = DesignSystemText.shared.percentageCalculator(number: data.priceChangePercentage24H)
        
        let coinPrice = DesignSystemText.shared.priceCalculator(data.currentPrice)
        price.text = "₩\(coinPrice)"
    }
    
    @objc func rightFavoriteButtonClicked(_ sender: UIButton) {
        
        
        let readRealmModel = CoinRealmModel(id: data.id)
        let realmData = repository.readItemName(id: data.id)
        
        if realmData.contains(where: { data in
            repository.deleteItem(item: data)
            return true
        }) {
            self.view.makeToast("즐겨찾기에서 삭제되었습니다")
            rightFavoriteButton.image = DesignSystemImage.star.image
        } else {
            repository.createFavoriteItem(readRealmModel)
            self.view.makeToast("즐겨찾기에 추가되었습니다")
            rightFavoriteButton.image = DesignSystemImage.starFill.image
        }
        
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let cellWidth = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: cellWidth / 2.4, height: cellWidth / 5.7)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        return layout
    }
}

extension ChartViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ChartPriceCollectionViewCell.identifier,
            for: indexPath) as! ChartPriceCollectionViewCell
        
        cell.priceTitle.text = collectionViewCellName.allCases[indexPath.item].cellName
        
        viewModel.collectionViewCellPrice(indexPath: indexPath.item, data: data)
        cell.price.text = "₩\(viewModel.outputPrice.value)"
        viewModel.outputPriceTextColor.bind { value in
            cell.priceTitle.textColor = value ? DesignSystemColor.blue.color : DesignSystemColor.red.color
        }
        
        return cell
    }
}
