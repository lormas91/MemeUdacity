//
//  CollectionViewController.swift
//  imagePicker
//
//  Created by Lorenzo Masucci on 10/04/2020.
//  Copyright © 2020 MorningWall. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
}
