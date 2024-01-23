//
//  MemoViewModel.swift
//  VoiceMemo
//
//  Created by 정성윤 on 2024/01/13.
//

import Foundation
class MemoViewModel : ObservableObject {
    @Published var memo: Memo
    
    init(memo: Memo) {
        self.memo = memo
    }
}
