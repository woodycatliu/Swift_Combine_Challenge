//
//  TimingDeviceViewController.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/8.
//

import UIKit

class TimingDeviceViewController: UIViewController {
    typealias CancelStyle = TimingDeviceStyle.ButtonStyle.CancelButton
    typealias StartStyle = TimingDeviceStyle.ButtonStyle.StartButton
    typealias ContinueStyle = TimingDeviceStyle.ButtonStyle.ContinueButton
    
    private let viewModel: TimingDeviceViewModel = TimingDeviceViewModel()
    
    private lazy var datePicker: UIPickerView = {
        let dp = UIPickerView()
        dp.delegate = self
        dp.dataSource = self
        return dp
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
            topGuid.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2 / 5)
        ])
        
        view.addSubview(datePicker)
        datePicker.anchor(top: nil, leading: topGuid.leadingAnchor, bottom: nil, trailing: topGuid.trailingAnchor, padding: .init(top: 0, left: UIScreen.width / 9, bottom: 0, right: UIScreen.width / 9))
        datePicker.centerYTo(topGuid.centerYAnchor)
        datePicker.heightAnchor.constraint(equalTo: datePicker.widthAnchor, multiplier: 2/3).isActive = true
        
        view.addSubview(cancelBtn)
        cancelBtn.anchor(top: topGuid.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 15, bottom: 0, right: 0) , size: .init(width: 67, height: 67))
    }
    
    fileprivate func configureTimeStampLabel() {
        let rowWidth = (datePicker.bounds.width) / 3
        let hrLabel = pickLabel(text: "小時")
        view.addSubview(hrLabel)
        hrLabel.centerYTo(datePicker.centerYAnchor)
        hrLabel.leadingAnchor.constraint(equalTo: datePicker.leadingAnchor, constant: 60).isActive = true
        let minLabel = pickLabel(text: "分鐘")
        view.addSubview(minLabel)
        minLabel.centerYTo(datePicker.centerYAnchor)
        minLabel.centerXTo(datePicker.leadingAnchor, constant: rowWidth *  7 / 4)
        
        let secLabel = pickLabel(text: "秒")
        view.addSubview(secLabel)
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
