//
//  RankCollectionViewCell.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 3/1/24.
//

import UIKit
import Then
import SnapKit

class RankCollectionViewCell: BaseCollectionViewCell, ReusableProtocol {
    
    let rankNum = UILabel().then {
        $0.text = "1"
        $0.font = DesignSystemFont.trendingRankNum.font
    }
    
    let image = UIImageView().then {
        $0.image = .tabPortfolio
    }
    
    let nameStackView = UIStackView().then { _ in
        
    }
    
    let name = UILabel().then {
        $0.text = "Solana"
        $0.font = DesignSystemFont.allCoinName.font
    }
    
    let symbol = UILabel().then {
        $0.text = "LTC"
        $0.font = DesignSystemFont.allSymbolName.font
    }
    
    let pricestackView = UIStackView().then { _ in
        
    }
    
    let price = UILabel().then {
        $0.text = "0.4175"
        $0.font = DesignSystemFont.allPrice.font
    }
    
    let percentage = UILabel().then {
        $0.text = "+21.18%"
        $0.font = DesignSystemFont.allPercentage.font
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    override func configureHierarchy() {
        [rankNum, image, nameStackView, pricestackView].forEach {
            contentView.addSubview($0)
        }
        
        [name, symbol].forEach {
            nameStackView.addSubview($0)
        }
        
        [price, percentage].forEach {
            pricestackView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        rankNum.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        
        image.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.size.equalTo(30)
            $0.leading.equalTo(rankNum.snp.trailing)
        }
        
        nameStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.leading.equalTo(image.snp.trailing).offset(10)
        }
        
        name.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        
        symbol.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
        }
        
        pricestackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(80)
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        price.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
        }
        
        percentage.snp.makeConstraints {
            $0.bottom.trailing.equalToSuperview()
        }
        
    }
    
    //    override func configureView() {
    //        <#code#>
    //    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
