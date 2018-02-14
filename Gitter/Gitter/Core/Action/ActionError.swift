//
// Created by Andrew Chupin on 14.02.2018.
// Copyright (c) 2018 Andrew Chupin. All rights reserved.
//

enum ActionError: Error {
    case ArgumentNotFoundError(message: String)
    case ArgumentsCountError(message: String)
    case CommandNotFoundError(message: String)
    case MappingError(message: String)
    case ActionTypeError(message: String)
}


enum CommandColor: String {
    case red = "\u{001B}[0;31m"
    case none = "\u{001B}[0;0m"
}


func printError(_ message: String) {
    print(CommandColor.red.rawValue + message + CommandColor.none.rawValue)
}
