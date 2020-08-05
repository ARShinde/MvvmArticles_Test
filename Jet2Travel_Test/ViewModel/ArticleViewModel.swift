import Foundation

protocol ArticleResponseDelegate: AnyObject {
  func didRecieveArticles(data: [Article])
  func didRecieveError(error: String)
}

class ArticleViewModel {
  var currentPageIndex: Int = 0
  weak var responseDelegate: ArticleResponseDelegate?
  
  init(pageIndex: Int) {
    self.currentPageIndex = pageIndex
  }
  
  func fetchArticles() {
    Router.getAllArticles(pageIndex: currentPageIndex) { [weak self] (result: Result<[Article], Error>) in
      switch result {
        case .success(let articleList):
        self?.responseDelegate?.didRecieveArticles(data: articleList)
      case .failure(let error):
        self?.responseDelegate?.didRecieveError(error: error.localizedDescription)
      }
    }
  }
}
