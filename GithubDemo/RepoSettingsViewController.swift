//
//  RepoSettingsViewController.swift
//  GithubDemo
//
//  Created by Carina Boo on 10/19/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class RepoSettingsViewController: UIViewController {
    
//    var settings: GithubRepoSearchSettings!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var minStarsLabel: UILabel!
    @IBOutlet weak var minStarsSlider: UISlider!
    
    @IBAction func minStarsChanged(_ sender: UISlider) {
        let currentValue = Int(minStarsSlider.value)
        print("Slider changing to \(currentValue) ?")
        minStarsLabel.text = "\(currentValue) stars"
    }
    @IBAction func didTapCancel(_ sender: UIButton) {
        print("cancel")
    }
    @IBAction func didTapSave(_ sender: UIButton) {
        print("save")
    }
    
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder)
//        fatalError("init(coder:) has not been implemented")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        minStarsSlider.minimumValue = 0.0
        minStarsSlider.maximumValue = 100000.0
        minStarsSlider.isContinuous = true
        minStarsSlider.value = 100.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
