//
//  Array+Extension.swift
//
//  Created by Bishal Ghimire on 6/7/16.
//  Copyright © 2016 Bishal Ghimire. All rights reserved.
//
// http://stackoverflow.com/questions/24027116/how-can-i-extend-typed-arrays-in-swift

import Foundation

extension Array where Element: Equatable {

  mutating func arrayAfterRemoveElement(_ object: Element) -> [Element] {
    return filter { $0 != object }
  }

  mutating func countOfElementByRemovingAllOccurrencesOfElement(_ element: Element) -> Int {
    var occurrences = 0
    while true {
      if let index = index(of: element) {
        remove(at: index)
        occurrences = occurrences + 1
      } else {
        return occurrences
      }
    }
  }
  
  // First tries to finds the element,
  //    - if found remove from the array
  //    - else add it to the array
  mutating func addOrRemoveElement(_ element: Element) {
    if index(of: element) != nil {
      self = arrayAfterRemoveElement(element)
    } else {
      self.append(element)
    }
  }
  
}

extension Array where Element: Equatable {
  
  func unique() -> [Element] {
    return self.reduce([Element]()) { elements, el in
      if elements.contains(el) {
        return elements
      }
      return elements + [el]
    }
  }
  
}

// https://github.com/ello

extension Array {
  
  func safeValue(_ index: Int) -> Element? {
    return (startIndex..<endIndex).contains(index) ? self[index] : .none
  }
  
  func find(_ test: (_ el: Element) -> Bool) -> Element? {
    for ob in self {
      if test(ob) {
        return ob
      }
    }
    return nil
  }
  
  func any(_ test: (_ aElement: Element) -> Bool) -> Bool {
    for object in self {
      if test(object) {
        return true
      }
    }
    return false
  }
  
  func all(_ test: (_ el: Element) -> Bool) -> Bool {
    for ob in self {
      if !test(ob) {
        return false
      }
    }
    return true
  }
  
}


