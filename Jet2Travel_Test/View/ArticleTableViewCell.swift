import UIKit

@objc protocol ArticleTableViewCellProtocol {
  func didTappedOnURL(url: URL)
  @objc optional func didTappedOnLikeButton()
  @objc optional func didTappedOnCommentButton()
}

class ArticleTableViewCell: UITableViewCell {
  
  private struct constants {
    static let ArticleImageViewDefaultHeight: CGFloat = 160.0
    static let LinkURLDefaultHeight:CGFloat = 14.0
  }

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var designation: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var iconPromoImageView: UIImageView!
  @IBOutlet weak var articleImageView: UIImageView!
  @IBOutlet weak var commentsButton: UIButton!
  @IBOutlet weak var noOfLikesButton: UIButton!
  @IBOutlet weak var urlLinkButton: UIButton!
  @IBOutlet weak var articleCreatedTime: UILabel!

  @IBOutlet weak var linkURLHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var articleImageViewHeightConstraint: NSLayoutConstraint!

  weak var delegate: ArticleTableViewCellProtocol?
  var linkTapped: ((URL) -> Void)?
  private var currentURL: URL?

  override func awakeFromNib() {
    super.awakeFromNib()
    initUI()
  }
  
  private func initUI() {
    linkURLHeightConstraint.constant = 0
    articleImageViewHeightConstraint.constant = 0
  }
  
  func configure(data: Article) {
    noOfLikesButton.setTitle("\(data.likes) Likes", for: .normal)
    commentsButton.setTitle("\(data.comments) Comments", for: .normal)
    descriptionLabel.text = data.content
    print(data.createdAt)
    if let dateStr = DateUtility.getElapsedInterval(dateString: data.createdAt, toDate: Date()) {
      articleCreatedTime.text = dateStr
    } else {
      articleCreatedTime.text = data.createdAt
    }
    
    if let userData = data.user.first {
      nameLabel.text = userData.name + userData.lastname
      designation.text = userData.designation
      if let iconPromoURL = URL(string: userData.avatar), !userData.avatar.isEmpty {
        iconPromoImageView.downloadImageFrom(url: iconPromoURL)
      }
    }
    
    if let mediaData = data.media.first {
      if let avatarImageURL = URL(string: mediaData.image), !mediaData.image.isEmpty {
        articleImageView.downloadImageFrom(url: avatarImageURL)
      }
      if !mediaData.url.isEmpty {
        linkURLHeightConstraint.constant = constants.LinkURLDefaultHeight
        if let mediaURL = URL(string: mediaData.url) {
          currentURL = mediaURL
        }
        urlLinkButton.setTitle(mediaData.url, for: .normal)
      }
      if !mediaData.image.isEmpty {
        articleImageViewHeightConstraint.constant = constants.ArticleImageViewDefaultHeight
      }
    }
  }
  
  @IBAction func linkTapped(_ sender: Any) {
    if let currentURL = currentURL {
      delegate?.didTappedOnURL(url: currentURL)
    }
  }
}
