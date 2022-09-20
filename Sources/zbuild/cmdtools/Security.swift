//
// Created by Julian Kalinowski on 15.09.22.
//

import Foundation
import SwiftCommand
import SystemPackage

struct Security {

    func execute(arguments: [String]) async throws {
        let exitStatus:ExitStatus? = try Command.findInPath(withName: "security")?
                .addArguments(arguments)
                .wait()

        if let exitStatus = exitStatus {
            if !exitStatus.terminatedSuccessfully {
                throw ZBuildError(message: "Command failed with code: \(exitStatus.exitCode)")
            }
        }
    }

}

extension Security {
    func importKey(filePath: String, password: String?) async throws {
        if let password = password {
            try await execute(arguments: ["import", filePath, "-P", password])
        } else {
            try await execute(arguments: ["import", filePath])
        }
    }
}