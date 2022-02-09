//
//  TimingDeviceViewController.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/8.
//

import UIKit

class TimingDeviceViewController: UIViewController {
    typealias CancelStyle = TimeDeviceMaterial.ButtonStyle.CancelButton
    typealias StartStyle = TimeDeviceMaterial.ButtonStyle.StartButton
    typealias ContinueStyle = TimeDeviceMaterial.ButtonStyle.ContinueButton
    
    private let viewModel: TimingDeviceViewModel = TimingDeviceViewModel()
    
    private lazy var datePicker: UIPickerView = {
        let dp = UIPickerView()
        dp.delegate = self
        dp.dataSource = self
        return dp
    }()
    
    private lazy var countdownViewContainer: UIView = {
        let cv = UIView()
        cv.isHidden = false
        cv.addSubview(timingCountdownView)
        cv.backgroundColor = .clear
        timingCountdownView.anchor(top: cv.topAnchor, leading: cv.leadingAnchor, bottom: nil, trailing: cv.trailingAnchor, padding: .init(top: 15, left: 18, bottom: 0, right: 18))
        timingCountdownView.heightAnchor.constraint(equalTo: timingCountdownView.widthAnchor).isActive = true
        return cv
    }()
    
    private lazy var timingCountdownView: TimingCountdownView = {
        let cv = TimingCountdownView()
        cv.backgroundColor = .clear
        cv.maxTimeInterval(10)
            .setCurrentTiming(0)
        return cv
    }()
    
    private let cancelBtn: ConcentricCircleStyleButton = {
       let btn = ConcentricCircleStyleButton()
        btn.circleColor = CancelStyle.backgroundColor
        btn.circileHighlightedColor = CancelStyle.highlightlyBackgrounColor
        btn.setTitle(CancelStyle.title, for: .normal)
        btn.setTitle(CancelStyle.title, for: .highlighted)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        btn.isEnabled = false
        btn.setTitleColor(CancelStyle.disableTitleColor, for: .disabled)
        return btn
    }()
    
    private let playBtn: ConcentricCircleStyleButton = {
       let btn = ConcentricCircleStyleButton()
        btn.circleColor = StartStyle.backgroundColor
        btn.circileHighlightedColor = StartStyle.highlightlyBackgrounColor
        btn.setTitle(StartStyle.title, for: .normal)
        btn.setTitle(StartStyle.title, for: .highlighted)
        btn.setTitleColor(StartStyle.titleColor, for: .normal)
        btn.setTitleColor(StartStyle.titleColor, for: .highlighted)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .dark
        configureMainUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureTimeStampLabel()
    }
    
    fileprivate func configureMainUI() {
        let topGuid = UILayoutGuide()
        view.addLayoutGuide(topGuid)
        NSLayoutConstraint.activate([
            topGuid.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topGuid.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            topGuid.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            topGuid.heightAnchor.constraint(equalTo: view.widthAnchor , multiplier: 1.05)
        ])
        
        view.addSubview(datePicker)
        datePicker.anchor(top: nil, leading: topGuid.leadingAnchor, bottom: nil, trailing: topGuid.trailingAnchor, padding: .init(top: 0, left: UIScreen.width / 9, bottom: 0, right: UIScreen.width / 9))
        datePicker.centerYTo(topGuid.centerYAnchor, constant: -30)
        datePicker.heightAnchor.constraint(equalTo: datePicker.widthAnchor, multiplier: 2/3).isActive = true
        
        view.addSubview(countdownViewContainer)
        countdownViewContainer.anchor(top: topGuid.topAnchor, leading: topGuid.leadingAnchor, bottom: topGuid.bottomAnchor, trailing: topGuid.trailingAnchor)
        
        view.addSubview(cancelBtn)
        cancelBtn.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: topGuid.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 0, right: 0) , size: .init(width: 70, height: 70))
        
        
        view.addSubview(playBtn)
        playBtn.anchor(top: nil, leading: nil, bottom: topGuid.bottomAnchor, trailing: topGuid.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 10), size: .init(width: 70, height: 70))
        
        let sublabel = UILabel()
        view.addSubview(sublabel)
        sublabel.backgroundColor = .systemGray.withAlphaComponent(0.15)
        sublabel.layer.cornerRadius = 5
        sublabel.layer.masksToBounds = true
        sublabel.textColor = .white.withAlphaComponent(0.8)
        sublabel.adjustsFontSizeToFitWidth = true
        sublabel.text = "    假裝我是鈴聲選擇"
        sublabel.anchor(top: topGuid.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 10, bottom: 0, right: 10), size: .init(width: 0, height: 50))
        
    }
    
    fileprivate func configureTimeStampLabel() {
        let rowWidth = (datePicker.bounds.width) / 3
        let hrLabel = pickLabel(text: "小時")
        datePicker.addSubview(hrLabel)
        hrLabel.centerYTo(datePicker.centerYAnchor)
        hrLabel.leadingAnchor.constraint(equalTo: datePicker.leadingAnchor, constant: 60).isActive = true
        let minLabel = pickLabel(text: "分鐘")
        datePicker.addSubview(minLabel)
        minLabel.centerYTo(datePicker.centerYAnchor)
        minLabel.centerXTo(datePicker.leadingAnchor, constant: rowWidth *  7 / 4)
        
        let secLabel = pickLabel(text: "秒")
        datePicker.addSubview(secLabel)
        secLabel.centerYTo(datePicker.centerYAnchor)
        secLabel.leadingAnchor.constraint(equalTo: datePicker.leadingAnchor, constant: rowWidth *  10 / 4 + 6).isActive = true
    }
    

}

extension TimingDeviceViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.selected(in: component, row: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerView.bounds.height / 6.8
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let lb: UILabel = (view as? UILabel) ?? UILabel()
        lb.textAlignment = .left
        lb.font = .systemFont(ofSize: 20, weight: .medium)
        lb.text = viewModel.pickerViewModel(in: component)?.text(row)
        return lb
    }
}

extension TimingDeviceViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return viewModel.numberOfComponents
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.pickerViewModel(in: component)?.count ?? 0
    }

}

extension TimingDeviceViewController {
    func pickLabel(text: String?)-> UILabel {
        let lb = UILabel()
        lb.text = text
        lb.textAlignment = .left
        lb.font = .systemFont(ofSize: 17, weight: .medium)
        return lb
    }
}
