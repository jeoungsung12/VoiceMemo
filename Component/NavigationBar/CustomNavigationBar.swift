//
//  CustomNavigationBar.swift
//  VoiceMemo
//
//  Created by 정성윤 on 2024/01/12.
//

import SwiftUI

struct CustomNavigationBar: View {
    let isDisplayLeftBtn : Bool
    let isDisplayRightBtn : Bool
    let leftBtnAction: () -> Void
    let rightBtnAction: () -> Void
    let rightBtnType: NavigationBtnType
    init(isDisplayLeftBtn: Bool = true, isDisplayRightBtn: Bool = true, leftBtnAction: @escaping () -> Void = {}, rightBtnAction: @escaping () -> Void = {}, rightBtnType: NavigationBtnType = .edit) {
        self.isDisplayLeftBtn = isDisplayLeftBtn
        self.isDisplayRightBtn = isDisplayRightBtn
        self.leftBtnAction = leftBtnAction
        self.rightBtnAction = rightBtnAction
        self.rightBtnType = rightBtnType
    }
    var body: some View {
        HStack{
            if isDisplayLeftBtn {
                Button(action: leftBtnAction, label: {Image(systemName: "arrow.left").foregroundColor(.bk)})
            }
            Spacer()
            if isDisplayRightBtn{
                Button(action: rightBtnAction, label: {
                    if rightBtnType == .close{
                        Image("close")} else {
                            Text(rightBtnType.rawValue)
                                .foregroundColor(.bk)
                        }
                    }
                )
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 20)
    }
}

struct CustomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar()
    }
}
