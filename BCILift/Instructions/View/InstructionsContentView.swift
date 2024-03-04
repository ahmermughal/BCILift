//
//  InstructionsContentView.swift
//  BCILift
//
//  Created by Ahmer Mughal on 21.02.24.
//

import UIKit

class InstructionsContentView: UIView {

    let containerView = UIView()
    let instructionsLabel = UILabel()
    let button = UIButton()
    
    // MARK: Init Functions
    /// Initialize the view
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.backgroundColor = .black
        /// Setup the containerView
        setupContainerView()
        
        /// Setup instruction label
        setupInstructionLabel()
        
        setupButton()
        
        /// Layout the UI elements
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(){
        button.setTitle("Reset", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBlue
    }
    
    private func setupContainerView(){
        
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        
    }
    
    private func setupInstructionLabel(){
        
        instructionsLabel.textColor = .white
        instructionsLabel.textAlignment = .center
        instructionsLabel.numberOfLines = 0
        instructionsLabel.text = "hello There this is a test message"
        
    }
    
    private func layoutUI(){
        
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(instructionsLabel)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button)
        
        
        NSLayoutConstraint.activate([

            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            
            instructionsLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            instructionsLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            instructionsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            instructionsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            instructionsLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            instructionsLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),

            
            button.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 16),
            button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 80)
            


        ])
        
    }
    
    

}
