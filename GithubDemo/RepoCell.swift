//
//  RepoCell.swift
//  GithubDemo
//
//  Created by Carina Boo on 10/17/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import AFNetworking

class RepoCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    
    @IBOutlet weak var starsIcon: UIImageView!
    @IBOutlet weak var forksIcon: UIImageView!

    func setData(githubRepo: GithubRepo) {
        if let ownerAvatar = githubRepo.ownerAvatarURL {
           self.avatarImageView.setImageWith(URL(string: ownerAvatar)!);
        }
        if let owner = githubRepo.ownerHandle {
            self.ownerLabel.text = owner
        }
        if let name = githubRepo.name {
            self.nameLabel.text = name
        }
        if let description = githubRepo.repoDescription {
            self.descriptionLabel.text = description
        }
        if let stars = githubRepo.stars {
            self.starsLabel.text = String(stars)
        }
        if let forks = githubRepo.forks {
            self.forksLabel.text = String(forks)
        }
    }
    
}
