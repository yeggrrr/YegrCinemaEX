//
//  MainTableViewCell.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/10/24.
//

import UIKit
import SnapKit

final class MainTableViewCell: UITableViewCell {
    private let dateGenreStackView = UIStackView()
    let dateLabel = UILabel()
    let genreLabel = UILabel()
    
    private let mainView = UIView()
    let posterImageView = UIImageView()
    let clipButton = UIButton(type: .system)
    private let gradeStackeVeiw = UIStackView()
    private let ScoreLabel = UILabel()
    let ScoreNumLabel = UILabel()
    
    private let mainTitleView = UIView()
    let titleLabel = UILabel()
    let charactersLabel = UILabel()
    private let dividerView = UIView()
    private let learnMoreButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configurHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurHierarchy() {
        contentView.addSubview(dateGenreStackView)
        dateGenreStackView.addArrangedSubview(dateLabel)
        dateGenreStackView.addArrangedSubview(genreLabel)
        
        contentView.addSubview(mainView)
        mainView.addSubview(posterImageView)
        contentView.addSubview(clipButton)
        
        mainView.addSubview(mainTitleView)
        
        mainView.addSubview(gradeStackeVeiw)
        gradeStackeVeiw.addArrangedSubview(ScoreLabel)
        gradeStackeVeiw.addArrangedSubview(ScoreNumLabel)
        
        mainTitleView.addSubview(titleLabel)
        mainTitleView.addSubview(charactersLabel)
        mainTitleView.addSubview(dividerView)
        mainTitleView.addSubview(learnMoreButton)
    }
    
    private func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        dateGenreStackView.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(10)
            $0.horizontalEdges.equalTo(safeArea).inset(10)
            $0.height.equalTo(50)
        }
        
        dateLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        genreLabel.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        mainView.snp.makeConstraints {
            $0.top.equalTo(dateGenreStackView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(safeArea).inset(10)
            $0.height.equalTo(mainView.snp.width)
            $0.bottom.equalTo(safeArea).offset(-20)
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(mainView.snp.top)
            $0.horizontalEdges.equalTo(mainView)
            $0.bottom.equalTo(mainView.snp.bottom)
        }
        
        clipButton.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.top).offset(20)
            $0.trailing.equalTo(posterImageView.snp.trailing).offset(-20)
            $0.height.width.equalTo(40)
            
        }
        
        mainTitleView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(mainView)
            $0.bottom.equalTo(mainView)
            $0.height.equalTo(mainView).multipliedBy(0.35 / 1.0)
        }
        
        gradeStackeVeiw.snp.makeConstraints {
            $0.leading.equalTo(mainView.snp.leading).offset(10)
            $0.bottom.equalTo(mainTitleView.snp.top).offset(-10)
            $0.height.equalTo(30)
        }
        
        ScoreLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(45)
        }
        
        ScoreNumLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(45)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(mainTitleView.snp.top).offset(20)
            $0.leading.equalTo(mainTitleView.snp.leading).offset(20)
            $0.trailing.equalTo(mainTitleView.snp.trailing).offset(-20)
            $0.height.equalTo(30)
        }
        
        charactersLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalTo(mainTitleView.snp.leading).offset(20)
            $0.trailing.equalTo(mainTitleView.snp.trailing).offset(-20)
            $0.height.equalTo(20)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(charactersLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(mainTitleView).inset(20)
            $0.height.equalTo(1)
        }
        
        learnMoreButton.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(mainTitleView)
            $0.bottom.equalTo(mainView).offset(-10)
        }

    }
    
    private func configureUI()  {
        dateGenreStackView.axis = .vertical
        dateLabel.setUI(aligment: .left, lbTextColor: .darkGray, fontStyle: .systemFont(ofSize: 14))
        genreLabel.setUI(aligment: .left, lbTextColor: .label, fontStyle: .boldSystemFont(ofSize: 20))
        
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
        
        posterImageView.backgroundColor = .systemGray5
        posterImageView.contentMode = .scaleAspectFill
        
        clipButton.backgroundColor = .white
        clipButton.setImage(UIImage(systemName: "paperclip"), for: .normal)
        clipButton.tintColor = .black
        clipButton.layer.cornerRadius = 20
        
        mainTitleView.backgroundColor = .white
        
        gradeStackeVeiw.backgroundColor = .clear
        gradeStackeVeiw.axis = .horizontal
        gradeStackeVeiw.distribution = .fillEqually
        gradeStackeVeiw.layer.cornerRadius = 5
        gradeStackeVeiw.clipsToBounds = true
        
        ScoreLabel.setUI(aligment: .center, lbTextColor: .white, fontStyle: .systemFont(ofSize: 15))
        ScoreLabel.backgroundColor = .systemIndigo
        ScoreLabel.text = "평점"
        ScoreNumLabel.setUI(aligment: .center, lbTextColor: .label, fontStyle: .systemFont(ofSize: 15))
        ScoreNumLabel.backgroundColor = .white
        
        titleLabel.setUI(aligment: .left, lbTextColor: .label, fontStyle: .boldSystemFont(ofSize: 22))
        charactersLabel.setUI(aligment: .left, lbTextColor: .darkGray, fontStyle: .systemFont(ofSize: 17))
        
        dividerView.backgroundColor = .darkGray
        
        learnMoreButton.setTitle("자세히 보기", for: .normal)
        learnMoreButton.setTitleColor(.label, for: .normal)
        learnMoreButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        learnMoreButton.tintColor = .label
        learnMoreButton.semanticContentAttribute = .forceRightToLeft
    }
}
