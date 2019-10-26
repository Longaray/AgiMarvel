//
//  CharacterBioViewController.swift
//  AgiMarvel
//
//  Created by Rodrigo on 25/10/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import Foundation
import UIKit

protocol UITableViewControllerDelegate{
    func setCharacter(character: Character)
}

class CharacterBioViewController : UIViewController, UITableViewControllerDelegate, UITableViewDelegate{
 
    @IBOutlet weak var ivImg: UIImageView!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var lblName: UILabel!
    
    var delegate:UITableViewControllerDelegate?
    var characterBio: Character!

    func exitScreen() {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtDescription.text = characterBio.description
        self.lblName.text = characterBio.name
        let urlPath = characterBio.thumbnail.path
        let urlExtension = characterBio.thumbnail.ext
        let urlString = (urlPath! + "." + urlExtension!)
        
        let url = URL(string: urlString)
        let data = try? Data(contentsOf: url!)
        self.ivImg?.image = UIImage(data: data!)
        
        //Container


    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        //super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setCharacter( character: Character)
    {
        self.characterBio = character
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "characterComicsSegue")
        {
            //load the controller and test the trainer name before fliping screens
            let viewController = segue.destination as! CharacterComicsTableViewController
            viewController.setComics(comics: characterBio.comics)
        }
    }
}
