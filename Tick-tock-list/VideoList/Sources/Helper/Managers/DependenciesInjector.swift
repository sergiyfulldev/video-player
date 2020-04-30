//
//  DependenciesInjector.swift
//  VideoList
//
//  Created by Kuts, Andrey on 12/26/19.
//  Copyright © 2019 Kuts, Andrey. All rights reserved.
//

import Foundation

class DependenciesInjector {

    static let instance = DependenciesInjector()
    private var services = [ObjectIdentifier: Any]()

    static func inject<T>() -> T {
        return instance.inject()
    }

    static func register<T>(singleton: T) {
        instance.register(singleton: singleton)
    }

    static func register<T>(factory: @escaping () -> T) {
        instance.register(factory: factory)
    }

    private init() {}

    private func inject<T>() -> T {
        let service = services[ObjectIdentifier(T.self)]

        if let singleton = service as? T {
            return singleton
        } else if let factory = service as? () -> T {
            return factory()
        } else {
            fatalError("Could not inject unregistered service: \(T.self)")
        }
    }

    private func register<T>(factory: @escaping () -> T) {
        services[ObjectIdentifier(T.self)] = factory
    }

    private func register<T>(singleton: T) {
        services[ObjectIdentifier(T.self)] = singleton
    }
}
