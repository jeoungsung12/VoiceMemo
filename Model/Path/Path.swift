//
//  Path.swift
//  VoiceMemo
//
//  Created by 정성윤 on 2024/01/12.
//

import Foundation

class PathModel : ObservableObject{
    @Published var path: [PathType]
    init(path: [PathType] = []) {
        self.path = path
    }
}
