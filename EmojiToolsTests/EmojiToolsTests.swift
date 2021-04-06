//
//  EmojiToolsTests.swift
//  EmojiToolsTests
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

import XCTest
@testable import EmojiTools

class EmojiToolsTests: XCTestCase {

    let nonEmojiString = "This string does not contain emoji."
    let nonEmojiNumerals = "1234567890"
    let mixedEmojiString = "This 😀😎👩‍👩‍👧‍👧 string 🌲🐯🌛 has 🍉☕️🍻 a 🎆🏀🎼 lot 🚌🗽✈️ of 📞🔦✉️ emoji. 8️⃣🔡🕒"
    let mixedEmojiCodeString = "\u{1f923} \u{1f924} \u{1f920} \u{1f921}" // new to iOS10
    let mixedEmojiModifiersString = "This 👶🏻 string 👦🏽👩🏾 has emoji with skin tone variations."
    let mixedEmojiWhitespaceString = "😀😎👩‍👩‍👧‍👧 🌲🐯🌛 🍉☕️🍻 🎆🏀🎼\n🚌🗽✈️      📞🔦✉️ 8️⃣🔡🕒"
    let emojiOnlyString = "😀😎👩‍👩‍👧‍👧🌲🐯🌛🍉☕️🍻🎆🏀🎼🚌🗽✈️📞🔦✉️8️⃣🔡🕒"
    let emojiOnlyModifiersString = "👶🏻👦🏽👩🏾"
    let emojiOnlyComposedString = "🇻🇪🇻🇳🇼🇫🇪🇭🇾🇪🇿🇲🇿🇼"
    let emojiTokenString = "The :monkey: is trying to buy a :banana: with some :moneybag: at the :convenience_store:."
    
    func testNonEmojiStringContainsNoEmoji() {
        XCTAssertFalse(nonEmojiString.containsEmoji())
    }
    
    func testNonEmojiNumeralsContainsNoEmoji() {
        XCTAssertFalse(nonEmojiNumerals.containsEmoji())
    }
    
    func testMixedEmojiStringContainsEmoji() {
        XCTAssertTrue(mixedEmojiString.containsEmoji())
    }
    
    func testMixedEmojiCodeStringContainsEmoji() {
        XCTAssertTrue(mixedEmojiCodeString.containsEmoji())
    }
    
    func testMixedEmojiModifersStringContainsEmoji() {
        XCTAssertTrue(mixedEmojiModifiersString.containsEmoji())
    }
    
    func testMixedEmojiWhitespaceStringContainsEmoji() {
        XCTAssertTrue(mixedEmojiWhitespaceString.containsEmoji())
    }
    
    func testEmojiOnlyStringContainsEmoji() {
        XCTAssertTrue(emojiOnlyString.containsEmoji())
    }
    
    func testEmojiOnlyComposedStringContainsEmoji() {
        XCTAssertTrue(emojiOnlyComposedString.containsEmoji())
    }
    
    func testNonEmojiStringDoesNotContainEmojiOnly() {
        XCTAssertFalse(nonEmojiString.containsEmojiOnly())
    }
    
    func testEmojiNumeralsStringDoesNotContainEmojiOnly() {
        XCTAssertFalse(nonEmojiNumerals.containsEmojiOnly())
    }
    
    func testMixedEmojiStringDoesNotContainEmojiOnly() {
        XCTAssertFalse(mixedEmojiString.containsEmojiOnly())
    }
    
    func testMixedEmojiModifiersStringDoesNotContainEmojiOnly() {
        XCTAssertFalse(mixedEmojiModifiersString.containsEmojiOnly())
    }
    
    func testMixedEmojiWhitespaceStringDoesNotContainEmojiOnly() {
        XCTAssertFalse(mixedEmojiWhitespaceString.containsEmojiOnly(allowWhitespace: false))
    }
    
    func testMixedEmojiWhitespaceStringContainsEmojiAndWhitespaceOnly() {
        XCTAssertTrue(mixedEmojiWhitespaceString.containsEmojiOnly())
    }
    
    func testEmojiOnlyStringContainsEmojiAndWhitespaceOnly() {
        XCTAssertTrue(emojiOnlyString.containsEmojiOnly())
    }
    
    func testEmojiOnlyStringContainsEmojiOnly() {
        XCTAssertTrue(emojiOnlyString.containsEmojiOnly(allowWhitespace: false))
    }
    
    func testEmojiOnlyModifiersStringContainsEmojiOnly() {
        XCTAssertTrue(emojiOnlyModifiersString.containsEmojiOnly())
    }
    
    func testEmojiOnlyComposedStringContainsEmojiAndWhitespaceOnly() {
        XCTAssertTrue(emojiOnlyComposedString.containsEmojiOnly())
    }
    
    func testEmojiOnlyComposedStringStringContainsEmojiOnly() {
        XCTAssertTrue(emojiOnlyComposedString.containsEmojiOnly(allowWhitespace: false))
    }

    func testEmojiString() {
        let processedEmojiString = "The 🐒 is trying to buy a 🍌 with some 💰 at the 🏪."
        XCTAssertEqual(emojiTokenString.emojiString(), processedEmojiString)
    }

}
