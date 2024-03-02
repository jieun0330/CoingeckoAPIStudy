//
//  FavoriteCollectionViewCell.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/28/24.
//

import UIKit
import Then

class FavoriteCollectionViewCell: BaseCollectionViewCell, ReusableProtocol {
    
    let icon = UIImageView().then { _ in
//        $0.image = UIImage(systemName: "circle")
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
        $0.textColor = DesignSystemColor.gray.color
//        $0.text = "BTC"
    }
    
    let priceStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 0
    }
    
    let price = UILabel().then {
//        $0.text = "$69,234,245"
        $0.font = DesignSystemFont.allPercentageBold.font
    }
    
    let percentageBox = UIView().then {
        $0.backgroundColor = .orange
        $0.layer.cornerRadius = 8
    }
    
    let percentage = UILabel().then {
//        $0.text = "+0.64%"
//        $0.textColor = .red
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
        
        [price, percentageBox].forEach {
            priceStackView.addSubview($0)
        }
        
        [percentage].forEach {
            percentageBox.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        icon.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(10)
            $0.size.equalTo(35)
        }
        
        namestackView.snp.makeConstraints {
            $0.leading.equalTo(icon.snp.trailing).offset(5)
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
            $0.trailing.bottom.equalToSuperview().offset(-10)
            $0.height.equalTo(50)
            $0.leading.equalTo(icon.snp.leading)
        }
        
        price.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
        }
        
        percentageBox.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
            $0.height.equalTo(25)
            $0.width.equalTo(70)
        }
        
        percentage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.edges.equalToSuperview().inset(5)
        }
    }
    
    override func configureView() {
        // cell shadow + cornerRadis 같이 주는 방법 https://roniruny.tistory.com/184
        contentView.backgroundColor = DesignSystemColor.white.color
        contentView.layer.cornerRadius = 15
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1
//        contentView.layer.shadowColor = DesignSystemColor.black.color.cgColor
//        layer.shadowOpacity = 0.1
//        layer.shadowRadius = 2
//        layer.shadowOffset = CGSize(width: 0, height: 5)
//        layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
//                                        byRoundingCorners: .allCorners,
//                                        cornerRadii: CGSize(width: 8, height: 8)).cgPath
//        layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
