import Foundation

guard CommandLine.arguments.count > 2 else {
    print("Usage: devcenter-snippets-collector <devcenter path> <output swift file path>")
    exit(EXIT_FAILURE)
}

let devCenterPath = URL(fileURLWithPath: CommandLine.arguments[1])
let fileManager = FileManager.default
var isDirectory: ObjCBool = false
guard fileManager.fileExists(atPath: devCenterPath.path, isDirectory: &isDirectory), isDirectory.boolValue else {
    print("DevCenter Path does not exists")
    print(devCenterPath.path)
    exit(EXIT_FAILURE)
}

let outputFile = URL(fileURLWithPath: CommandLine.arguments[2])

struct Snippet {
    
    let file: URL
    let line: Int
    let code: String
    
}

let ignorePaths = [
    "content/guide/ios",
    "content/downloads/ios-changelog.md",
    "content/guide/ios-v3.0/migration.md",
    "content/downloads/ios-v1-changelog.md",
    "content/tutorial"
]

func filesThatMatch(path: URL) -> [Snippet] {
    var isDirectory: ObjCBool = false
    guard fileManager.fileExists(atPath: path.path, isDirectory: &isDirectory) else {
        return []
    }
    for ignorePath in ignorePaths {
        if path.path.hasSuffix("/\(ignorePath)") {
            return []
        }
    }
    if isDirectory.boolValue {
        return try! fileManager.contentsOfDirectory(atPath: path.path).flatMap {
            filesThatMatch(path: path.appendingPathComponent($0))
        }
    } else {
        if path.pathExtension == "md",
            let fileContentData = fileManager.contents(atPath: path.path),
            let fileContent = String(data: fileContentData, encoding: .utf8)
        {
            var snippets = [Snippet]()
            var offset = fileContent.startIndex
            var line = 0
            while offset != fileContent.endIndex {
                if let snippetDeclaration = fileContent[offset ..< fileContent.endIndex].range(of: "```swift"),
                    let startRange = fileContent[snippetDeclaration.upperBound...].range(of: "\n"),
                    let endRange = fileContent[startRange.upperBound...].range(of: "```")
                {
                    line += fileContent[offset ..< snippetDeclaration.lowerBound].filter { $0 == "\n" }.count + 1
                    let range = startRange.upperBound ..< endRange.lowerBound
                    let code = fileContent[range].trimmingCharacters(in: .whitespacesAndNewlines)
                    snippets.append(Snippet(file: path, line: line, code: code))
                    line += fileContent[range].filter { $0 == "\n" }.count
                    offset = endRange.upperBound
                } else {
                    offset = fileContent.endIndex
                }
            }
            return snippets
        }
        return []
    }
}

let snippets = filesThatMatch(path: devCenterPath)
let regex = try NSRegularExpression(pattern: "let\\s+(\\w*)\\s*=\\s*")

let output = snippets.enumerated().map { index, snippet -> [String] in
    var file = snippet.file.path[devCenterPath.path.endIndex...]
    file.removeFirst()
    let linesOfCode = snippet.code.split(separator: "\n").map { String($0) }
    let variables = linesOfCode.filter {
        $0.starts(with: "let ") || $0.starts(with: "var ")
    }.compactMap { string -> String? in
        let matches = regex.matches(in: string, range: NSMakeRange(0, string.count))
        for match in matches {
            if match.numberOfRanges > 1 {
                let range = match.range(at: 1)
                let variable = string[string.index(string.startIndex, offsetBy: range.location) ..< string.index(string.startIndex, offsetBy: range.location + range.length)]
                return String(variable)
            }
        }
        return nil
    }
    
    let returnIsVoid = !linesOfCode.filter {
        $0.trimmingCharacters(in: .whitespacesAndNewlines) == "return"
    }.isEmpty
    var lines = [
        "",
        "// \(file):\(snippet.line)",
        "func snippet\(index)() throws -> \(returnIsVoid ? "Void" : "Any?") {",
    ]
    lines.append(contentsOf: linesOfCode.compactMap {
        guard !$0.hasPrefix("import ") else {
            return nil
        }
        guard !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return ""
        }
        return "    \($0)"
    })
    lines.append("    ")
    lines.append("    //****************************************")
    lines.append(contentsOf: variables.map { "    printAny(\($0))" })
    if !returnIsVoid {
        lines.append("    return nil")
    }
    lines.append("}")
    return lines
}
var lines = [
    "import Kinvey",
    "import CoreLocation",
    "import MapKit",
    "import UIKit",
    "",
    "class CodeSnippets: UIViewController {"
]
lines.append(contentsOf: output.flatMap { $0 }.map{
    guard !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
        return ""
    }
    return "    \($0)"
})
lines.append("")
lines.append("}")
let finalOutput = lines.joined(separator: "\n")
try! finalOutput.write(to: outputFile, atomically: true, encoding: .utf8)
print("\(snippets.count) snippets")
