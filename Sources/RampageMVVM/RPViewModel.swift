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

        public typealias OnSuccess = (RPModel, RPServiceRequest) -> Void
        public typealias OnFail = (Error, RPServiceRequest) -> Void
        
        public typealias OnLoading = (Bool, RPServiceRequest) -> Void

        private var onSuccessListeners: [OnSuccess] = []
        private var onFailListeners: [OnFail] = []
        private var loadingListeners: [OnLoading] = []

        public func assign(request: RPServiceRequest) {
            onRequest(request: request)
        }

        open func onRequest(request: RPServiceRequest) {

        }

        public func onSuccess(clousure: @escaping OnSuccess) {
            onSuccessListeners.append(clousure)
        }
        
        public func onFail(clousure: @escaping OnFail) {
            onFailListeners.append(clousure)
        }

        public func loading(loadingClousure: @escaping OnLoading) {
            loadingListeners.append(loadingClousure)
        }

        public func dispatch<T, E>(result: Result<T, E>, request: RPServiceRequest) where T: RPModel, E: Error {
            switch result{
            case .failure(let error):
                onFailListeners.forEach { $0(error, request) }
            case .success(let model):
                onSuccessListeners.forEach { $0(model, request) }
            }
        }

        public func dispatch(isLoading: Bool, request: RPServiceRequest) {
            loadingListeners.forEach { $0(isLoading, request) }
        }

    }

#endif
