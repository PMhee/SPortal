//: Playground - noun: a place where people can play

import UIKit
import Foundation

let morningOfChristmasComponents = NSDateComponents()
morningOfChristmasComponents.year = 2014
morningOfChristmasComponents.month = 12
morningOfChristmasComponents.day = 25
morningOfChristmasComponents.hour = 7
morningOfChristmasComponents.minute = 0
morningOfChristmasComponents.second = 0

let morningOfChristmas = NSCalendar.currentCalendar().dateFromComponents(morningOfChristmasComponents)!

let formatter = NSDateFormatter()
formatter.dateStyle = NSDateFormatterStyle.LongStyle
let dateString = formatter.stringFromDate(morningOfChristmas)
let timeString = formatter.stringFromDate(morningOfChristmas)