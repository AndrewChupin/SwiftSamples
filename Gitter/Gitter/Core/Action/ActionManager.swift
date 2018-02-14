//
// Created by Andrew Chupin on 14.02.2018.
// Copyright (c) 2018 Andrew Chupin. All rights reserved.
//


class ActionManager {

    private var actions = [Action]()


    func registerAction(command: String, description: String, arguments: [Argument] = [], executor: @escaping (ActionParcelable) -> ()) {
        actions.append(Action(command: command, description: description, arguments: arguments, handler: executor))
    }


    func findAction(by command: String) -> Action? {
        for action in actions {
            if action.command == command {
                return action
            }
        }
        return nil
    }


    /// Gitter Commands:
    ///    repo - for search github repositories
    ///        Arguments for "repo":
    ///        -u - username for search repositories
    ///    help - for print help
    func buildDescription() -> String {
        var description = ""
        description += "Список команд:\n"
        for action in actions {
            description += "\t\(action.command) - \(action.description)\n"
            description += "\t\tАргументы команды \(action.command):\n"
            action.arguments.forEach { argument in
                description += "\t\t\(argument.key) - \(argument.description)\n"
            }
        }
        return description
    }
}
