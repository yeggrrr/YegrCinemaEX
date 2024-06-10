//
//  TrendTableViewCell.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/10/24.
//

import UIKit
import SnapKit

class TrendTableViewCell: UITableViewCell {
    let dateGenreStackView = UIStackView()
    let dateLabel = UILabel()
    let genreLabel = UILabel()
    
    let mainView = UIView()
    
    let posterImageView = UIImageView()
    
    let gradeStackeVeiw = UIStackView()
    let gradeLabel = UILabel()
    let gradeNumLabel = UILabel()
    
    let mainTitleStackView = UIStackView()
    let titleLabel = UILabel()
    let charactersLabel = UILabel()
    
    let dividerView = UIView()
    
    let learnMoreLabel = UILabel()
    let learnMoreButton = UIButton()
    
    let clipButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configurHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurHierarchy() {
        contentView.addSubview(dateGenreStackView)
        dateGenreStackView.addArrangedSubview(dateLabel)
        dateGenreStackView.addArrangedSubview(genreLabel)
        
        contentView.addSubview(mainView)
        mainView.addSubview(posterImageView)
        
        posterImageView.addSubview(clipButton)
        posterImageView.addSubview(gradeStackeVeiw)
        gradeStackeVeiw.addArrangedSubview(gradeLabel)
        gradeStackeVeiw.addArrangedSubview(gradeNumLabel)
        
        
        mainView.addSubview(mainTitleStackView)
        mainTitleStackView.addArrangedSubview(titleLabel)
        mainTitleStackView.addArrangedSubview(charactersLabel)
        
        mainView.addSubview(dividerView)
        
        mainView.addSubview(learnMoreLabel)
        mainView.addSubview(learnMoreButton)
    }
    
    func configureLayout() {
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
            $0.bottom.equalTo(safeArea).offset(-10)
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(mainView.snp.top)
            $0.horizontalEdges.equalTo(mainView)
            $0.height.equalTo(mainView).multipliedBy(0.65 / 1.0)
        }
        
        clipButton.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.top).offset(20)
            $0.trailing.equalTo(posterImageView.snp.trailing).offset(-20)
            $0.height.width.equalTo(40)
            
        }
        gradeStackeVeiw.snp.makeConstraints {
            $0.leading.equalTo(posterImageView.snp.leading).offset(20)
            $0.bottom.equalTo(posterImageView.snp.bottom).offset(-20)
            $0.height.equalTo(30)
        }
        
        gradeLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(45)
        }
        
        gradeNumLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(45)
        }
        
        mainTitleStackView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(15)
            $0.horizontalEdges.equalTo(mainView).inset(20)
            $0.height.equalTo(mainView).multipliedBy(0.15 / 1.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(mainTitleStackView).multipliedBy(0.6 / 1.0)
        }
        
        charactersLabel.snp.makeConstraints {
            $0.height.equalTo(mainTitleStackView).multipliedBy(0.4 / 1.0)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(mainTitleStackView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(mainTitleStackView)
            $0.height.equalTo(1)
        }
        
        learnMoreLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(10)
            $0.leading.equalTo(mainTitleStackView)
            $0.bottom.equalTo(mainView).offset(-10)
        }
        
        learnMoreButton.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(10)
            $0.trailing.equalTo(mainTitleStackView)
            $0.bottom.equalTo(mainView).offset(-10)
        }
    }
    
    func configureUI()  {
        dateGenreStackView.axis = .vertical
        
        dateLabel.text = "12/10/2020"
        dateLabel.textColor = .label
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textAlignment = .left
        
        genreLabel.text = "#Mystery"
        genreLabel.textColor = .label
        genreLabel.font = .boldSystemFont(ofSize: 18)
        genreLabel.textAlignment = .left
        
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
        
        posterImageView.backgroundColor = .systemGray5
        
        clipButton.backgroundColor = .white
        clipButton.setImage(UIImage(systemName: "paperclip"), for: .normal)
        clipButton.tintColor = .black
        clipButton.layer.cornerRadius = 20
        
        gradeStackeVeiw.backgroundColor = .clear
        gradeStackeVeiw.axis = .horizontal
        gradeStackeVeiw.distribution = .fillEqually
        
        gradeLabel.backgroundColor = .systemIndigo
        gradeLabel.text = "평점"
        gradeLabel.textAlignment = .center
        gradeLabel.textColor = .white
        gradeLabel.font = .systemFont(ofSize: 15)
        
        gradeNumLabel.backgroundColor = .white
        gradeNumLabel.text = "3.3"
        gradeNumLabel.textAlignment = .center
        gradeNumLabel.textColor = .label
        gradeNumLabel.font = .systemFont(ofSize: 15)
        
        mainTitleStackView.axis = .vertical
        
        titleLabel.text = "Alice in Borderland"
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 20)
        
        charactersLabel.text = "Kento Yamazaki, Tao Tsuchiya, Nijiro Murakami..."
        charactersLabel.textAlignment = .left
        charactersLabel.font = .systemFont(ofSize: 16)
        
        dividerView.backgroundColor = .darkGray
        
        learnMoreLabel.text = "자세히 보기"
        learnMoreLabel.textAlignment = .left
        learnMoreLabel.textColor = .label
        learnMoreLabel.font = .systemFont(ofSize: 15)
        
        learnMoreButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        learnMoreButton.tintColor = .label
    }
}
