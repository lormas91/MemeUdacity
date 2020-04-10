//
//  sentMemesTable.swift
//  imagePicker
//
//  Created by Lorenzo Masucci on 10/04/2020.
//  Copyright © 2020 MorningWall. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
       var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    

    
    override func viewDidLoad() {

    }
    
    override func viewWillAppear(_ animated: Bool) {
    
    }

    @objc func push(){
        let controller = storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
        present(controller, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")
        let memes = self.memes[indexPath.row]
        cell?.textLabel?.text = memes.topText
        cell?.imageView?.image = memes.memedImage
        return cell!
    }
}
