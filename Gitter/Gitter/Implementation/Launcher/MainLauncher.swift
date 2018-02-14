//
// Created by Andrew Chupin on 14.02.2018.
// Copyright (c) 2018 65apps. All rights reserved.
//

import Foundation


class MainLauncher: Launcher, LauncherDelegate {


    override func onLauncherLoading() {
        delegate = self
    }

    func onLoadingActions(by actionManager: ActionManager) {
        actionManager.registerAction(
            command: Command.repo.rawValue,
            description: "Получить список репозиторев пользователя",
            arguments: [
                Argument(key: "-u", isRequired: true, description: "Имя пользователя")
            ],
            executor: { actionData in
                let actionMapper = MapperRepositoryAction()
                
                guard let repositoryAction = actionMapper.map(from: actionData) else {
                    return
                }
                
                let repositoryExecutor = HttpRepositoryExecutor(
                    httpClient: AlamofireHttpClient(),
                    mapper: MapperRepositoryResult()
                )
                
                repositoryExecutor.executeAction(
                    action: repositoryAction,
                    onSuccess: { result in
                        if let repositories = result.value as? [Repository] {
                            print("Репозитории \(repositoryAction.userName):")
                            for repository in repositories {
                                print(repository.name)
                            }
                        }
                        self.stopSelf()
                }, onError: { error in
                    printError(error.localizedDescription)
                    self.stopSelf()
                })
        })


        actionManager.registerAction(
                command: Command.help.rawValue,
                description: "Список доступных команд",
                executor: { _ in
                    print(actionManager.buildDescription())
                    self.stopSelf()
                })
    }

    private func stopSelf() {
        keepAlive = false
    }

}
