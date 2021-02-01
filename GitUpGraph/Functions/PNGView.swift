//
//  PNGView.swift
//  GitUpGraph
//
//  Created by aship on 2020/07/27.
//  Copyright © 2020 aship. All rights reserved.
//

import Cocoa

func makePNGFromView(view: NSView, url: URL) {
    let rep = view.bitmapImageRepForCachingDisplay(in: view.bounds)!
    
    view.cacheDisplay(in: view.bounds, to: rep)
    
    if let data = rep.representation(
        using: NSBitmapImageRep.FileType.jpeg,
        properties: [:])
    {
        
        //  let strUrl = "/Volumes/data/home_catalina4/Downloads/git.png"
        //  let urlPath = URL(fileURLWithPath: strUrl)
        let urlPath = url
        
        do {
            try data.write(to: urlPath)
        } catch {
            print("Unexpected error: \(error).")
        }
    }
}
