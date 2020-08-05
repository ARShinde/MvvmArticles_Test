import XCTest
@testable import Jet2Travel_Test

class Jet2Travel_TestTests: XCTestCase {
  
  var fetchArticleExp: XCTestExpectation?
  let viewModel = ArticleViewModel(pageIndex: 1)
  
  override func setUp() {
    viewModel.responseDelegate = self
  }

  override func tearDown() {
  }

  func testFetchArticles() {
    fetchArticleExp = expectation(description: "fetch articles")
    viewModel.fetchArticles()
    wait(for: [fetchArticleExp!], timeout: 3)
  }
  
  func testElapsedInterval() {
    let dateInput = "2020-04-17T10:54:59.967Z"    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let toDate = formatter.date(from: "2020-05-17T10:54:59.967Z")
    XCTAssertNotNil(toDate)
    let elapsedTimeString = DateUtility.getElapsedInterval(dateString: dateInput, toDate: toDate!)
    let output = "1 month ago"
    XCTAssertNotNil(elapsedTimeString!)
    XCTAssertEqual(elapsedTimeString, output)
  }
}

extension Jet2Travel_TestTests: ArticleResponseDelegate {
  func didRecieveArticles(data: [Article]) {
    XCTAssertTrue(data.count > 0, "got data")
    XCTAssertNotNil(data.first?.id)
    fetchArticleExp?.fulfill()
  }
  
  func didRecieveError(error: String) {
    XCTFail("request timeout unable to get data from webservice")
  }
}
