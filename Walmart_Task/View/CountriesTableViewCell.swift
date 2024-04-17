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
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            
            regionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            regionLabel.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 10),
            
            codeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            codeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            
            capitalLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            capitalLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5)
        ])
    }
    
    func setUp(_ item: Country) {
        nameLabel.text = item.name
        regionLabel.text = item.region.rawValue
        codeLabel.text = item.code
        capitalLabel.text = item.capital
    }
}
