# EmojiTools

Tools for detecting emoji in strings and using emoji shortcut codes.

## Features
- supports all emojis including new ones released in iOS 9
- detect that a string contains emoji
- detect that a string contains emoji only, optionally allowing for whitespace (defaults to true)
- convert emoji shortcut codes in strings into their emoji equivalents
- get suggested emoji shortcut codes from a search string

## Installing

Use SwiftPM to include EmojiTools in your project.

##Usage
Emoji Detection:
``` swift
import EmojiTools

func someFunction() {
    let emojiContainingString = "This 😀😎👩‍👩‍👧‍👧 string 🌲🐯🌛 has 🍉☕️🍻 a 🎆🏀🎼 lot 🚌🗽✈️ of 📞🔦✉️ emoji. 8️⃣🔡🕒"
    let containsEmoji = emojiContainingString.containsEmoji() // true 
    let emojiOnlyWhitespaceString = "😀😎👩‍👩‍👧‍👧 🌲🐯🌛 🍉☕️🍻 🎆🏀🎼   🚌🗽✈️     📞🔦✉️ 8️⃣🔡🕒"
    let containsEmojiOnly = emojiOnlyWhitespaceString.containsEmojiOnly() // true
    let containsEmojiOnlyAndNoWhitespace = emojiOnlyWhitespaceString.containsEmojiOnly(false) // false
}
```

Emoji Shortcut Codes
```swift
import EmojiTools

func someFunction() {
    let emojiShortcutCodeString = "The :monkey: is trying to buy a :banana: with some :moneybag: at the :convenience_store:."
    let processedEmojiString = emojiShortcutCodeString.emojiString() // "The 🐒 is trying to buy a 🍌 with some 💰 at the 🏪."
}
```

## Author
- [Todd Kramer](http://www.tekramer.com)

## License
EmojiTools is available under the MIT license. See the [full license here.](./LICENSE.txt)
