//
// Created by Andrew Chupin on 14.02.2018.
// Copyright (c) 2018 65apps. All rights reserved.
//

import Foundation

class ActionValidator {

    let actionManager: ActionManager

    init(actionManager: ActionManager) {
        self.actionManager = actionManager
    }

    func validateAction(actionData: ActionParcelable?) throws {
        guard let aliveActionData = actionData else {
            return
        }

        let action = try parseActionType(by: aliveActionData.command)
        try validateFlags(from: aliveActionData, to: action)
    }


    private func parseActionType(by actionKey: String?) throws -> Action {
        guard let action = actionKey?.trimmingCharacters(in: .whitespacesAndNewlines), !action.isEmpty else {
            throw ActionError.CommandNotFoundError(message: "Command \(actionKey ?? "EMPTY") not found")
        }

        if let validAction = actionManager.findAction(by: action) {
            return validAction
        }

        throw ActionError.CommandNotFoundError(message: "Action with name \(action) not found")
    }


    public func validateFlags(from parcelableAction: ActionParcelable, to action: Action) throws {
        // Parcelable keys from ActionParcelable
        let parcelableKeysSet = Set(parcelableAction.arguments.map{ $0.key })

        // All keys from Action
        var keys = Set<String>()
        action.arguments.forEach {
            keys.insert($0.key)
        }

        // Required keys from Action
        var requiredKeys = Set<String>()
        action.arguments
                .filter { $0.isRequired }
                .forEach {
                    if !$0.key.isEmpty {
                        requiredKeys.insert($0.key)
                    }
                }

        // Validation
        guard !requiredKeys.isEmpty, !parcelableKeysSet.isEmpty else {
            return
        }

        guard keys.isSuperset(of: parcelableKeysSet) else {
            throw ActionError.ArgumentNotFoundError(message: "You have not usable argument \(parcelableKeysSet), please use \"Gitter help\"")
        }

        guard requiredKeys.isSuperset(of: parcelableKeysSet) else {
            throw ActionError.ArgumentNotFoundError(message: "Absent required arguments inside \(parcelableKeysSet)")
        }
    }
}
