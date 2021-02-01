//
//  ContentView.swift
//  GitUpGraph
//
//  Created by aship on 2020/07/26.
//  Copyright © 2020 aship. All rights reserved.
//

import SwiftUI

var gitFolderUrl = URL(fileURLWithPath: "")
var urlOutputFile = URL(fileURLWithPath: "")
var countX = 1

struct ContentView: View {
    @Environment(\.openURL) var openURL
    
    @State var gitFolderUrls: [URL] = GUUserDefaults.getGitFolderUrls()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    openFolderDialog { url in
                        gitFolderUrl = url
                        
                        print("OPENING FROM FILE DIALOGUE URL: \(url)")
                        
                        self.gitFolderUrls.append(url)
                        GUUserDefaults.setGitFolderUrls(gitFolderUrls: self.gitFolderUrls)
                        
                        if let url = URL(string: "gitupgraph://graph_window") {
                            openURL(url)
                        }
                    }
                }) {
                    Text("open git folder")
                }
            }
            
            List {
                ForEach(self.gitFolderUrls.indices, id: \.self) { index in
                    Button(action: {
                        let url: URL = self.gitFolderUrls[index]
                        gitFolderUrl = url
                        
                        print("OPENING FROM LIST URL: \(url)")
                        
                        if let windowUrl = URL(string: "gitupgraph://graph_window") {
                            openURL(windowUrl)
                        }
                    }){
                        let url: URL = self.gitFolderUrls[index]
                        Text(url.path)
                    }
                    
                    Divider()
                }
            }
        }
    }
}

func openFolderDialog(completion: @escaping (_ url: URL) -> Void) {
    let openPanel = NSOpenPanel()
    openPanel.message = "select git folder"
    openPanel.canChooseFiles = false
    openPanel.canChooseDirectories = true
    openPanel.allowsMultipleSelection = false
    // openPanel.allowedFileTypes = ["gif","jpg","png"]
    
    openPanel.begin(completionHandler: { (num) -> Void in
        if num == NSApplication.ModalResponse.OK {
            for url in openPanel.urls {
                let filePath: String! = url.path
                
                print("### open dir \(String(describing: filePath))")
                completion(url)
            }
        } else if num == NSApplication.ModalResponse.cancel {
            NSLog("Canceled")
        }
    })
}
