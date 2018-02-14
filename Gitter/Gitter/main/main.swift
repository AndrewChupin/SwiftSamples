//
//  main.swift
//  Gitter
//
//  Created by Andrew Chupin on 14.02.2018.
//  Copyright © 2018 65apps. All rights reserved.
//

import Foundation

let main: () = {
   let launcher: Launcher = MainLauncher()
    launcher.launch(argsCount: Int(CommandLine.argc), args: CommandLine.arguments)
}()
