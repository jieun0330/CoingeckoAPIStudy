//
//  PriceCollectionViewCell.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/28/24.
//

import UIKit
import Then
import SnapKit

class PriceCollectionViewCell: BaseCollectionViewCell, ReusableProtocol {
    
    let priceTitle = UILabel().then {
        $0.text = "고가"
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textColor = .red
    }
    
    let price = UILabel().then {
        $0.text = "$69,234,243"
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textColor = .gray
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    override func configureHierarchy() {
        [priceTitle, price].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        priceTitle.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(5)
        }
        
        price.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(5)
        }
    }
    
//    override func configureView() {
//        <#code#>
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
