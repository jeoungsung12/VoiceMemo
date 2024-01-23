//
//  Todo.swift
//  VoiceMemo
//
//  Created by 정성윤 on 2024/01/12.
//

import Foundation

struct Todo: Hashable {
    var title : String
    var time : Date
    var day : Date
    var selected : Bool
    
    var convertedDayAndTime : String {
        String("\(day.formattedDay) - \(time.formattedTime)에 알림")
    }
}
