//
//  EmojiTools.swift
//  EmojiTools
//
//  Copyright © 2016 Todd Kramer.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Foundation

// MARK:- String
extension String {
    
    func composedCharacterSequences() -> [String] {
        var characters = [String]()
        enumerateSubstringsInRange(startIndex..<endIndex, options: .ByComposedCharacterSequences) { char, start, end, stop in
            characters.append(char!)
        }
        return characters
    }
    
    /**
     Converts emoji markdown to an emoji. For example, ":smile:" into "😀"
     
     - Returns: Emoji string
     */
    public func emojiString() -> String {
        return String.emojiStringFromString(self)
    }
    
    /**
        Converts emoji markdown to an emoji. For example, ":smile:" into "😀"
     
        - Parameter inputString: Emoji markdown string, such as ":smile:"
        
        - Returns: Emoji string
    */
    public static func emojiStringFromString(inputString: String) -> String {
        var token: dispatch_once_t = 0
        var regex: NSRegularExpression? = nil
        dispatch_once(&token) {
            let pattern = "(:[a-z0-9-+_]+:)"
            regex = try! NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
        }
        
        var resultText = inputString
        let matchRange = NSMakeRange(0, resultText.characters.count)
        regex?.enumerateMatchesInString(resultText, options: .ReportCompletion, range: matchRange, usingBlock: { (result, _, _) -> Void in
            guard let range = result?.range else { return }
            if range.location != NSNotFound {
                let emojiCode = (inputString as NSString).substringWithRange(range)
                if let emojiCharacter = emojiShortCodes[emojiCode] {
                    resultText = resultText.stringByReplacingOccurrencesOfString(emojiCode, withString: emojiCharacter)
                }
            }
        })
        
        return resultText
    }

    /**
     Tests whether a string contains an emoji.
     
     - Returns: Whether the string contains emoji
     */
    public func containsEmoji() -> Bool {
        return String.containsEmoji(self)
    }

    /**
        Tests whether a string contains an emoji.
     
        - Parameter string: The string to test
     
        - Returns: Whether the string contains emoji
    */
    public static func containsEmoji(string: String) -> Bool {
        var found = false
        string.enumerateSubstringsInRange(string.startIndex..<string.endIndex, options: .ByComposedCharacterSequences) { (substring, substringRange, enclosingRange, stop) in
            if let substring = substring where String.isEmojiCharacterSequence(substring) {
                found = true
                stop = true
            }
        }
        return found
    }

    /**
     Tests whether a string is composed of nothing but emojis
     
     - Parameter allowWhitespace:   Whether to ignore white space
     
     - Returns: Whether the string is composed of nothing but emoji and optionally white space
     */
    public func containsEmojiOnly(allowWhitespace: Bool = true) -> Bool {
        return String.containsEmojiOnly(self, allowWhitespace: allowWhitespace)
    }
    
    /**
     Tests whether a string is composed of nothing but emojis
     
     - Parameters:
        - string:            The string to test
        - allowWhitespace:   Whether to ignore white space
     
     - Returns: Whether the string is composed of nothing but emoji and optionally white space
    */
    public static func containsEmojiOnly(string: String, allowWhitespace: Bool = true) -> Bool {
        var inputString = string
        if allowWhitespace {
            inputString = string.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).joinWithSeparator("")
        }
        var result = true
        inputString.enumerateSubstringsInRange(inputString.startIndex..<inputString.endIndex, options: .ByComposedCharacterSequences) { (substring, substringRange, enclosingRange, stop) in
            if let substring = substring where !String.isEmojiCharacterSequence(substring) {
                result = false
                stop = true
            }
        }
        return result
    }
    
    /**
        Tests whether a string is a composed sequence of characters constituting an emoji
     
        - Parameter string: A string to test.
     
        - Important: This method is intended on testing whether a composed series of characters, given as an argument
            represents a single emoji. To identify emojis in a string, you must enumerate it using ByComposedCharacterSequences
            enumeration option.
     
        - Returns: True is the entire string is a single emoji
    */
    public static func isEmojiCharacterSequence(string: String) -> Bool {
        let emojiChars = EmojiTools.emojiCharacters
        // check in the map of known characters first
        if emojiChars.contains(string) {
            return true
        }
        
        // check individual unicode scalars - all must be known emoji, a zero-width joiner and optionally ending with a variant selector
        let scalars = string.unicodeScalars
        for (i, scalar) in scalars.enumerate() {
            if scalar.isZeroWidthJoiner() || scalar.isEmoji() || (i == scalars.count - 1 && scalar.isEmojiVariationSelector()) {
                continue
            }
            return false
        }
        
        return true
    }
    
}

// MARK:- UnicodeScalar
extension UnicodeScalar {
    
    /// Tests whether unicode scalar is an emoji
    public func isEmoji() -> Bool {
        return EmojiTools.emojiCharacters.contains(String(self))
    }
    
    /// Tests whether unicode scalar is an emoji variant (such as skin tone)
    public func isEmojiVariationSelector() -> Bool {
        return isEmojiVariationStandardSelector() || isEmojiVariationSelectorSupplement()
    }
    
    /// Tests whether unicode scalar is a standard emoji variation selector.
    /// These are between U+FE00 and U+FE0F as of Unicode 9
    public func isEmojiVariationStandardSelector() -> Bool {
        return value >= 65024 && value <= 65039
    }
    
    /// Tests whether unicode scalar is an emoji variation supplement.
    /// These are between U+E0100 and U+E01EF as of Unicode 9
    public func isEmojiVariationSelectorSupplement() -> Bool {
        return value >= 917760 && value <= 917999
    }
    
    /// Tests whether unicode scalar is a zero-width joiner
    /// These can be used to combine multiple emoji codepoints into a single emoji
    public func isZeroWidthJoiner() -> Bool {
        return value == 8205
    }
}


// MARK:- EmojiTools
public struct EmojiCodeSuggestion {
    let code: String
    let character: String
}

public class EmojiTools {
    /// Map of known emoji characters
    public static let emojiCharacters: Set<String> = {
        let ourBundle = NSBundle.init(forClass: EmojiTools.self)
        var result: Set<String>? = nil
        if let path = ourBundle.pathForResource("emoji", ofType: "txt") {
            result = EmojiTools.loadCharacterSetFromFile(path)
        }
        if result == nil {
            result = Set<String>()
        }
        return result!
    }()
    
    private static func loadCharacterSetFromFile(filePath: String) -> Set<String>? {
        if let contents = try? String(contentsOfFile: filePath) {
            return Set<String>(contents.composedCharacterSequences())
        }
        return nil
    }

    public static func emojiCodeSuggestionsForSearchTerm(searchTerm: String) -> [EmojiCodeSuggestion] {
        let keys = Array(emojiShortCodes.keys)
        let filteredKeys = keys.filter { (key) -> Bool in
            return key.containsString(searchTerm)
            }.sort()
        let unicodeCharacters = filteredKeys.map({ emojiShortCodes[$0]! })
        var suggestions = [EmojiCodeSuggestion]()
        if filteredKeys.count == 0 { return suggestions }
        for index in 0...(filteredKeys.count - 1) {
            let suggestion = EmojiCodeSuggestion(code: filteredKeys[index], character: unicodeCharacters[index])
            suggestions.append(suggestion)
        }
        return suggestions
    }

}
