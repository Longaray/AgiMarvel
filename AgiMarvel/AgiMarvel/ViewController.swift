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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SVProgressHUD.show()
        
        //Populate list with all characters
        request.getCharacters(completionHandler: {characters,error  in
            guard error == nil else {
                return
            }
            self.charactersList = characters ?? []
            
            SVProgressHUD.dismiss()
        })
    }


}

