//
//  Memo.swift
//  VoiceMemo
//
//  Created by 정성윤 on 2024/01/13.
//

import Foundation

struct Memo: Hashable {
    var title : String
    var content : String
    var date : Date
    var id = UUID()
    
    var convertedDate : String {
        String("\(date.formattedDay) -  \(date.formattedTime)에 알림")
    }
}
