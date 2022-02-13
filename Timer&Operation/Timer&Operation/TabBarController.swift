//
//  TabBarController.swift
//  Timer&Operation
//
//  Created by Woody Liu on 2022/2/13.
//

import UIKit

class TabBarController: UITabBarController {
    typealias TabBarType = TabBarSubViewControllerType
    let subViewControllersTypes: [TabBarType] = [.c1, .c2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = subViewControllersTypes.map { configureViewController($0) }
        appearanceTabarColor()
    }
    
    fileprivate func appearanceTabarColor() {
        if #available(iOS 15, *) {
            let appearance = UITabBarAppearance()
                        
            appearance.configureWithOpaqueBackground()
            
            appearance.compactInlineLayoutAppearance.selected.iconColor = TabBarType.highlightlyTinted
            appearance.compactInlineLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: TabBarType.highlightlyTinted]
            
            appearance.compactInlineLayoutAppearance.normal.iconColor = TabBarType.normalTinted
            appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: TabBarType.normalTinted]
            
            appearance.inlineLayoutAppearance.selected.iconColor = TabBarType.highlightlyTinted
            appearance.inlineLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: TabBarType.highlightlyTinted]
            
            appearance.inlineLayoutAppearance.normal.iconColor = TabBarType.normalTinted
            appearance.inlineLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: TabBarType.normalTinted]
            
            appearance.stackedLayoutAppearance.selected.iconColor = TabBarType.highlightlyTinted
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: TabBarType.highlightlyTinted]
            
            appearance.stackedLayoutAppearance.normal.iconColor = TabBarType.normalTinted
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: TabBarType.normalTinted]
            
            appearance.backgroundColor = .black.withAlphaComponent(0.9)
            
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        
            return
        }
        
        tabBar.unselectedItemTintColor = TabBarType.normalTinted
        tabBar.tintColor = TabBarType.highlightlyTinted
        
    }
    
    fileprivate func configureViewController(_ type: TabBarType)-> UIViewController {
        let vc = type.viewController
        let style = type.barItemStyle
        let barItem = UITabBarItem(title: style.title, image: style.normalImage, selectedImage: style.highlightlyImage)
        vc.tabBarItem = barItem
        return vc
    }
}

enum TabBarSubViewControllerType: Int, CaseIterable {
    case c1, c2
    var viewController: UIViewController {
        switch self {
        case .c1:
            return navigationControllerSetting(StopWatchSubClassViewController())
        case .c2:
            return navigationControllerSetting(TimingDeviceViewController())
        }
    }
    
    var barItemStyle: Self.BarItemStyle {
        switch self {
        case .c1:
            return .chapter1
        case .c2:
            return .chapter2
        }
    }
    static let highlightlyTinted: UIColor = .white
    static let normalTinted: UIColor = .systemGray2
}

extension TabBarSubViewControllerType {
    
    fileprivate func navigationControllerSetting(_ vc: UIViewController)-> UINavigationController {
        return UINavigationController(rootViewController: vc)
    }
}
extension TabBarSubViewControllerType {
    struct BarItemStyle {
        var title: String?
        var normalImage: UIImage?
        var highlightlyImage: UIImage?
    }
}

extension TabBarSubViewControllerType.BarItemStyle {
    static let chapter1: Self = .init(title: "ch1", normalImage: .init(systemName: "clock.arrow.2.circlepath")?.withTintColor(.systemGray2), highlightlyImage: .init(systemName: "clock.arrow.2.circlepath")?.imgWithNewSize(size: .init(width: 38, height: 33)))
    
    static let chapter2: Self = .init(title: "ch2", normalImage: .init(systemName: "cursorarrow.click.badge.clock")?.withTintColor(.systemGray2), highlightlyImage: .init(systemName: "cursorarrow.click.badge.clock")?.imgWithNewSize(size: .init(width: 38, height: 38)))
}

extension UIApplication {
    static var isThereNotch: Bool {
        let bottomInset: CGFloat
        if #available(iOS 15.0, *) {
            bottomInset = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets.bottom ?? 0
        } else {
            bottomInset = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets.bottom ?? 0
        }
        return bottomInset != 0
    }
}

