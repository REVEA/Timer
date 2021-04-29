//
//  SettingView.swift
//  MyTimer
//
//  Created by ReDead on 2021/04/12.
//

import SwiftUI

struct SettingView: View {
    
    //永続化する秒数設定(初期値10)
    @AppStorage("timer_value") var timerValue = 10
    
    var body: some View {
        
        ZStack {
            //背景色
            Color("backgroundColor")
            //セーフエリアを超えて画面全体に配置
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack {
                Spacer()
                Text("\(timerValue)秒")
                    //文字サイズ指定
                    .font(.largeTitle)
                Spacer()
                //Picker
                Picker(selection: $timerValue, label: Text("選択")) {
                    Text("10")
                        .tag(10)
                    Text("20")
                        .tag(20)
                    Text("30")
                        .tag(30)
                    Text("40")
                        .tag(40)
                    Text("50")
                        .tag(50)
                    Text("60")
                        .tag(60)
                    Text("70")
                        .tag(70)
                    Text("80")
                        .tag(80)
                    Text("90")
                        .tag(90)
                    Text("100")
                        .tag(100)
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
