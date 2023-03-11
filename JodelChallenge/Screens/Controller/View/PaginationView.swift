//
//  PaginationView.swift
//  JodelChallenge
//
//  Created by Alexander Ruder on 11.03.23.
//  Copyright © 2023 Jodel. All rights reserved.
//
import UIKit

class PaginationView: UIView {
    let previousButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    let currentPageLabel = UILabel()

    var currentPage = 1 {
        didSet {
            currentPageLabel.text = "\(currentPage)"
        }
    }
//
//    var totalPages = 1 {
//        didSet {
//            updateCurrentPageLabel()
//        }
//    }

    var previousButtonHandler: (() -> Void)?
    var nextButtonHandler: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        backgroundColor = .white

        previousButton.setTitle("<<", for: .normal)
        previousButton.addTarget(self, action: #selector(showPreviousPage), for: .touchUpInside)
        addSubview(previousButton)

        nextButton.setTitle(">>", for: .normal)
        nextButton.addTarget(self, action: #selector(showNextPage), for: .touchUpInside)
        addSubview(nextButton)

        addSubview(currentPageLabel)

        previousButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        currentPageLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            previousButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            previousButton.centerYAnchor.constraint(equalTo: centerYAnchor),

            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nextButton.centerYAnchor.constraint(equalTo: centerYAnchor),

            currentPageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            currentPageLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    @objc func showPreviousPage() {
        previousButtonHandler?()
    }

    @objc func showNextPage() {
        nextButtonHandler?()
    }

    func updateCurrentPageLabel(currentPage: Int) {
        self.currentPage = currentPage
    }
}

