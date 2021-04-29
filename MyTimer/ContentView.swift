//
//  ContentView.swift
//  MyTimer
//
//  Created by ReDead on 2021/04/11.
//

import SwiftUI

struct ContentView: View {
    
    //タイマーの変数 作成
    @State var timerHandler : Timer?
    //カウントの変数 作成
    @State var count = 0
    //永続化する秒数設定(初期値10)
    @AppStorage("timer_value") var timerValue = 10
    //アラート表示有無
    @State var showAlert = false
    
    @State var flag = true
    
    var body: some View {
        NavigationView {
            
            ZStack {
                //View間の間隔を設定
                VStack(spacing: 30.0) {
                    
                    Text("残り\(timerValue - count)秒")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                    
                    HStack{
                        //スタートボタン
                        Button(action: {
                            //スタートボタンのアクション
                            flag = true
                            
                            //タイマーをカウントダウン開始する関数を呼び出し
                            startTimer()
                        }) {
                            
                            Text(flag ? "スタート" : "リスタート")
                                //文字サイズ指定
                                .font(.title2)
                                //文字色を指定
                                .foregroundColor(Color.white)
                                //幅と高さを指定
                                .frame(width: 130, height: 100)
                                //背景を指定
                                .background(Color("startColor"))
                                //円形に切り抜く
                                .clipShape(Circle())
                        }
                        //ストップボタン
                        Button(action: {
                            //ストップボタンのアクション
                            //timerHandlerをアンラップしてunwrapedTimerHandlerに代入
                            if let unwrapedTimerHandler = timerHandler {
                                
                                // もしタイマーが実行中であれば停止
                                if unwrapedTimerHandler.isValid == true {
                                    //タイマー停止
                                    unwrapedTimerHandler.invalidate()
                                    flag.toggle()
                                }
                            }
                            
                        }) {
                            
                            Text("ストップ")
                                //文字サイズ指定
                                .font(.title2)
                                //文字色を指定
                                .foregroundColor(Color.white)
                                //幅と高さを指定
                                .frame(width: 130, height: 100)
                                //背景を指定
                                .background(Color("stopColor"))
                                //円形に切り抜く
                                .clipShape(Circle())
                        }
                    }
                }
            }
            //画面が表示されるときに実行
            .onAppear() {
                // カウント(経過時間)の変数を初期化
                count = 0
            }
            
            //ナビゲーションバーにボタン追加
            .navigationBarItems(trailing:
                                    //ナビゲーション遷移
                                    NavigationLink(destination: SettingView()) {
                                        Text("秒数設定")
                                            .foregroundColor(Color.black)
                                    }
            )
            //状態変数showAlertがtrueで実行
            .alert(isPresented: $showAlert) {
                //アラート表示するためのレイアウトを記述
                //アラートを表示
                Alert(title: Text("終了"),
                      message: Text("タイマー終了時間です"),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
    
    //1秒毎に実行されてカウントダウンする
    func countDownTimer(){
        // count(経過時間)に+1していく
        count += 1
        
        //残り時間が0以下のとき、タイマーを止める
        if timerValue - count <= 0 {
            //タイマー停止
            timerHandler?.invalidate()
            //アラート表示
            showAlert = true
        }
    }
    
    //タイマーをカウントダウン開始する関数
    func startTimer(){
        //timerHandlerをアンラップしてunwrapedTimerHandlerに代入
        if let unwrapedTimerHandler = timerHandler {
            //もしタイマーが、実行中だったらスタートしない
            if unwrapedTimerHandler.isValid == true {
                //何も処理しない
                return
            }
        }
        
        //残り時間が0以下のとき、count(経過時間)を0に初期化する
        if timerValue - count <= 0 {
            //count(経過時間)を0に初期化する
            count = 0
        }
        
        //タイマーをスタート
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            
            //タイマー実行時に呼び出される
            //１秒毎に実行されてカウントダウンする関数を実行する
            countDownTimer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
