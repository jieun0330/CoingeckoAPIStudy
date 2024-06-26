//
//  FavoriteCollectionViewCell.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/28/24.
//

import UIKit
import Then

final class FavoriteCollectionViewCell: BaseCollectionViewCell, ReusableProtocol {
    
    private let backView = {
        let backView = UIView()
        backView.backgroundColor = .white
        backView.layer.cornerRadius = 10
        return backView
    }()
    
    let icon = UIImageView()
    
    let namestackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 0
    }
    
    let name = UILabel().then {
        $0.font = DesignSystemFont.allCoinName.font
    }
    
    let symbol = UILabel().then {
        $0.font = DesignSystemFont.allSymbolName.font
        $0.textColor = DesignSystemColor.gray.color
    }
    
    let priceStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 0
    }
    
    let price = UILabel().then {
        $0.font = DesignSystemFont.allPercentageBold.font
    }
    
    let percentageBox = UIView().then {
        $0.layer.cornerRadius = 8
    }
    
    let percentage = UILabel().then {
        $0.font = DesignSystemFont.allPercentageBold.font
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    override func configureHierarchy() {
        
        [backView].forEach {
            contentView.addSubview($0)
        }
        
        [icon, namestackView, priceStackView].forEach {
            backView.addSubview($0)
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
        
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
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
            $0.center.equalToSuperview()
        }
    }
    
    override func configureView() {
        layer.masksToBounds = false
        layer.shadowOpacity = 0.8
        layer.shadowOffset = .init(width: 0, height: 0)
        layer.shadowColor = DesignSystemColor.lightGray.color.cgColor
        layer.shadowRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
