//
//  GraphWindowViiew.swift
//  GitUpGraph
//
//  Created by aship on 2021/01/31.
//

import SwiftUI

struct GraphWindowView: View {
    @State var generateImageCount = 0
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    saveFileDialog { url in
                        print("### saveFileDialog completion")
                        
                        urlOutputFile = url
                        self.generateImageCount += 1
                    }
                }) {
                    Text("save image")
                }
            }
            
            GraphView(gitFolderUrl: gitFolderUrl,
                      //       urlOutputFile: urlOutputFile,
                      generateImageCount: self.$generateImageCount)
        }
    }
    
    func saveFileDialog(completion: @escaping (_ url: URL) -> Void) {
        let savePanel = NSSavePanel()
        savePanel.message = "保存するで"
        savePanel.canCreateDirectories = true
        savePanel.showsTagField = false
        savePanel.allowedFileTypes = ["jpg"]
        savePanel.nameFieldStringValue = "ppp.jpg"
        
        savePanel.begin { (result) in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue {
                guard let url = savePanel.url
                else {
                    return
                }
                
                print(url.absoluteString)
                completion(url)
            }
        }
    }
}
