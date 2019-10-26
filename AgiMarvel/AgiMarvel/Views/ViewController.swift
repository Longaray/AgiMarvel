//
//  ViewController.swift
//  AgiMarvel
//
//  Created by Rodrigo on 23/10/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController {

    private var request = HttpRequest()
    private var charactersList = [Character]()

    @IBOutlet weak var characterTableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}

