//
//  Constants.swift
//  Walmart_Task
//
//  Created by Ismayil Ismayilov on 4/16/24.
//

import Foundation

//MARK: CollectionViewIDs
enum Constants: String {
    
    case countryTableViewCellID

    var identifier: String {
        switch self {
        case .countryTableViewCellID:
            return "country_table_View_cell_ID"
        }
    }
}
