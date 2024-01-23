//
//  MemoListView.swift
//  VoiceMemo
//
//  Created by 정성윤 on 2024/01/13.
//

import SwiftUI

struct MemoListView: View {
    @EnvironmentObject private var pathModel : PathModel
    @EnvironmentObject private var memoListViewModel : MemoListViewModel
    @EnvironmentObject private var homeViewModel : HomeViewModel
    var body: some View {
        ZStack{
            VStack{
                if !memoListViewModel.memos.isEmpty {
                    CustomNavigationBar(
                        isDisplayLeftBtn: false,
                        rightBtnAction: {
                            memoListViewModel.navigationRightBtnTapped()
                        },
                        rightBtnType: memoListViewModel.navigationBarRightBtnMode
                        )
                }else{
                    Spacer()
                        .frame(height: 30)
                }
                TitleView()
                    .padding(.top, 20)
                if memoListViewModel.memos.isEmpty{
                    AnnouncementView()
                }else{
                    MemoListContentView()
                        .padding(.top, 20)
                }
            }
            WriteMemoBtnView()
                .padding(.trailing, 20)
                .padding(.bottom, 50)
        }
        .alert(
            "메모 \(memoListViewModel.removeMemoCount)개 삭제하시겠습니까?", isPresented: $memoListViewModel.isDisplayRemoveMemoAlert
        ){
            Button("삭제", role:  .destructive) {
                memoListViewModel.removeBtnTapped()
            }
            Button("취소", role:  .cancel) {
            }
        }
        .onChange(of: memoListViewModel.memos, perform: { memos in
            homeViewModel.setMemosCount(memos.count)
        })
    }
}
//MARK: - 타이틀 뷰
private struct TitleView : View {
    @EnvironmentObject private var memoListViewModel : MemoListViewModel
    fileprivate var body: some View {
        HStack {
            if memoListViewModel.memos.isEmpty {
                Text("메모를\n추가해보세요")
            }else{
                Text("메모\(memoListViewModel.memos.count)개가\n있습니다.")
            }
            Spacer()
        }
        .font(.system(size: 30, weight: .bold))
        .padding(.leading, 20)
    }
}
//MARK: - 안내 뷰
private struct AnnouncementView : View {
    @EnvironmentObject private var memoListViewModel : MemoListViewModel
    fileprivate var body: some View {
        VStack(spacing: 15){
            Spacer()
            Image(systemName: "pencil")
                .renderingMode(.template)
            Text("\"퇴근 9시간 전 메모\"")
            Text("\"기획서 작성 후 퇴근하기 메모\"")
            Text("\"밀린 집안일 하기 메모\"")
            Spacer()
        }
        .font(.system(size: 16))
        .foregroundColor(.gray2)
    }
}
//MARK: - 컨텐츠 뷰
private struct MemoListContentView : View {
    @EnvironmentObject private var memoListViewModel : MemoListViewModel
    fileprivate var body: some View {
        VStack{
            HStack{
                Text("메모 목록")
                    .font(.system(size: 16, weight: .bold))
                    .padding(.leading, 20)
                Spacer()
            }
            ScrollView(.vertical) {
                VStack(spacing: 0){
                    Rectangle()
                        .fill(Color.gray1)
                        .frame(height: 1)
                    ForEach(memoListViewModel.memos, id:
                                \.self) { memo in
                        ListCellView(memo: memo)
                    }
                }
            }
        }
    }
}
//MARK: - 리스트 셀뷰
private struct ListCellView : View {
    @EnvironmentObject private var pathModel : PathModel
    @EnvironmentObject private var memoListViewModel : MemoListViewModel
    @State private var isRemoveSelected: Bool
    private var memo: Memo
    fileprivate init(
        isRemoveSelected: Bool = false,
        memo: Memo
    ){
        _isRemoveSelected = State(initialValue: isRemoveSelected)
        self.memo = memo
    }
    fileprivate var body: some View {
        Button(action: {
            pathModel.path.append(.memoView(isCreateMode: false, memo: memo))
        }, label: {
            VStack(spacing: 20) {
                HStack{
                    VStack(alignment: .leading, spacing: 5) {
                        Text(memo.title)
                            .font(.system(size: 16))
                            .foregroundColor(Color.bk)
                        Text(memo.convertedDate)
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    if memoListViewModel.isEditMemoMode {
                        Button(action: {
                            isRemoveSelected.toggle()
                            memoListViewModel.memoRemoveSelectedBoxTapped(memo)
                        }, label: {
                            isRemoveSelected ?  Image("checkVariant2") : Image("checkDefault")
                        })
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                Rectangle()
                    .fill(Color.gray1)
                    .frame(height: 1)
            }
        })
    }
}
//MARK: - 작성 버튼 뷰
private struct WriteMemoBtnView : View {
    @EnvironmentObject private var pathModel : PathModel
    fileprivate var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    pathModel.path.append(.memoView(isCreateMode: true, memo: nil))
                }, label: {
                    Image("WriteBtn")
                })
            }
        }
    }
}
struct MemoListView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListView()
            .environmentObject(PathModel())
            .environmentObject(MemoListViewModel())
    }
}
