import Foundation

extension Array {

    func appending(_ newElement: Element) -> [Element] {
        var new: [Element] = self
        new.append(newElement)
        return new
    }
}
