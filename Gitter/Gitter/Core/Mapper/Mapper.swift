//
// Created by Andrew Chupin on 14.02.2018.
// Copyright (c) 2018 Andrew Chupin. All rights reserved.
//

protocol Mapper {

    associatedtype From
    associatedtype To

    func map(from value: From) -> To?

}

