//
//  HeadsetListVC.swift
//  BCILift
//
//  Created by Ahmer Mughal on 21.02.24.
//

import UIKit

class HeadsetListVC: BaseViewController {

    private static let CELLREUSEID = "TableViewCell"
    
    private let contentView = HeadsetListContentView()

    private let museManager : MuseManager
    
    init(museManager: MuseManager) {
        self.museManager = MuseManager()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Override Functions
    /// Loads the content view as the parent view of the view controller
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupVC()
        configureTableView()
        configureButtonTapGestures()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        museManager.delegate = self
    }
    
    @objc private func scanButtonTapped(){
        showLoadingView()
        museManager.startScanning()
        contentView.tableView.reloadData()
       // logMuse(str: "Scanning Started")
    }
    
    @objc private func stopScanButtonTapped(){
        museManager.stopScanning()
        contentView.tableView.reloadData()
        //logMuse(str: "Scanning Stopped")

    }
    
    private func setupVC(){
        title = "Select Headset 🥽"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    
    
    /// Configure the table view
    private func configureTableView() {
        /// Register the character table view cell class
        contentView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: HeadsetListVC.CELLREUSEID)

        /// Set the table view datasource to self
        /// so we can populate the tableview
        contentView.tableView.dataSource = self
        
        /// Set the table view delegate to self
        /// so tap gestures on tableview rows can be listened to
        contentView.tableView.delegate = self
    }
    
    private func configureButtonTapGestures(){
        
        contentView.scanButton.addTarget(self, action: #selector(scanButtonTapped), for: .touchUpInside)
        contentView.stopScanButton.addTarget(self, action: #selector(stopScanButtonTapped), for: .touchUpInside)
        
    }
    
    private func navigateToInstructionsVC(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.dismissLoadingView()
            let instructionsVC = InstructionsVC(museManager: self.museManager)
            self.navigationController?.pushViewController(instructionsVC, animated: true)
        }

    }

}

extension HeadsetListVC : MuseManagerDelegate {
    
    func museListUpdated() {
        dismissLoadingView()
        contentView.tableView.reloadData()
    }

    
    func museConnected() {
        navigateToInstructionsVC()
    }
    
    
}

extension HeadsetListVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return museManager.availableMuseDevices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HeadsetListVC.CELLREUSEID)
        
        
        let muses = museManager.availableMuseDevices
        
        if indexPath.row < muses.count{
            
            let muse = muses[indexPath.row]
            cell?.textLabel?.text = "\(muse.getName()) - V\(muse.getModel().rawValue)"
            
        }
                
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let muses = museManager.availableMuseDevices
        
        if indexPath.row < muses.count{
            
            let muse = muses[indexPath.row]
            
            museManager.connect(to: muse)
            showLoadingView()
            
            museManager.logMuse(str: "======Choose to connect muse \(muse.getName()) \(muse.getMacAddress())======\n")
            
        }
        
    }
    
    
}

