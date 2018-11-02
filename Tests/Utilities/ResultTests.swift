import Nimble
import Quick

@testable import Zomavan

final class ResultTests: QuickSpec {

    override func spec() {

        describe("a Result") {

            var subject: Result<Int, URLError>!

            afterEach {
                subject = nil
            }

            context("that represents a success") {

                beforeEach {
                    subject = .success(10)
                }

                it("captures a value") {

                    var value: Int?

                    if case let .success(capturedValue)? = subject {
                        value = capturedValue
                    }

                    expect(value).toNot(beNil())
                }
            }

            context("that represents a failure") {

                beforeEach {
                    subject = .failure(URLError(.badServerResponse))
                }

                it("captures an error") {

                    var error: Error?

                    if case let .failure(capturedError)? = subject {
                        error = capturedError
                    }

                    expect(error).toNot(beNil())
                }
            }
        }
    }
}

final class AnyErrorTests: QuickSpec {

    override func spec() {

        describe("an Any Error") {

            var subject: AnyError!

            afterEach {
                subject = nil
            }

            it("captures an underlying error provided to it") {

                subject = AnyError(URLError(.badServerResponse))

                expect(subject.error as? URLError).to(equal(URLError(.badServerResponse)))
            }

            it("does not introduce another layer if it is to capture another Any Error") {

                let someError = AnyError(NetworkError.unknownError)

                subject = AnyError(someError) // someError is of type 'AnyError'.

                expect(subject.error).toNot(beAnInstanceOf(AnyError.self))
                expect(subject.error).to(beAnInstanceOf(NetworkError.self))
            }
        }
    }
}
