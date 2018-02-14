//
// Created by Andrew Chupin on 14.02.2018.
// Copyright (c) 2018 Andrew Chupin. All rights reserved.
//

import Foundation


struct FindRepositoryAction: ExecuteAction {
    let userName: String
}


class HttpRepositoryExecutor: Executor {

    private let httpClient: HttpClient
    private let mapper: MapperRepositoryResult


    init(httpClient: HttpClient, mapper: MapperRepositoryResult) {
        self.httpClient = httpClient
        self.mapper = mapper
    }


    func executeAction(
            action: ExecuteAction,
            onSuccess: @escaping (ExecutionResult) -> Void,
            onError: @escaping (Error) -> Void
    ) {
        guard let repositoryAction = action as? FindRepositoryAction else {
            return
        }

        let repoPath = String(format: gitDefaultUrl + GitApi.findRepository.rawValue, repositoryAction.userName)
        httpClient.get(
                path: repoPath,
                arguments: [:],
                completion: { result in
                    if result.isSuccess {
                        if let repositories = self.mapper.map(from: result) {
                            onSuccess(repositories)
                            return
                        }
                        onError(ActionError.MappingError(message: "Deserialization error"))
                    } else {
                        if let error = result.error {
                            onError(error)
                        }
                    }
                })
    }

}
