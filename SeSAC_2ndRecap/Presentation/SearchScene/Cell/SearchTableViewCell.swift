//
//  SearchTableViewCell.swift
//  SeSAC_2ndRecap
//
//  Created by 박지은 on 2/27/24.
//

import UIKit
import Then
import SnapKit

final class SearchTableViewCell: BaseTableViewCell, ReusableProtocol {
    
    let icon = UIImageView()
    
    let stackView = UIStackView().then {
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
    
    lazy var favorites = UIButton().then {
        $0.addTarget(self, action: #selector(favoritesButtonClicked), for: .touchUpInside)
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
            $0.size.equalTo(35)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(icon.snp.trailing).offset(15)
            $0.trailing.equalTo(favorites.snp.leading).offset(-15)
            $0.verticalEdges.equalToSuperview().inset(15)
        }
        
        name.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview()
        }
        
        symbol.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
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
    
    @objc func favoritesButtonClicked() { }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
