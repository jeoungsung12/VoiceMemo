//
//  HomeViewModel.swift
//  VoiceMemo
//
//  Created by 정성윤 on 2024/01/20.
//

import Foundation

class HomeViewModel : ObservableObject {
    @Published var selectedTab : Tab
    @Published var todosCount : Int
    @Published var memoCount : Int
    @Published var voiceRecorderCount : Int
    init(
        selectedTab: Tab = .voiceRecoder,
        todosCount : Int = 0,
        memoCount : Int = 0,
        voiceRecorderCount : Int = 0
    ){
        self.selectedTab = selectedTab
        self.todosCount = todosCount
        self.memoCount = memoCount
        self.voiceRecorderCount = voiceRecorderCount
    }
}
extension HomeViewModel {
    func setTodosCount(_ count : Int) {
        todosCount = count
    }
    func setMemosCount(_ count : Int) {
        memoCount = count
    }
    func setVoiceRecorderCount(_ count : Int) {
        voiceRecorderCount = count
    }
    func changeSelectedTab(_ tab: Tab) {
        selectedTab = tab
    }
}
