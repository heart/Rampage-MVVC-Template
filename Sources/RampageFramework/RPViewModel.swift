//
//  RPViewModel.swift
//  boodaBEST
//
//  Created by Narongrit Kanhanoi on 8/9/2563 BE.
//  Copyright © 2563 3dsinteractive. All rights reserved.
//

#if !os(macOS)
    import UIKit

    open class RPViewModel {

        public init() {

        }

        public typealias OnWatch = (RPModel, RPServiceRequest) -> Void
        public typealias OnLoading = (Bool, RPServiceRequest) -> Void

        private var watchListeners: [OnWatch] = []
        private var loadingListeners: [OnLoading] = []

        public func assign(request: RPServiceRequest) {
            onRequest(request: request)
        }

        open func onRequest(request: RPServiceRequest) {

        }

        public func watch(watchClousure: @escaping OnWatch) {
            watchListeners.append(watchClousure)
        }

        public func loading(loadingClousure: @escaping OnLoading) {
            loadingListeners.append(loadingClousure)
        }

        public func dispatch(model: RPModel, request: RPServiceRequest) {
            watchListeners.forEach { $0(model, request) }
        }

        public func dispatch(isLoading: Bool, request: RPServiceRequest) {
            loadingListeners.forEach { $0(isLoading, request) }
        }

    }

#endif
