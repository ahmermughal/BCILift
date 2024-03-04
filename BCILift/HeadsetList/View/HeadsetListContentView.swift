//
//  HeadsetListContentView.swift
//  BCILift
//
//  Created by Ahmer Mughal on 21.02.24.
//

import UIKit

class HeadsetListContentView: UIView {
    
    // MARK: UI Elements
    let tableView = UITableView()
    let scanButton = UIButton()
    let stopScanButton = UIButton()
    
    
    // MARK: Init Functions
    /// Initialize the view
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        /// Setup the view
        setupView()
        
        /// Setup the table view
        setupTableView()
                
        setupButtons()
        
        /// Layout the UI elements
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Private Functions
    /// Setup the view
    private func setupView() {
        /// Additional view setup can be done here if needed
    }
    
    /// Setup the table view
    private func setupTableView() {
        /// Set the background color of the table view to clear
        tableView.backgroundColor = .clear
    }

    
    private func setupButtons(){
        
        scanButton.setTitle("Scan", for: .normal)
        scanButton.setTitleColor(.label, for: .normal)
        scanButton.backgroundColor = .systemBlue
        scanButton.layer.cornerRadius = 8
        
        
        stopScanButton.setTitle("Stop Scan", for: .normal)
        stopScanButton.setTitleColor(.label, for: .normal)
        stopScanButton.backgroundColor = .systemBlue
        stopScanButton.layer.cornerRadius = 8
        
    }
    
    
    /// Layout the UI elements
    private func layoutUI() {
        let views = [tableView, scanButton, stopScanButton]
        
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            /// Set constraints to position the table view to cover the entire safe area of the view
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: self.scanButton.topAnchor),
            
            scanButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            scanButton.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 8),
            scanButton.trailingAnchor.constraint(equalTo: tableView.centerXAnchor, constant: -4),
            scanButton.heightAnchor.constraint(equalToConstant: 40),
            
            stopScanButton.bottomAnchor.constraint(equalTo: scanButton.bottomAnchor),
            stopScanButton.leadingAnchor.constraint(equalTo: tableView.centerXAnchor, constant: 4),
            stopScanButton.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -8),
            stopScanButton.heightAnchor.constraint(equalToConstant: 40),

            
        ])
    }
    
}
