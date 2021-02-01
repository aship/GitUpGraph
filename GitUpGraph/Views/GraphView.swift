//
//  GraphView.swift
//  GitUpGraph
//
//  Created by aship on 2020/08/02.
//  Copyright © 2020 aship. All rights reserved.
//

import SwiftUI

struct GraphView: NSViewRepresentable {
    var gitFolderUrl: URL
    //  var urlOutputFile: URL
    @Binding var generateImageCount: Int
    
    func makeNSView(context: Context) -> NSScrollView {
        let graphView = GIGraphView()
        let options: GIGraphOptions = GIGraphOptions.preserveUpstreamRemoteBranchTips
        
        //  let strUrl = "/Volumes/data/home_catalina4/Documents/dev_seazoo/workers_app_ios"
        //let strUrl = "/Volumes/data/home_catalina4/Downloads/house_of_joy"
        //let strUrl = "/Volumes/data/home_catalina4/Downloads/covid19"
        // let strUrl = "/Volumes/data/home_catalina4/Downloads/git"
        // let strUrl = "/Volumes/data/home_catalina4/Downloads/spacely_web"
        
        let strUrl = self.gitFolderUrl.path
        
        print("strUrl \(strUrl)")
        
        do {
            let repository = try GCLiveRepository(existingLocalRepository: strUrl)
            
            graphView.graph = GIGraph(
                history: repository.history,
                options: options)
            
            let clipView = NSClipView()
            clipView.documentView = graphView
            
            let scrollView = NSScrollView()
            scrollView.autoresizingMask = [.width, .height]
            scrollView.contentView = clipView
            scrollView.hasVerticalScroller = true
            scrollView.hasHorizontalScroller = true
            scrollView.autohidesScrollers = false
            scrollView.allowsMagnification = true
            
            return scrollView
        } catch {
            return NSScrollView()
        }
    }
    
    func updateNSView(_ graphView: NSScrollView, context: Context) {
        print("### updateNSView")
        print(self.generateImageCount)
        
        if self.generateImageCount == countX {
            print("### generating image...")
            
            makePNGFromView(
                view: graphView.documentView!,
                url: urlOutputFile)
            
            countX += 1
            print("### generating image...fin")
        }
    }
}
