//
//  SearchTableViewCell.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import UIKit
import Then
import SnapKit

class SearchTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    var icon = UIImageView().then {
        $0.image = UIImage(systemName: "circle")
    }
    
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .equalSpacing
        $0.spacing = 5
    }
    
    let name = UILabel().then {
        $0.text = "Bitcoin"
        $0.font = DesignSystemFont.coinName.font
    }
    
    let symbol = UILabel().then {
        $0.text = "BTC"
        $0.font = DesignSystemFont.symbol.font
        $0.textColor = UIColor.gray
    }
    
    let favorites = UIButton().then {
        $0.setImage(UIImage(named: "btn_star"), for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureHierarchy() {
        [icon, stackView, favorites].forEach {
            contentView.addSubview($0)
        }
        
        [name, symbol].forEach {
            stackView.addSubview($0)
        }
    }
    
    override func configureConstraints() {
        icon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.size.equalTo(40)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(icon.snp.trailing).offset(10)
            $0.trailing.equalTo(favorites.snp.leading).offset(-10)
            $0.verticalEdges.equalToSuperview().inset(5)
        }
        
        name.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        
        symbol.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        favorites.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(5)
            $0.size.equalTo(25)
        }
    }
    
    override func configureView() {
        contentView.backgroundColor = DesignSystemColor.white.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
