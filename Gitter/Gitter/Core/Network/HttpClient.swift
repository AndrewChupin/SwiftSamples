//
// Created by Andrew Chupin on 14.02.2018.
// Copyright (c) 2018 Andrew Chupin. All rights reserved.
//

struct RequestResult {
    let isSuccess: Bool
    let result: [String: Any]?
    let error: Error?
}

protocol HttpClient {

    func get(path: String, arguments: [String: Any], completion: @escaping (RequestResult) -> Void)
    func post(path: String, fields: [String: Any], completion: @escaping (RequestResult) -> Void)

}
