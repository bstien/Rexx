import Foundation
import Rex

let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In lacus ligula, placerat sit amet ornare ornare, venenatis at lacus. Quisque tempus nec augue sed tristique. Praesent placerat posuere erat eu blandit. Aliquam nec eros et diam venenatis ornare at nec nisi. In hac habitasse platea dictumst. Aenean vehicula porta diam, interdum ultricies erat pulvinar porttitor. Curabitur sollicitudin leo eros, pulvinar placerat sem semper eget. Morbi est ante, ullamcorper non mattis et, lacinia at nulla. Integer fermentum risus ipsum, id fermentum est varius at. Etiam vel metus nibh. Pellentesque nibh elit, blandit et tempor consectetur, viverra in sem. Phasellus sed tellus eros. Aliquam semper arcu sed fringilla imperdiet. Sed congue consectetur consectetur. Aliquam erat volutpat. Duis id velit et lectus volutpat rutrum in id tellus. Nullam semper eros feugiat enim imperdiet tincidunt. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Praesent rutrum est odio, dignissim lacinia lorem sollicitudin ut. Aliquam erat volutpat. Nulla sodales vitae erat et semper. Phasellus dolor lectus, gravida in orci sed, fermentum hendrerit ipsum."


// 1. Count the total number of words.
let allWords = try loremIpsum.match("(\\w+)")
print("Number of words:", allWords.captures.count)

// 2. Find all words longer than 5 characters.
let longWords = try loremIpsum.match("(\\w{5,})")
print("Number of long words:", longWords.captures.count)


// 3. Find all lowercased words longer than 5 characters.
let longLowercasedWords = try loremIpsum.match("\\b([a-z]{5,})\\b")
print("Number of long, lowercased words:", longLowercasedWords.captures.count)


// 4. Find all words starting with an uppercased character.
let uppercasedWords = try loremIpsum.match("([A-Z]\\w+)")
print("Number of uppercased words:", uppercasedWords.captures.count)


// 5. Find the last sentence.
let lastSentence = try loremIpsum.match(".*\\. (.*)$")
print("The last sentence in the text is:", lastSentence.captures.first!)


// 6. Find all words which contains the the letter sequence 'is', in some form.
let wordsContainingIS = try loremIpsum.match("(\\w*is\\w*)")
print("Number of words containing the sequence 'is':", wordsContainingIS.captures.count)
