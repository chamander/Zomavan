import Nimble
import Quick

@testable import Zomavan

final class NetworkMethodTests: QuickSpec {

    override func spec() {

        describe("a Network Method") {

            var subject: NetworkMethod!

            afterEach {
                subject = nil
            }

            context("that represents 'get'") {

                beforeEach {
                    subject = .get
                }

                describe("httpMethod") {

                    it("returns the expected HTTP method") {
                        expect(subject.httpMethod).to(equal("GET"))
                    }
                }
            }
        }
    }
}
