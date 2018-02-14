//
//  ViewController.swift
//  ImageLoader
//
//  Created by Andrew Chupin on 14.02.2018.
//  Copyright © 2018 Andrew Chupin. All rights reserved.
//

import UIKit
import Dispatch

class PlaceholderViewController: UITableViewController {
    
    lazy var imageLoader: ImageLoader = PlaceholderImageLoader()
    let multiplayer = 1

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNumber
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! PlaceholderTableViewCell
        cell.imageView?.image = nil
        let urlPath = baseImageUrl + String(indexPath.row + multiplayer)
        imageLoader.loadImage(by: PlaceholderImageRequest(url: urlPath, cell: cell))
        return cell
    }

}
