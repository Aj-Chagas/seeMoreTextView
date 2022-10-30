//
//  HomeView.swift
//  navigationBariOS13
//
//  Created by Anderson Chagas on 21/08/22.
//

import UIKit

final class HomeView: LayoutView {
    
    private enum Layout {
        static let constant16: CGFloat = 16
        static let constant8: CGFloat = 8
    }

    private let title: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.backgroundColor = .red
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        return label
    }()

    private let readMoreTextView: ReadMoreTextView = {
        let view = ReadMoreTextView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textContainer.maximumNumberOfLines = 3
        view.backgroundColor = .gray
        return view
    }()

    override func buildViewHierarchy() {
        addSubview(readMoreTextView)
    }

    override func setupConstraints() {
        [
            readMoreTextView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            readMoreTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
            readMoreTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
        ].activate()
    }

    override func configureViews() {

        let attributedText = NSAttributedString(string: "Temos mais 3 cores: azul, verde e vermelho. Mas dependendo da região que você estiver, isso pode variar.", attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.blue
        ])

        readMoreTextView.attributedText = attributedText
        backgroundColor = .white
    }

}

final class ReadMoreTextView: UITextView {

    private var originalText: String?
    private var originalAttributedString: NSAttributedString?
    private var isfirstTimeDidSetCalled: Int = 0
    private var wasSuffixAdded: Bool = false

    var suffixText: String = "... ver mais"

    override var text: String? {
        didSet {
            originalText = self.text

            if isfirstTimeDidSetCalled == .zero {
                isfirstTimeDidSetCalled += 1
                addSuffixIfNeeded(characterLengthThatFits: characterRangeThatFits().length, suffixText: suffixText)
            }
        }
    }

    override var attributedText: NSAttributedString? {
        didSet {
            if isfirstTimeDidSetCalled == .zero {
                originalAttributedString = self.attributedText
                isfirstTimeDidSetCalled += 1
                addSuffixIfNeeded(characterLengthThatFits: characterRangeThatFits().length, suffixText: suffixText)
            }
        }
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        isScrollEnabled = false
        isEditable = false
        addGestureRecognizerIfNeeded()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //unimplemented()
    }

    func showOriginalText() {
        guard wasSuffixAdded else { return }
        attributedText = originalAttributedString
        textContainer.maximumNumberOfLines = 0
    }

}

// MARK: - private functions

extension ReadMoreTextView {
    private func addSuffixIfNeeded(characterLengthThatFits: Int, suffixText: String) {
        guard let originalText = originalAttributedString?.string else { return }

        let shouldAddSuffixText = originalText.count > characterLengthThatFits
        let spaceForSuffix = characterLengthThatFits - suffixText.count
        let hasValidOffSet = spaceForSuffix > .zero && spaceForSuffix < characterLengthThatFits

        if  shouldAddSuffixText && hasValidOffSet {
            let originalTextIndex = originalText.index(
                originalText.startIndex,
                offsetBy: spaceForSuffix
            )
            // let newTextWithPrefixAndSuffix = String(originalText.prefix(upTo: originalTextIndex)) + suffixText
            // attributedText = NSAttributedString(string: newTextWithPrefixAndSuffix)

            let prefix = String(originalText.prefix(upTo: originalTextIndex))
            let prefixAttributed = NSAttributedString(string: prefix, attributes: [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.blue
            ])

            let suffixAttributed =  NSAttributedString(string: suffixText, attributes: [
                .font: UIFont.systemFont(ofSize: 14),
                .foregroundColor: UIColor.blue.withAlphaComponent(0.5),
                .underlineStyle : NSUnderlineStyle.single.rawValue
            ])

            let mutableString = NSMutableAttributedString()
            mutableString.append(prefixAttributed)
            mutableString.append(suffixAttributed)
            attributedText = mutableString

            wasSuffixAdded = true
            return
        }
        wasSuffixAdded = false
    }

    private func characterRangeThatFits() -> NSRange {
        return layoutManager.characterRangeThatFits(textContainer: textContainer)
    }

    private func addGestureRecognizerIfNeeded() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
    }

    @objc
    func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        showOriginalText()
    }
}

extension NSLayoutManager {
    func characterRangeThatFits(textContainer container: NSTextContainer) -> NSRange {
        let rangeThatFits = glyphRange(for: container)
        return characterRange(forGlyphRange: rangeThatFits, actualGlyphRange: nil)
    }
}
