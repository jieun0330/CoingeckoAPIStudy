//
//  MyFavoriteCollectionViewCell.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/1/24.
//
//
import UIKit
import Then
import SnapKit

class MyFavoriteCollectionViewCell: BaseCollectionViewCell, ReusableProtocol {
    
    let icon = UIImageView().then {
        $0.image = UIImage(systemName: "circle")
    }
    
    let namestackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 0
    }
    
    let name = UILabel().then {
        $0.font = DesignSystemFont.allCoinName.font
//        $0.text = "Bitcoin"
    }
    
    let symbol = UILabel().then {
        $0.font = DesignSystemFont.allSymbolName.font
        $0.textColor = UIColor.gray
        $0.text = "BTC"
    }
    
    let priceStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 0
    }
    
    let price = UILabel().then {
        $0.text = "$69,234,245"
        $0.font = DesignSystemFont.allPercentageBold.font
    }
    
    let percentage = UILabel().then {
        $0.text = "+0.64%"
        $0.font = DesignSystemFont.allPercentageBold.font
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    override func configureHierarchy() {
        [icon, namestackView, priceStackView].forEach {
            contentView.addSubview($0)
        }
        
        [name, symbol].forEach {
            namestackView.addSubview($0)
        }
        
        [price, percentage].forEach {
            priceStackView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        icon.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(10)
            $0.top.equalToSuperview().inset(10)
            $0.size.equalTo(30)
        }
        
        namestackView.snp.makeConstraints {
            $0.leading.equalTo(icon.snp.trailing).offset(5)
            $0.top.equalTo(icon.snp.top)
            $0.trailing.equalToSuperview().offset(-5)
            $0.verticalEdges.equalTo(icon)
        }
        
        name.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }
        
        symbol.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
        }
        
        priceStackView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView).inset(10)
            $0.bottom.equalTo(contentView).inset(10)
            $0.height.equalTo(50)
//            $0.trailing.equalToSuperview().offset(-10)
        }
        
        price.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        
        percentage.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()

        }
    }
    
    override func configureView() {

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
