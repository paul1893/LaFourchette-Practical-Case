struct Promise<A, B: Error> {
    let result: Result<A, B>
    
    init(_ result: Result<A, B>) {
        self.result = result
    }
    
    func then(_ closure: @escaping (A) ->()) -> Promise<A, B> {
        if result.isSuccess {
            closure(try! result.get())
        }
        return self
    }
    
    func then<T>(_ closure: @escaping (A) -> T) -> T? {
        if result.isSuccess {
            return closure(try! result.get())
        }
        return nil
    }
    
    func `catch`(_ closure: @escaping () ->()) -> Promise<A, B> {
        if result.isError {
            closure()
        }
        return self
    }
}

extension Result {
    var isSuccess: Bool { if case .success = self { return true } else { return false } }
    var isError: Bool {  return !isSuccess  }
}
