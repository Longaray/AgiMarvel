//
//  CharacterComicsTableViewController.swift
//  AgiMarvel
//
//  Created by Rodrigo on 25/10/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import Foundation
import UIKit

protocol CharacterComicsTableViewControllerDelegate{
    func setComics(comics: Comics)
}

class CharacterComicsTableViewController : UITableViewController, CharacterComicsTableViewControllerDelegate
{
    private var comics = Comics()
    @IBOutlet weak var tbtComicaTable:UITableView!
    
    func setComics(comics: Comics) {
        self.comics = comics
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Total characters server
        return self.comics.items.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
   {
        let cell = self.tbtComicaTable.dequeueReusableCell(withIdentifier: "ComicTableCell") as! ComicViewTableCell

        cell.lblName?.text = self.comics.items[indexPath.row].name
       
       return cell
   }

    
}
 
