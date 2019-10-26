//
//  CharacterTableViewController.swift
//  AgiMarvel
//
//  Created by Rodrigo on 24/10/19.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import Foundation

import UIKit
import SVProgressHUD

class CharacterTableViewController: UITableViewController, UITableViewDataSourcePrefetching
{

    @IBOutlet weak var tbtTable:UITableView!
    //@IBOutlet weak var btnConfirm:UIButton!
    
    //var delegate:CharacterTableViewControllerDelegate?
    private var characterList  = [Character]()
    private var request = HttpRequest()
    private var offSet = 0
    private var totalCharacters = 0
    //var selectedType = Type()
    
   override func viewDidLoad() {
        super.viewDidLoad()
        self.offSet = 0
        if #available(iOS 10.0, *) {
            self.tbtTable.prefetchDataSource = self
        } else {
            // Fallback on earlier versions
        }
    
        SVProgressHUD.show()
        
        //Get total of charaters
        request.getTotalCharacters(completionHandler: {total,error  in
            guard error == nil else {
                return
            }
            self.totalCharacters = total
            self.tbtTable.reloadData()
            //SVProgressHUD.dismiss()
        })
        
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Total characters server
        return self.totalCharacters
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tbtTable.dequeueReusableCell(withIdentifier: "CharacterTableCell") as! CharacterViewTableCell

        if(indexPath.row < self.characterList.count)
        {
            cell.lblName?.text = self.characterList[indexPath.row].name
            cell.lblName?.isHidden = false
            let urlPath = self.characterList[indexPath.row].thumbnail.path
            let urlExtension = self.characterList[indexPath.row].thumbnail.ext
            let urlString = (urlPath! + "." + urlExtension!)
            
            let url = URL(string: urlString)
            let data = try? Data(contentsOf: url!)
            cell.ivImg?.image = UIImage(data: data!)
            cell.tag = indexPath.row

        }
        
        return cell
    }
 
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        //SVProgressHUD.show()
        
        if indexPaths.contains(where: isLoadingCell) {
            
            //Populate list with all characters
            request.getCharacters(offset: String(self.offSet), completionHandler: {characters,error  in
              guard error == nil else {
                  return
              }
                self.characterList.append(contentsOf:(characters ?? []))

                self.tbtTable.reloadData()
                SVProgressHUD.dismiss()
          })
            self.offSet+=20
        }
    }
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        //print( indexPath.row)
        return (indexPath.row >= self.characterList.count)
    }

    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
      
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CharacterBioViewController") as! CharacterBioViewController
        controller.setCharacter(character: self.characterList[indexPath.row])

        self.present(controller, animated: true, completion: nil)
        
    }
    
}

