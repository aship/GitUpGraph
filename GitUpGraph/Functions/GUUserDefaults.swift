//
//  GUUserDefaults.swift
//  GitUpGraph
//
//  Created by aship on 2021/01/31.
//

import Foundation

let keyGitFolderUrls = "gitFolderUrls"

class GUUserDefaults {
    class func setGitFolderUrls(gitFolderUrls: [URL]) {
        let data = try! PropertyListEncoder().encode(gitFolderUrls)
        
        UserDefaults.standard.set(data, forKey: keyGitFolderUrls)
    }
    
    class func getGitFolderUrls() -> [URL] {
        do {
            guard let data = UserDefaults.standard.data(forKey: keyGitFolderUrls)
            else { return [] }
            
            let urls = try PropertyListDecoder().decode([URL].self, from: data)
            
            return urls
        } catch let e {
            print("Failed to getting properties from plist.")
            print("Reason: \(e)")
        }
        
        return []
    }
}
