//
//  ViewController.swift
//  GetTopViewController
//
//  Created by Salman Biljeek on 1/25/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .secondarySystemBackground
        
        let pushButton: UIButton = {
            var configuration = UIButton.Configuration.filled()
            var container = AttributeContainer()
            container.font = .boldSystemFont(ofSize: 18)
            container.foregroundColor = .white
            configuration.attributedTitle = AttributedString("Push", attributes: container)
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25)
            configuration.baseBackgroundColor = .systemIndigo
            configuration.cornerStyle = .capsule
            
            let button = UIButton(configuration: configuration, primaryAction: nil)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(self.handlePush), for: .touchUpInside)
            return button
        }()
        
        let printButton: UIButton = {
            var configuration = UIButton.Configuration.filled()
            var container = AttributeContainer()
            container.font = .boldSystemFont(ofSize: 18)
            container.foregroundColor = .systemBackground
            configuration.attributedTitle = AttributedString("Print Top VC Index", attributes: container)
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25)
            configuration.baseBackgroundColor = .label
            configuration.cornerStyle = .capsule
            
            let button = UIButton(configuration: configuration, primaryAction: nil)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(self.handlePrintTopVCIndex), for: .touchUpInside)
            return button
        }()
        
        let buttonsStackView = UIStackView(arrangedSubviews: [
            pushButton,
            printButton
        ])
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 10
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(buttonsStackView)
        buttonsStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        buttonsStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    @objc fileprivate func handlePush() {
        let viewController2 = UIViewController()
        viewController2.view.backgroundColor = .systemBackground
        let printButton: UIButton = {
            var configuration = UIButton.Configuration.filled()
            var container = AttributeContainer()
            container.font = .boldSystemFont(ofSize: 18)
            container.foregroundColor = .systemBackground
            configuration.attributedTitle = AttributedString("Print Top VC Index", attributes: container)
            configuration.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 25, bottom: 15, trailing: 25)
            configuration.baseBackgroundColor = .label
            configuration.cornerStyle = .capsule
            
            let button = UIButton(configuration: configuration, primaryAction: nil)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(self.handlePrintTopVCIndex), for: .touchUpInside)
            return button
        }()
        
        printButton.translatesAutoresizingMaskIntoConstraints = false
        viewController2.view.addSubview(printButton)
        printButton.centerXAnchor.constraint(equalTo: viewController2.view.centerXAnchor).isActive = true
        printButton.centerYAnchor.constraint(equalTo: viewController2.view.centerYAnchor).isActive = true
        self.navigationController?.pushViewController(viewController2, animated: true)
    }
    
    @objc func handlePrintTopVCIndex() {
        if let topController = UIApplication.getTopViewController() {
            if let index = self.navigationController?.viewControllers.firstIndex(of: topController) {
                print(index)
            }
        }
    }
}

extension UIApplication {
    class func mainWindow() -> UIWindow? {
        let window = UIApplication.shared.connectedScenes.filter { $0.activationState == .foregroundActive }.first(where: { $0 is UIWindowScene }).flatMap({ $0 as? UIWindowScene })?.windows.first(where: \.isKeyWindow)
        return window
    }
    
    class func getTopViewController(base: UIViewController? = UIApplication.mainWindow()?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
