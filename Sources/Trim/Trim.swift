// Sources/Trim/main.swift
// CLI wrapper that depends on TrimCore and ArgumentParser

import ArgumentParser
import TrimCore
import Foundation

@main
struct Trim: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "trim",
        abstract: "Clean SRT‑style transcript blocks into minimal timestamp + text pairs."
    )
    
    /// Path to the transcript file. If omitted, read from STDIN.
    @Argument(help: "Path to the transcript file (SRT/TXT). Reads STDIN when omitted.")
    var path: String?
    
    mutating func run() throws {
        let raw = try readInput()
        let cleaned = TranscriptCleaner.clean(raw)
        print(cleaned)
    }
    
    // MARK: - Helpers
    
    private func readInput() throws -> String {
        if let path {
            let url = URL(fileURLWithPath: path)
            return try String(contentsOf: url, encoding: .utf8)
        } else {
            let data = FileHandle.standardInput.readDataToEndOfFile()
            guard let str = String(data: data, encoding: .utf8) else {
                throw ValidationError("STDIN is not valid UTF‑8 text.")
            }
            return str
        }
    }
}
