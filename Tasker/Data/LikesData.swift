//  LikesData.swift
//  Tasker
//
//  Created by Aleksej Shapran on 04.07.23

import Foundation

final class LikesData {
    
    private let likeKey = "like_key"
    
    func save(items: Set<String>) {
        let array = Array(items)
        UserDefaults.standard.set(array, forKey: likeKey)
    }
    
    func load() -> Set<String> {
        let array = UserDefaults.standard.array(forKey: likeKey) as? [String] ?? [String]()
        return Set(array)
    }
}
