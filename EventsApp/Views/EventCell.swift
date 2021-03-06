//
//  EventCell.swift
//  EventsApp
//
//  Created by Ibragim Akaev on 28/05/2021.
//

import UIKit

final class EventCell: UITableViewCell {
    private let timeRemainingStackView = TimeRemainingStackView()
    private let eventNameLabel         = UILabel()
    private let dateLabel              = UILabel()
    private let backgroundImage        = UIImageView()
    private var verticalStack          = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        timeRemainingStackView.setup()
        
        [eventNameLabel, dateLabel, backgroundImage, verticalStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [dateLabel, eventNameLabel].forEach { $0.textColor = .white}
        dateLabel.font           = .systemFont(ofSize: 16, weight: .medium)
        eventNameLabel.font      = .systemFont(ofSize: 28, weight: .bold)
        verticalStack.axis       = .vertical
        verticalStack.alignment  = .trailing
        
        verticalStack.addArrangedSubview(timeRemainingStackView)
        verticalStack.addArrangedSubview(UIView())
        verticalStack.addArrangedSubview(dateLabel)
        
        addSubviews(backgroundImage, verticalStack, eventNameLabel)
    }
    
    private func setupLayout() {
        backgroundImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        backgroundImage.pinToSuperviewEdges()
        verticalStack.pinToSuperviewEdges([.top, .right, .bottom], constant: 15)
        eventNameLabel.pinToSuperviewEdges([.left, .bottom], constant: 10)
    }
    
    func update(with viewModel: EventCellViewModel) {
        if let timeRemainingViewModel = viewModel.timeRemainingViewModel {
            timeRemainingStackView.update(with: timeRemainingViewModel)
        }
        
        dateLabel.text        = viewModel.dateText
        eventNameLabel.text   = viewModel.eventText
        viewModel.loadImage { self.backgroundImage.image = $0 }
    }
}
