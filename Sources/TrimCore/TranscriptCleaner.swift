// Sources/TrimCore/TranscriptCleaner.swift
// Core logic – outputs lines like: [hh:mm:ss]Name: body

import Foundation

public enum TranscriptCleaner {
    /// Converts SRT / WEBVTT text into one-line cues: `[hh:mm:ss]Name: body`.
    public static func clean(_ raw: String) -> String {
        // 1. Normalize newlines & strip BOM
        var src = raw.replacingOccurrences(of: "\u{FEFF}", with: "")
        src = src.replacingOccurrences(of: "\r\n", with: "\n")
            .replacingOccurrences(of: "\r", with: "\n")
        
        // 2. Drop WEBVTT header if present
        if src.uppercased().starts(with: "WEBVTT") {
            if let range = src.range(of: "\n\n") {
                src = String(src[range.upperBound...])
            } else { src = "" }
        }
        
        // 3. Iterate lines to build cues
        var results: [String] = []
        var currentTime: String? = nil
        var currentText: [String] = []
        
        func flush() {
            guard let time = currentTime else { return }
            let body = currentText.joined(separator: " ").trimmingCharacters(in: .whitespacesAndNewlines)
            if !body.isEmpty {
                let hhmmss = String(time.prefix(8)) // discard milliseconds
                results.append("[\(hhmmss)]\(body)")
            }
            currentTime = nil
            currentText.removeAll()
        }
        
        let lines = src.split(separator: "\n", omittingEmptySubsequences: false)
        for lineSub in lines {
            let line = String(lineSub)
            if line.range(of: #"^[0-9]+$"#, options: .regularExpression) != nil {
                continue // index line
            }
            if let matchRange = line.range(of: #"[0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{3}\s+-->"#, options: .regularExpression) {
                flush()
                let ts = String(line[matchRange]).prefix(12) // HH:MM:SS.mmm --> part
                let hhmmss = ts.prefix(8)
                currentTime = String(hhmmss)
            } else if line.trimmingCharacters(in: .whitespaces).isEmpty {
                flush()
            } else {
                currentText.append(line)
            }
        }
        flush()
        return results.joined(separator: "\n")
    }
}
