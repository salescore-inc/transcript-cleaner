// Tests/TrimTests/TrimTests.swift
import Testing
@testable import TrimCore

@Suite("TranscriptCleaner.clean – new format")
struct TrimCleanTests {
    @Test("Basic cue formatting")
    func basic() throws {
        let input = """
1
00:00:01.000 --> 00:00:02.000
Alice: Hello
"""
        let expected = "[00:00:01]Alice: Hello"
        #expect(TranscriptCleaner.clean(input) == expected)
    }
    
    @Test("Multiple cues with WEBVTT header")
    func multiple() throws {
        let input = """
WEBVTT

1
00:00:05.000 --> 00:00:06.000
Bob: Hi

2
00:00:07.000 --> 00:00:08.000
Carol: Bye
"""
        let expected = """
[00:00:05]Bob: Hi
[00:00:07]Carol: Bye
"""
        #expect(TranscriptCleaner.clean(input) == expected)
    }
}
