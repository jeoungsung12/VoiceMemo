//
//  MemoView.swift
//  VoiceMemo
//
//  Created by 정성윤 on 2024/01/12.
//

import SwiftUI
import Foundation

struct MemoView: View {
    @EnvironmentObject private var pathModel : PathModel
    @EnvironmentObject private var memoListViewModel : MemoListViewModel
    @StateObject var memoViewModel : MemoViewModel
    @State var isCreateMode: Bool = true
    var body: some View {
        ZStack{
            VStack{
                CustomNavigationBar(
                    leftBtnAction: {
                        pathModel.path.removeLast()
                    },
                    rightBtnAction: {
                        if isCreateMode {
                            memoListViewModel.addTo(memoViewModel.memo)
                        }else{
                            memoListViewModel.updateMemo(memoViewModel.memo)
                        }
                        pathModel.path.removeLast()
                    },
                    rightBtnType: isCreateMode ? .create : .complete
                )
                //메모 타이틀 인풋 뷰
                MemoTitleInputView(
                    memoViewModel : memoViewModel,
                    isCreateMode: $isCreateMode
                ).padding(.top, 20)
                //메모 컨텐츠 인풋 뷰
                MemoContentInputView(memoViewModel: memoViewModel)
                    .padding(.top, 10)
            }
            if !isCreateMode {
                //삭제 플로틴 버튼 뷰
                RemoveMemoBtnView(memoViewModel: memoViewModel)
                    .padding(.trailing, 20)
                    .padding(.bottom, 10)
            }
        }
    }
}
//MARK: - 메모 타이틀 뷰(제목 입력뷰)
private struct MemoTitleInputView : View {
    @ObservedObject private var memoViewModel : MemoViewModel
    @FocusState private var isTitleFieldFocused : Bool
    @Binding private var isCreateMode : Bool
    fileprivate init(
        memoViewModel : MemoViewModel,
        isCreateMode : Binding<Bool>
    ){
        self.memoViewModel = memoViewModel
        self._isCreateMode = isCreateMode
    }
    fileprivate var body: some View {
        TextField("제목을 입력하세요.",text: $memoViewModel.memo.title)
            .font(.system(size: 30))
            .padding(.horizontal, 20)
            .focused($isTitleFieldFocused)
            .onAppear {
                if isCreateMode {
                    isTitleFieldFocused = true
                }
            }
    }
}
//MARK: - 메모 본문 입력뷰
private struct MemoContentInputView : View {
    @ObservedObject private var memoViewModel : MemoViewModel
    fileprivate init(memoViewModel: MemoViewModel) {
        self.memoViewModel = memoViewModel
    }
    fileprivate var body: some View {
        ZStack(alignment: .topLeading){
            TextEditor(text: $memoViewModel.memo.content)
                .font(.system(size:20))
            if memoViewModel.memo.content.isEmpty {
                Text("메모를 입력하세요.")
                    .font(.system(size: 16))
                    .foregroundColor(.gray1)
                    .allowsTightening(false)
                    .padding(.top, 10)
                    .padding(.leading, 5)
            }
        }
        .padding(.horizontal, 20)
    }
}
//MARK: - 메모 삭제 버튼 뷰
private struct RemoveMemoBtnView : View {
    @EnvironmentObject private var pathModel : PathModel
    @EnvironmentObject private var memoListViewModel : MemoListViewModel
    @ObservedObject private var memoViewModel: MemoViewModel
    fileprivate init(memoViewModel: MemoViewModel) {
        self.memoViewModel = memoViewModel
    }
    fileprivate var body: some View {
        VStack{
            Spacer()
            HStack{
                Spacer()
                Button(action: {
                    memoListViewModel.removeMemo(memoViewModel.memo)
                    pathModel.path.removeLast()
                }, label: {
                    Image("trash")
                        .resizable()
                        .frame(width: 40, height: 40)
                })
            }
        }
    }
}
struct MemoView_Previews: PreviewProvider {
    static var previews: some View {
        MemoView(
            memoViewModel: .init(
                memo: .init(title: "", content: "", date: Date())
            )
        )
    }
}
