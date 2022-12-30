//
//  BulletViewController.swift
//  Example
//
//  Created by Lazyman on 12/31/22.
//

import UIKit
import Nantes

struct BulletRow {
    let description: String
    let links: [Link]
}

struct Link {
    let text: String
    let href: String
}

extension Link {
    var url: URL? {
        return URL(string: href)
    }
}

class BulletViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    
    private let bulletList = [
        BulletRow(description: "Hello Contract list", links: [Link(text: "Contract", href: "/contract")]),
        BulletRow(description: "Hello C# programming", links: [Link(text: "C#", href: "program/csharp")]),
        BulletRow(description: "Hello Java Programming", links: [Link(text: "Java", href: "program/java")]),
        BulletRow(description: "Hello terms condition", links: [Link(text: "terms condition", href: "terms/condition")]),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        makeBulletList(list: bulletList)
    }
}

extension BulletViewController: NantesLabelDelegate {
    func makeBulletList(list: [BulletRow]) {
        for item in list {
            let stack = makeBulletRow(with: item, delegate: self)
            stackView.addArrangedSubview(stack)
        }
    }
    
    func makeBulletRow(with item: BulletRow, delegate: NantesLabelDelegate) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .top
        
        let bulletLabel = UILabel(frame: .zero)
        bulletLabel.text = " • "
        bulletLabel.snp.makeConstraints { make in
            make.width.equalTo(15)
            make.height.equalTo(20)
        }
        
        stack.addArrangedSubview(bulletLabel)
        
        let contentLabel = NantesLabel(frame: .zero)
        contentLabel.delegate = delegate
        contentLabel.numberOfLines = 0
        
        let attributedString = NSMutableAttributedString(string: item.description)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value:UIColor(hex: 0x333333), range:NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.font, value:UIFont.systemFont(ofSize: 17.0), range:NSMakeRange(0, attributedString.length))
        contentLabel.attributedText = attributedString
        
        contentLabel.linkAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(hex: 0x0A84FF),
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17.0)
        ]
        contentLabel.activeLinkAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(hex: 0x0A84FF),
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17.0)
        ]
        for link in item.links {
            if let url = link.url {
                contentLabel.addLink(to: url, withRange: (item.description as NSString).range(of: link.text))
            }
        }
        
        stack.addArrangedSubview(contentLabel)
        stack.translatesAutoresizingMaskIntoConstraints = false;

        return stack
    }
    
    func attributedLabel(_ label: NantesLabel, didSelectAddress addressComponents: [NSTextCheckingKey: String]) {
        print("Tapped address: \(addressComponents)")
    }
    
    func attributedLabel(_ label: NantesLabel, didSelectDate date: Date, timeZone: TimeZone, duration: TimeInterval) {
        print("Tapped Date: \(date), in time zone: \(timeZone), with duration: \(duration)")
    }
    
    func attributedLabel(_ label: NantesLabel, didSelectLink link: URL) {
        print("Tapped link: \(link)")
    }
    
    func attributedLabel(_ label: NantesLabel, didSelectPhoneNumber phoneNumber: String) {
        print("Tapped phone number: \(phoneNumber)")
    }
    
    func attributedLabel(_ label: NantesLabel, didSelectTransitInfo transitInfo: [NSTextCheckingKey: String]) {
        print("Tapped transit info: \(transitInfo)")
    }
}
