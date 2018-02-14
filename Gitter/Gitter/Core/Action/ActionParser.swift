//
// Created by Andrew Chupin on 14.02.2018.
// Copyright (c) 2018 Andrew Chupin. All rights reserved.
//

class ActionParser {

    private let commandNameIndex = 1 // 1 - command name
    private let startArgument = 2 // 0 args is application name | 1 is command name
    private let argumentStep = 2 // 1 - key | 2 - value

    public func parseAction(with count: Int, and arguments: [String]) throws -> ActionParcelable {
        guard count > 1 && count % 2 == 0 else {
            throw ActionError.ArgumentsCountError(message: "Argument count must be div on 2, now count is \(count)")
        }

        let action = arguments[commandNameIndex]

        var argumentsParcelable: [ArgumentParcelable] = []

        if (count > 2) {
            for argNumber in stride(from: startArgument, to: count, by: argumentStep) {
                let argument = try self.makeArgumentPair(key: arguments[argNumber], value: arguments[argNumber + 1])
                argumentsParcelable.append(argument)
            }
        }

        return ActionParcelable(command: action, arguments: argumentsParcelable)
    }


    private func makeArgumentPair(key argumentKey: String, value argumentValue: String) throws -> ArgumentParcelable {
        guard !argumentKey.isEmpty, argumentKey.starts(with: "-") else {
            throw ActionError.ArgumentNotFoundError(message: "Not found argument with name \(argumentKey)")
        }

        return ArgumentParcelable(key: argumentKey, value: argumentValue)
    }

}
