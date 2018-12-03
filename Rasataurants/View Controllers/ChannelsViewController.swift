//
//  ChannelsViewController.swift
//  Rasataurants
//
//  Created by Brian Lutz on 11/30/18.
//  Copyright © 2018 Gecko. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChannelsViewController: UITableViewController {
    
    private let currentUser: User
    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(style: .grouped)
        
        title = "Channels"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
