import Nimble
import Quick

@testable import Zomavan

final class RestaurantListViewModelTests: QuickSpec {

    override func spec() {

        describe("a Restaurant List View Model") {

            var subject: RestaurantListViewModel!

            beforeEach {
                subject = RestaurantListViewModel()
            }

            afterEach {
                subject = nil
            }

            it("displays the correct title for the screen") {
                expect(subject.title).to(equal("Abbotsford"))
            }
        }
    }
}
