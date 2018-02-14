//
// Created by Andrew Chupin on 14.02.2018.
// Copyright (c) 2018 Andrew Chupin. All rights reserved.
//

// TODO import Alamofire

import Dispatch

class AlamofireHttpClient: HttpClient {

    func get(path: String, arguments: [String: Any] = [:], completion: @escaping (RequestResult) -> Void) {
        request(path, method: .get, parameters: arguments)
                .validate()
                .responseJSON(queue: DispatchQueue.main, completionHandler: { response in
                    switch response.result {
                    case .success:
                        let jsonResult = response.result.value
                        let result = RequestResult(isSuccess: true, result: ["result": jsonResult as Any], error: nil)
                        completion(result)
                    case .failure:
                        let result = RequestResult(isSuccess: false, result: nil, error: response.error)
                        completion(result)
                    }
                })
    }

    
    func post(path: String, fields: [String: Any] = [:], completion: @escaping (RequestResult) -> Void) {
        request(path, method: .post, parameters: fields)
                .validate()
                .responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success:
                        let jsonResult = response.result.value
                        let result = RequestResult(isSuccess: true, result: ["result": jsonResult as Any], error: nil)
                        completion(result)
                    case .failure:
                        let result = RequestResult(isSuccess: false, result: nil, error: response.error)
                        completion(result)
                    }
                })
    }

}
