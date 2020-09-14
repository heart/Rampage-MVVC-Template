//
//  RPPresenter.swift
//  boodaBEST
//
//  Created by Narongrit Kanhanoi on 8/9/2563 BE.
//  Copyright © 2563 3dsinteractive. All rights reserved.
//

#if !os(macOS)

    import UIKit

    public struct RPEvent {
        public let name: String
        public var data: Any?

        public init(name: String, data: Any? = nil) {
            self.name = name
            self.data = data
        }
    }

    open class RPPresenter: UIView {

        open var viewController: UIViewController?

        public typealias OnUserEvent = (RPEvent) -> Void
        private var eventListeners: [OnUserEvent] = []

        public var localizeStrings: [String: AnyObject]?

        public func setup(viewController: UIViewController) {
            self.viewController = viewController
            onStart()
        }

        public func loadLanguage(file: String) {
            if let path = Bundle.main.path(forResource: file, ofType: nil) {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) {
                    let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    localizeStrings = jsonResult as? Dictionary<String, AnyObject>
                }
            }
            localizeView(view: self)
        }
        
        public func getString(name: String, _ args: CVarArg...) -> String {
            guard let table = localizeStrings?[Localize.currentLocale] else { return name }
            if let string = table[name] as? String {
                return String(format: string, arguments: args)
            }
            return name
        }

        private func localizeView(view: UIView) {
            if localizeStrings == nil { return }
            if let v = view as? UILabel {
                if let stringName = v.text {
                    v.text = getString(name: stringName)
                }

            } else if let v = view as? UITextField {
                if let stringName = v.text {
                    v.text = getString(name: stringName)
                }
                if let stringName = v.placeholder {
                    v.placeholder = getString(name: stringName)
                }
            } else if let v = view as? UIButton {
                if let stringName = v.currentTitle {
                    let txt = getString(name: stringName)
                    v.setTitle(txt, for: v.state)
                }
            }

            let childs = view.subviews
            if childs.count > 0 {
                childs.forEach {
                    localizeView(view: $0)
                }
            }
        }



        open func onStart() {

        }

        public func event(clousure: @escaping OnUserEvent) {
            eventListeners.append(clousure)
        }

        public func dispatch(event: RPEvent) {
            eventListeners.forEach { $0(event) }
        }

    }

#endif
