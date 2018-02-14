//
//  Parser.swift
//  Gitter
//
//  Created by Andrew Chupin on 14.02.2018.
//  Copyright © 2018 Andrew Chupin. All rights reserved.
//


/// All supporting command name
///
/// - help: for print list of available commands
/// - repo: for getting repository list



struct Argument {
    var key: String
    let isRequired: Bool
    let description: String
}


struct Action {
    let command: String
    let description: String
    let arguments: [Argument]
    let handler: (ActionParcelable) -> ()
}


struct ArgumentParcelable {
    let key: String
    let value: String
}


struct ActionParcelable {
    let command: String
    let arguments: [ArgumentParcelable]
}

