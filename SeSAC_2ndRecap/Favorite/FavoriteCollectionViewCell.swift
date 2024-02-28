//
//  FavoriteCollectionViewCell.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/28/24.
//

import UIKit

class FavoriteCollectionViewCell: BaseCollectionViewCell, ReusableProtocol {
    
    let icon = UIImageView().then {
        $0.image = UIImage(systemName: "circle")
    }
    
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 0
    }
    
    let name = UILabel().then {
        $0.font = DesignSystemFont.coinName.font
        $0.text = "Bitcoin"
    }
    
    let symbol = UILabel().then {
        $0.font = DesignSystemFont.symbol.font
        $0.textColor = UIColor.gray
        $0.text = "BTC"
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
    }
    
    override func configureHierarchy() {
        [icon, stackView].forEach {
            contentView.addSubview($0)
        }
        
        [name, symbol].forEach {
            stackView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        icon.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(10)
            $0.size.equalTo(35)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(icon.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().offset(-5)
            $0.verticalEdges.equalTo(icon)
        }
        
        name.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        
        symbol.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        // cell shadow + cornerRadis 같이 주는 방법 https://roniruny.tistory.com/184
        contentView.backgroundColor = DesignSystemColor.white.color
        contentView.layer.cornerRadius = 15
        contentView.layer.shadowColor = DesignSystemColor.black.color.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
