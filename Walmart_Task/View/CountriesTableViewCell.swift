//
//  CountriesTableViewCell.swift
//  Walmart_Task
//
//  Created by Ismayil Ismayilov on 4/16/24.
//

import Foundation
import UIKit

class CountriesTableViewCell: UITableViewCell {
    
    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.numberOfLines = 1
        view.lineBreakMode = .byWordWrapping
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var regionLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var codeLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var capitalLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(regionLabel)
        contentView.addSubview(codeLabel)
        contentView.addSubview(capitalLabel)
        
        
        let nameLabelTrailingConstraint = nameLabel.trailingAnchor.constraint(equalTo: regionLabel.leadingAnchor, constant: -5)
        nameLabelTrailingConstraint.priority = .defaultHigh // Lower priority than required

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            
            regionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            regionLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            regionLabel.trailingAnchor.constraint(lessThanOrEqualTo: codeLabel.leadingAnchor, constant: -3),
            
            codeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            codeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            
            capitalLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            capitalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5)
        ])
    }
    
    func setUp(_ item: Country?) {
        nameLabel.text = item?.name
        regionLabel.text = item?.region.rawValue
        codeLabel.text = item?.code
        capitalLabel.text = item?.capital
    }
}
