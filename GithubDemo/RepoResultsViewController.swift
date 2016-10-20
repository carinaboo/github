//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RepoSettingsViewControllerDelegate {

    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings(searchString: nil, minStars: 0)

    var repos: [GithubRepo]!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set UITableView data source and delegate
        tableView.dataSource = self;
        tableView.delegate = self;
        
        // Auto size cells
        tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = UITableViewAutomaticDimension

        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in
            
            // Store repos
            self.repos = newRepos
            
            self.tableView.reloadData()
            
            // Print the returned repositories to the output window
            for repo in newRepos {
                print(repo)
            }   

            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }

// MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let repos = repos {
            return repos.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as! RepoCell

        let repo = repos![(indexPath as NSIndexPath).row]
        cell.setData(githubRepo: repo)

        return cell
    }

// MARK: - RepoSettingsViewControllerDelegate
    func didSaveSearchSettings(sender: RepoSettingsViewController,
                               searchSettings: GithubRepoSearchSettings) {
        self.searchSettings = searchSettings
        doSearch()
    }
    
// MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "RepoResultsToSettings") {
            let repoResultsVC = segue.destination as! RepoSettingsViewController
            repoResultsVC.delegate = self
            repoResultsVC.searchSettings = searchSettings
        }
    }
}

// MARK: - UISearchBarDelegate
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true;
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true;
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
