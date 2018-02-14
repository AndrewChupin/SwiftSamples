//
//  ArgumentParser.swift
//  Gitter
//
//  Created by Andrew Chupin on 14.02.2018.
//  Copyright © 2018 Andrew Chupin. All rights reserved.
//


protocol ExecuteAction {}


/// Abstraction for object witch execute concrete command
protocol Executor {
    
    /// This method will be inovoke for execute command
    ///
    /// - Parameters:
    ///   - action: сontains the minimum data set for execution
    ///   - onSuccess: сalled if the executor has not thrown exceptions
    ///   - onError: сalled if the executor has thrown exceptions
    func executeAction(
            action: ExecuteAction,
            onSuccess: @escaping (ExecutionResult) -> Void,
            onError: @escaping (Error) -> Void
    )
}


