//
//  Extencions.swift
//  EvoLabTest
//
//  Created by md760 on 4/21/19.
//  Copyright © 2019 md760. All rights reserved.
//

import Foundation

extension Date {
    
    func getDateStringFromDate(_ dateFormat: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_UA")
        
        if let format = dateFormat {
            dateFormatter.dateFormat = format
        } else {
            dateFormatter.dateFormat = "dd.MM.yy"
        }
        return dateFormatter.string(from: self)
    }
}
