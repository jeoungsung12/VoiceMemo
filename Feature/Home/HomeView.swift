//
//  HomeView.swift
//  VoiceMemo
//
//  Created by 정성윤 on 2024/01/12.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var pathModel : PathModel
    @StateObject private var homeViewModel = HomeViewModel()
    var body: some View {
        ZStack {
            TabView(selection: $homeViewModel.selectedTab) {
                TodoListView()
                    .tabItem {
                        Image(
                            homeViewModel.selectedTab == .todoList
                            ? "todoOn"
                            : "todoDefault"
                        )
                    }
                    .tag(Tab.todoList)
                MemoListView()
                    .tabItem {
                        Image(
                            homeViewModel.selectedTab == .memo
                            ? "memoicon_selected"
                            : "memoicon"
                        )
                    }
                    .tag(Tab.memo)
                VoiceRecorderView()
                    .tabItem {
                        Image(
                            homeViewModel.selectedTab == .voiceRecoder
                            ? "mikeOn"
                            : "mikeDefault"
                        )
                    }
                    .tag(Tab.voiceRecoder)
                TimerView()
                    .tabItem {
                        Image(
                            homeViewModel.selectedTab == .timer
                            ? "timerOn"
                            : "timerDefault"
                        )
                    }
                    .tag(Tab.timer)
                SettingView()
                    .tabItem {
                        Image(
                            homeViewModel.selectedTab == .setting
                            ? "settingOn"
                            : "settingDefault"
                        )
                    }
                    .tag(Tab.setting)
            }
            .environmentObject(homeViewModel)
            SeperatorLineView()
        }
    }
}
//MARK: - 구분선
private struct SeperatorLineView : View {
    fileprivate var body: some View {
        VStack {
            Spacer()
            
            Rectangle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.1)]), startPoint: .top, endPoint: .bottom
                                  )
                )
                .frame(height: 10)
                .padding(.bottom, 60)
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(PathModel())
            .environmentObject(TodoListViewModel())
            .environmentObject(MemoListViewModel())
    }
}
