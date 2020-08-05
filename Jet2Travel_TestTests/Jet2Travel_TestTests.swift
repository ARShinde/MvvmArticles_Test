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
