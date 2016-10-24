//
//  ViewController.swift
//  PropertyListDemo
//
//  Created by Sebastian Ernst on 24/10/2016.
//  Copyright © 2016 KIS AGH. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    var albums: NSMutableArray = []
    var albumsDocPath: String = ""
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        let newDictionary = NSDictionary(dictionary:
            ["artist": "The Beatles",
            "title": "Abbey Road",
            "year": 1969,
            "genre": "rock",
            "rating": 5])
        albums.add(newDictionary)
        albums.write(toFile: albumsDocPath, atomically: true)
        textView.text.append("Adding record and saving to file.\n\n")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let plistPath = Bundle.main.path(forResource: "albums", ofType: "plist")!
        textView.text.append("Plist file is located in bundle at \(plistPath).\n\n")
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        textView.text.append("Documents directory path is \(documentsPath).\n\n")
        albumsDocPath = NSURL(fileURLWithPath: documentsPath).appendingPathComponent("albums.plist")!.path
        textView.text.append("Looking for plist file at \(albumsDocPath).\n\n")
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: albumsDocPath) {
            textView.text.append("Not found, copying from bundle...\n\n")
            try? fileManager.copyItem(atPath: plistPath, toPath: albumsDocPath)
        }
        else {
            textView.text.append("File found, no need to copy.\n\n")
        }
        albums = NSMutableArray(contentsOfFile: albumsDocPath)!
        textView.text.append("Loaded data:\n\(albums)\n\n")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

