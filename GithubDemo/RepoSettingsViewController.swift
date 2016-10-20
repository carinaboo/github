//
//  RepoSettingsViewController.swift
//  GithubDemo
//
//  Created by Carina Boo on 10/19/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

protocol RepoSettingsViewControllerDelegate: class {
    func didSaveSearchSettings(sender: RepoSettingsViewController,
                               searchSettings: GithubRepoSearchSettings)
}

class RepoSettingsViewController: UIViewController {
    
    weak var delegate: RepoSettingsViewControllerDelegate?
    var searchSettings: GithubRepoSearchSettings!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var minStarsLabel: UILabel!
    @IBOutlet weak var minStarsSlider: UISlider!
    
    @IBAction func minStarsChanged(_ sender: UISlider) {
        let minStars = Int(minStarsSlider.value)
        searchSettings = GithubRepoSearchSettings.init(searchString: self.searchSettings.searchString, minStars: minStars)
        
        minStarsLabel.text = floatAsDecimalFormattedString(value:minStars)
    }
    @IBAction func didTapCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapSave(_ sender: UIButton) {
        let searchSettings = GithubRepoSearchSettings.init(searchString: self.searchSettings.searchString, minStars: self.searchSettings.minStars)
        delegate?.didSaveSearchSettings(sender: self, searchSettings: searchSettings)
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        minStarsSlider.minimumValue = 0.0
        minStarsSlider.maximumValue = 100000.0
        minStarsSlider.isContinuous = true
        
        minStarsSlider.value = Float(searchSettings.minStars)
        minStarsLabel.text = floatAsDecimalFormattedString(value:searchSettings.minStars)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - Private
    func floatAsDecimalFormattedString(value: Int) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:value))
    }

}
