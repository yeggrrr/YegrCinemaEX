//
//  TrendTableViewCell.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/10/24.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    let dateGenreStackView = UIStackView()
    let dateLabel = UILabel()
    let genreLabel = UILabel()
    
    let mainView = UIView()
    let posterImageView = UIImageView()
    let clipButton = UIButton(type: .system)
    let gradeStackeVeiw = UIStackView()
    let gradeLabel = UILabel()
    let gradeNumLabel = UILabel()
    
    let mainTitleView = UIView()
    let titleLabel = UILabel()
    let charactersLabel = UILabel()
    let dividerView = UIView()
    let learnMoreButton = UIButton()
    
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
        
        mainView.addSubview(mainTitleView)
        
        mainView.addSubview(gradeStackeVeiw)
        gradeStackeVeiw.addArrangedSubview(gradeLabel)
        gradeStackeVeiw.addArrangedSubview(gradeNumLabel)
        
        mainTitleView.addSubview(titleLabel)
        mainTitleView.addSubview(charactersLabel)
        mainTitleView.addSubview(dividerView)
        mainTitleView.addSubview(learnMoreButton)
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
        
        gradeLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(45)
        }
        
        gradeNumLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.width.equalTo(45)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(mainTitleView.snp.top).offset(20)
            $0.horizontalEdges.equalTo(mainTitleView)
            $0.height.equalTo(30)
        }
        
        charactersLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.equalTo(mainTitleView)
            $0.height.equalTo(20)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(charactersLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(mainTitleView)
            $0.height.equalTo(1)
        }
        
        learnMoreButton.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(mainTitleView)
            $0.bottom.equalTo(mainView).offset(-10)
        }

    }
    
    func configureUI()  {
        dateGenreStackView.axis = .vertical
        
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
        posterImageView.contentMode = .scaleAspectFill
        
        clipButton.backgroundColor = .white
        clipButton.setImage(UIImage(systemName: "paperclip"), for: .normal)
        clipButton.tintColor = .black
        clipButton.layer.cornerRadius = 20
        
        mainTitleView.backgroundColor = .white
        
        gradeStackeVeiw.backgroundColor = .clear
        gradeStackeVeiw.axis = .horizontal
        gradeStackeVeiw.distribution = .fillEqually
        
        gradeLabel.backgroundColor = .systemIndigo
        gradeLabel.text = "평점"
        gradeLabel.textAlignment = .center
        gradeLabel.textColor = .white
        gradeLabel.font = .systemFont(ofSize: 15)
        
        gradeNumLabel.backgroundColor = .white
        gradeNumLabel.textAlignment = .center
        gradeNumLabel.textColor = .label
        gradeNumLabel.font = .systemFont(ofSize: 15)
        
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 22)
        
        charactersLabel.text = "Kento Yamazaki, Tao Tsuchiya, Nijiro Murakami..."
        charactersLabel.textAlignment = .left
        charactersLabel.font = .systemFont(ofSize: 17)
        
        dividerView.backgroundColor = .darkGray
        
        learnMoreButton.setTitle("자세히 보기", for: .normal)
        learnMoreButton.setTitleColor(.label, for: .normal)
        learnMoreButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        learnMoreButton.tintColor = .label
        learnMoreButton.semanticContentAttribute = .forceRightToLeft
    }
}