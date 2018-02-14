//
// Created by Andrew Chupin on 14.02.2018.
// Copyright (c) 2018 Andrew Chupin. All rights reserved.
//


class MapperRepositoryAction: Mapper {

    typealias From = ActionParcelable
    typealias To = FindRepositoryAction

    func map(from value: From) -> To? {
        let userArg = value.arguments.first(where: {
            $0.key == "-u"
        })

        guard let validUserName = userArg?.value else {
            return nil
        }

        return FindRepositoryAction(userName: validUserName)
    }

}


class MapperRepositoryResult: Mapper {

    typealias From = RequestResult
    typealias To = ExecutionResult

    func map(from value: From) -> To? {
        guard let response = value.result,
              let repositories = response["result"] as? [[String: Any]] else {
                return ExecutionResult(value: nil, error: nil, status: .error)
        }

        var repositoryList: [Repository] = []

        for repository in repositories {
            if let repositoryUrl = repository["html_url"] as? String {
                repositoryList.append(Repository(name: repositoryUrl))
            }
        }

        return ExecutionResult(value: repositoryList, error: nil, status: .success)
    }

}
