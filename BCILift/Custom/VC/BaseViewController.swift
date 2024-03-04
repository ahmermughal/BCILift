//
//  BaseViewController.swift
//  BCILift
//
//  Created by Ahmer Mughal on 28.02.24.
//

import UIKit

class BaseViewController: UIViewController {

    private var loadingContainerView : UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func showLoadingView(){
        loadingContainerView = UIView(frame: view.bounds)
        view.addSubview(loadingContainerView)
        
        loadingContainerView.backgroundColor = .systemBackground
        loadingContainerView.alpha = 0
        
        UIView.animate(withDuration: 0.25){
            self.loadingContainerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        
        loadingContainerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: loadingContainerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: loadingContainerView.centerXAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView(){
        DispatchQueue.main.async {
            if(self.loadingContainerView != nil){
                self.loadingContainerView.removeFromSuperview()
                self.loadingContainerView = nil
            }
        }
        
    }
    
}
