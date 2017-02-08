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
    
    let emojiString = "This 😀😎👩‍👩‍👧‍👧 string 🌲🐯🌛 has 🍉☕️🍻 a 🎆🏀🎼 lot 🚌🗽✈️ of 📞🔦✉️ emoji. 8️⃣🔡🕒"
    let emojiStringStripped = "This  string  has  a  lot  of  emoji. "
    
    let emojiString10 = "\u{1f923} \u{1f924} \u{1f920} \u{1f921}" // new to iOS10
    let emojiString10Stripped = "   " // new to iOS10
    
    let emojiModifiersString = "This 👶🏻 string 👦🏽👩🏾 has emoji with skin tone variations."
    let emojiModifiersStringStripped = "This  string  has emoji with skin tone variations."
    
    let emojiOnlyWhitespaceString = "😀😎👩‍👩‍👧‍👧 🌲🐯🌛 🍉☕️🍻 🎆🏀🎼\n🚌🗽✈️      📞🔦✉️ 8️⃣🔡🕒"
    let emojiOnlyWhitespaceStringStripped = "   \n       "
    
    let emojiOnlyString = "😀😎👩‍👩‍👧‍👧🌲🐯🌛🍉☕️🍻🎆🏀🎼🚌🗽✈️📞🔦✉️8️⃣🔡🕒"
    let emojiOnlyStringStripped = ""
    
    let emojiOnlyModifiersString = "👶🏻👦🏽👩🏾"
    let emojiOnlyModifiersStringStripped = ""
    
    let emojiOnlyModifiersMixedString = "These have emoji with modifiers: 👶🏻👦🏽👩🏾!"
    let emojiOnlyModifiersMixedStringStripped = "These have emoji with modifiers: !"
    
    let emojiOnlyComposedString = "🇻🇪🇻🇳🇼🇫🇪🇭🇾🇪🇿🇲🇿🇼"
    let emojiOnlyComposedStringStripped = ""
    
    let emojiCodeString = "The :monkey: is trying to buy a :banana: with some :moneybag: at the :convenience_store:."
    let emojiProcessedString = "The 🐒 is trying to buy a 🍌 with some 💰 at the 🏪."
    
    func testContainsEmoji() {
        XCTAssertFalse(nonEmojiString.containsEmoji())
        XCTAssertFalse(nonEmojiNumerals.containsEmoji())
        XCTAssertTrue(emojiString.containsEmoji())
        XCTAssertTrue(emojiString10.containsEmoji())
        XCTAssertTrue(emojiModifiersString.containsEmoji())
        XCTAssertTrue(emojiOnlyWhitespaceString.containsEmoji())
        XCTAssertTrue(emojiOnlyString.containsEmoji())
        XCTAssertTrue(emojiOnlyComposedString.containsEmoji())
    }
    
    func testContainsEmojiOnly() {
        XCTAssertFalse(nonEmojiString.containsEmojiOnly())
        XCTAssertFalse(nonEmojiNumerals.containsEmojiOnly())
        XCTAssertFalse(emojiString.containsEmojiOnly())
        XCTAssertFalse(emojiModifiersString.containsEmojiOnly())
        XCTAssertFalse(emojiOnlyWhitespaceString.containsEmojiOnly(false))
        XCTAssertTrue(emojiOnlyWhitespaceString.containsEmojiOnly())
        XCTAssertTrue(emojiOnlyString.containsEmojiOnly())
        XCTAssertTrue(emojiOnlyModifiersString.containsEmojiOnly())
        XCTAssertTrue(emojiOnlyString.containsEmojiOnly(false))
        XCTAssertTrue(emojiOnlyComposedString.containsEmojiOnly())
        XCTAssertTrue(emojiOnlyComposedString.containsEmojiOnly(false))
    }

    func testEmojiString() {
        XCTAssertEqual(emojiCodeString.emojiString(), emojiProcessedString)
    }
    
    func testEmojiStripping() {
        XCTAssertEqual(nonEmojiString, nonEmojiString.stringByRemovingEmoji())
        XCTAssertEqual(nonEmojiNumerals, nonEmojiNumerals.stringByRemovingEmoji())
        XCTAssertEqual(emojiStringStripped, emojiString.stringByRemovingEmoji())
        XCTAssertEqual(emojiString10Stripped, emojiString10.stringByRemovingEmoji())
        XCTAssertEqual(emojiModifiersStringStripped, emojiModifiersString.stringByRemovingEmoji())
        XCTAssertEqual(emojiOnlyWhitespaceStringStripped, emojiOnlyWhitespaceString.stringByRemovingEmoji())
        XCTAssertEqual(emojiOnlyStringStripped, emojiOnlyString.stringByRemovingEmoji())
        XCTAssertEqual(emojiOnlyModifiersStringStripped, emojiOnlyModifiersString.stringByRemovingEmoji())
        XCTAssertEqual(emojiOnlyModifiersMixedStringStripped, emojiOnlyModifiersMixedString.stringByRemovingEmoji())
        XCTAssertEqual(emojiOnlyComposedStringStripped, emojiOnlyComposedString.stringByRemovingEmoji())
    }

}
