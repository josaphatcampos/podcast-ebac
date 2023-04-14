//
//  extensions.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 09/04/23.
//

import Foundation
import AVFoundation
extension Date {
    var millisecondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
