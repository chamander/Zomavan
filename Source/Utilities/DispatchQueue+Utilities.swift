import Foundation

extension DispatchQueue {

    static func synchronouslyOnMain<ReturnType>(execute closure: () throws -> ReturnType) rethrows -> ReturnType {
        if Thread.current.isMainThread {
            return try closure()
        } else {
            return try self.main.sync(execute: closure)
        }
    }
}

func safelyOnMainThread<T>(execute closure: () throws -> T) rethrows -> T {
    return try DispatchQueue.synchronouslyOnMain(execute: closure)
}
