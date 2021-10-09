//
//  Monitor.swift
//  iOS Assessment
//
//  Created by Ghalaab on 09/10/2021.
//

import Network

class Monitor {
    private let monitor: NWPathMonitor =  NWPathMonitor()

    init() {
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
}

extension Monitor {
    func startMonitoring(callBack: @escaping (_ isReachable: Bool) -> Void ) -> Void {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async { callBack(path.status == .satisfied) }
        }
    }
    
    func cancel() {
        monitor.cancel()
    }
}
