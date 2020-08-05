import UIKit

class ArticleViewController: UIViewController {

  @IBOutlet private var tableView: UITableView!
  
  private enum Constants {
    static let ArticleKey = "allStoredArticle"
    static let ArticleCell = "articleCell"
  }

  private var articles = [Article]() {
    didSet {
      self.tableView.reloadData()
    }
  }

  private lazy var viewModel : ArticleViewModel = {
    return ArticleViewModel(pageIndex: 1)
  }()
  
  private let spinner = UIActivityIndicatorView(style: .large)

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    initUI()
    if !Reachability.isConnectedToNetwork() {
      // Fetch from User Defaults
      guard let decodedData = UserDefaults.standard.data(forKey: Constants.ArticleKey) else { return }
      articles = try! JSONDecoder().decode([Article].self, from: decodedData)
    } else{
      viewModel.responseDelegate = self
      viewModel.fetchArticles()
    }
  }

  private func initUI() {
    spinner.hidesWhenStopped = true
    spinner.color = UIColor.gray
    tableView.tableFooterView = spinner
  }
    
  private func loadNextArticles () {
    if Reachability.isConnectedToNetwork() {
      viewModel.currentPageIndex += 1
      viewModel.fetchArticles()
    }
  }
}

extension ArticleViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ArticleCell) as? ArticleTableViewCell else {
      return UITableViewCell()
    }
    cell.configure(data: articles[indexPath.row])
    cell.delegate = self
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let offset = scrollView.contentOffset
    let bounds = scrollView.bounds
    let size = scrollView.contentSize
    let insets = scrollView.contentInset
    
    let yPos = offset.y + bounds.size.height - insets.bottom
    let height = size.height
    
    if yPos > height {
      // got last record load more
      spinner.startAnimating()
      loadNextArticles()
    }
  }
}

extension ArticleViewController: ArticleResponseDelegate {
  func didRecieveArticles(data: [Article]) {
    spinner.stopAnimating()
    if data.isEmpty {
      let alert = UIAlertController(title: "END OF LIST", message: "You have read all articles. Plase come back later to view more", preferredStyle: .actionSheet)
      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      self.present(alert, animated: true)
    }
    articles.count == 0 ? articles = data : articles.append(contentsOf: data)
    
    UserDefaults.standard.removeObject(forKey: Constants.ArticleKey)
    let encodedData = try! JSONEncoder().encode(articles)
    UserDefaults.standard.set(encodedData, forKey: Constants.ArticleKey)
    tableView.reloadData()
  }

  func didRecieveError(error: String) {
    spinner.stopAnimating()
    print("got error while fetching data")
  }
}

extension ArticleViewController: ArticleTableViewCellProtocol {
  func didTappedOnURL(url: URL) {
    if UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url)
    }
  }
}
