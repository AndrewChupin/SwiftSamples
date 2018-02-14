//
// Created by Andrew Chupin on 14.02.2018.
// Copyright (c) 2018 65apps. All rights reserved.
//

import Foundation

protocol LauncherDelegate {
    func onLoadingActions(by actionManager: ActionManager)
}


class Launcher {

    public var delegate: LauncherDelegate?
    var keepAlive = true
    
    func launch(argsCount: Int, args: [String]) {
        onLauncherLoading()

        let actionManager = ActionManager()
        let actionValidator = ActionValidator(actionManager: actionManager)
        let actionParser = ActionParser()

        self.delegate?.onLoadingActions(by: actionManager)
        var actionData: ActionParcelable? = nil
        do {
            actionData = try actionParser.parseAction(with: argsCount, and: args)
            try actionValidator.validateAction(actionData: actionData)
        } catch ActionError.ActionTypeError(let message) {
            printError(message)
            exit(ExitCode.action.rawValue)
        } catch ActionError.ArgumentNotFoundError(let message) {
            printError(message)
            exit(ExitCode.action.rawValue)
        } catch ActionError.ArgumentsCountError(let message) {
            printError(message)
            exit(ExitCode.action.rawValue)
        } catch ActionError.CommandNotFoundError(let message) {
            printError(message)
            exit(ExitCode.action.rawValue)
        } catch ActionError.MappingError(let message) {
            printError(message)
            exit(ExitCode.mapper.rawValue)
        } catch {
            printError(error.localizedDescription)
            exit(ExitCode.other.rawValue)
        }

        if let validActionData = actionData {
            let action = actionManager.findAction(by: validActionData.command)
            action?.handler(validActionData)
        }

        // Execute action
        self.onLauncherFinish()
    }
    
    func onLauncherLoading() {
        // Empty
    }

    func onLauncherFinish() {
        let runLoop = RunLoop.current
        while keepAlive && runLoop.run(mode: .defaultRunLoopMode, before: Date(timeIntervalSinceNow: 0.5)) {}
    }
    
}
