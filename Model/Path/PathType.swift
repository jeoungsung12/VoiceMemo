//
//  PathType.swift
//  VoiceMemo
//
//  Created by 정성윤 on 2024/01/12.
//

import Foundation

enum PathType: Hashable {
    case homeView
    case todoView
    case memoView(isCreateMode: Bool, memo: Memo?)
}
