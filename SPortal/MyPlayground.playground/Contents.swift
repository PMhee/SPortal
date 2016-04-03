//: Playground - noun: a place where people can play

import UIKit
import Foundation
let text = "Tanakorn Rattanajariya"
var count = 0;
var range: Range<String.Index> = text.rangeOfString(" ")!
var index: Int = text.startIndex.distanceTo(range.startIndex)
for i in 0...index-1{
    let index = text.startIndex.advancedBy(i)
    print(text[index])
    count++
}
text.substringWithRange(Range<String.Index>(start: text.startIndex.advancedBy(0), end: text.startIndex.advancedBy(index)))
range = text.substringWithRange(Range<String.Index>(start: text.startIndex.advancedBy(index+1), end: text.endIndex.advancedBy(0))).rangeOfString("/")!
var r = text.startIndex.distanceTo(range.startIndex)
index++
for i in index...index+r-1{
    let index = text.startIndex.advancedBy(i)
    print(text[index])
    count++
}
count+=2
text.substringWithRange(Range<String.Index>(start: text.startIndex.advancedBy(count), end: text.endIndex.advancedBy(0)))

var t = "10:00-11:00"
t.substringWithRange(Range<String.Index>(start: t.startIndex.advancedBy(0), end: t.endIndex.advancedBy(-6)))
t.substringWithRange(Range<String.Index>(start: t.startIndex.advancedBy(6), end: t.endIndex.advancedBy(0)))
