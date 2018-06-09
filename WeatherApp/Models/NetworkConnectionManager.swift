//
//  NetworkConnectionManager.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/6.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import Reachability

class NetworkConnectionManager {
    var reachability: Reachability!
    static let shared = NetworkConnectionManager()
    
    private init() {
        
        reachability = Reachability()!

        do {
            try reachability.startNotifier()
        } catch {
            NSLog("Unable to start notifier")
        }
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func stopNotifier() -> Void {
        self.reachability.stopNotifier()
    }
    
    func isReachable(completion: @escaping (_ networkManger: NetworkConnectionManager, _ isReachable: Bool) -> Void) {
        let isReachable: Bool = self.reachability.connection != .none
        completion(self, isReachable)
    }

}
