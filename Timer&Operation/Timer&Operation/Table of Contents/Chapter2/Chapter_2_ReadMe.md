#### Timing Device   

##### Create a timing device like the ios clock app.

> 完成定時頁面如同時鐘 app     
> 點擊開始時顯示倒數畫面，請參考時鐘 app

> datePicker: 時間選擇   
> timingCountdownView: 倒數計畫面   
> playBtn: 切換開始/繼續/暫停，不重新倒數   
> cancelBtn: 取消，停止暫停回到選取時間。(停止倒數時，cancelBtn必須 disable)    
> viewModel: 已經實作 pickerView dataSource 與 delefate      
> 專注在定時時間的 Combine 資料流與事件流的轉換   
> 可參考 Combine.Operator: scan, map, filter 等   

- |倒數計時|: timingCountdownView [(TimingCountdownView)](https://github.com/woodycatliu/Swift_Combine_Challenge/blob/main/Timer%26Operation/Timer%26Operation/Table%20of%20Contents/Chapter2/View/TimingCountdownView.swift)
- |開始/繼續/暫停|: playBtn [(ConcentricCircleStyleButton)](https://github.com/woodycatliu/Swift_Combine_Challenge/blob/main/Timer%26Operation/Timer%26Operation/Table%20of%20Contents/Chapter2/View/ConcentricCircleStyleButton.swift)
- |取消|: cancelBtn [(ConcentricCircleStyleButton)](https://github.com/woodycatliu/Swift_Combine_Challenge/blob/main/Timer%26Operation/Timer%26Operation/Table%20of%20Contents/Chapter2/View/ConcentricCircleStyleButton.swift)
- [ButtonStyle](https://github.com/woodycatliu/Swift_Combine_Challenge/blob/main/Timer%26Operation/Timer%26Operation/Table%20of%20Contents/Chapter2/Material/TimeDeviceButtonStyle.swift)
