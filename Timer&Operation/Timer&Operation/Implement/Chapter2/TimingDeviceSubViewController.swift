//
//  TimingDeviceSubViewController.swift
//  Timer&Operation
//
//  Created by Woody on 2022/2/24.
//

import Foundation
import Combine

class TimingDeviceSubViewController: TimingDeviceViewController {
    
    var subViewModel: TimingDeviceSubViewModel? {
        return viewModel as? TimingDeviceSubViewModel
    }
    
    override func viewDidLoad() {
        viewModel = TimingDeviceSubViewModel()
        super.viewDidLoad()
    }
    
    func bindingViewModel() {
        subViewModel?.$timeStamp
            .receive(on: DispatchQueue.main)
            .assign(to: <#T##((Published<TimeInterval>.Publisher.Output) -> ())##((Published<TimeInterval>.Publisher.Output) -> ())##(Published<TimeInterval>.Publisher.Output) -> ()#>)
            
        
        
        
        
    }
    
    
    
}
