//
// Created by Andrew Chupin on 14.02.2018.
// Copyright (c) 2018 Andrew Chupin. All rights reserved.
//

enum ExecuteStatus {
    case success, error
}

struct ExecutionResult {
    let value: Any?
    let error: Error?
    let status: ExecuteStatus
}
