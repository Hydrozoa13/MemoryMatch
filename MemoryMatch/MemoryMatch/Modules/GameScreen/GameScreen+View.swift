//
//  GameScreen+View.swift
//  MemoryMatch
//
//  Created by Евгений Лойко on 6.08.24.
//

import UIKit

extension GameScreen {
    class View: UIViewController {
        
        // MARK: - Properties
        
        var presenter: Presenter!
        private lazy var safeArea = self.view.safeAreaLayoutGuide
        
        private var cellWidth: CGFloat = 0
        private var cellHeight: CGFloat = 0
        private var slots = [UIImage?]()
        
        // MARK: - Subviews
        
        private let background = UIImageView(image: .gameBackground)
        private let counterView = UIImageView(image: .counterBackview)
        private let movesLabel = UILabel()
        private let timeLabel = UILabel()
        private let settingsBtn = Button(style: .small, normalImage: .settings)
        private let pauseBtn = Button(style: .small, normalImage: .pause, selectedImage: .playBtn)
        private let cancelBtn = Button(style: .small, normalImage: .cancel)
        private let restartBtn = Button(style: .small, normalImage: .restart)
        private let collection = CollectionView()
        
        // MARK: - Initializers
        
        init(with presenter: Presenter) {
            self.presenter = presenter
            super.init(nibName: nil, bundle: nil)
            
            presenter.view = self
            
            cellWidth = view.frame.width / 4.8
            cellHeight = view.frame.height / 11
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Lifecycle
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setup()
            setupSlots()
        }
        
        // MARK: - Private functions
        
        private func setupSlots() {
            let slotNames = ["slot0", "slot1", "slot2", "slot3", "slot4", "slot5", "slot6", "slot7"]
            
            var randomSlots = [UIImage]()
            
            for slotName in slotNames.prefix(upTo: slotNames.count) {
                if let image = UIImage(named: slotName) {
                    randomSlots.append(contentsOf: Array(repeating: image, count: 2))
                }
            }
            
            slots = randomSlots.shuffled()
        }
        
        private func showSettings() {
            let settingsMenu = Settings { [weak self] in
                guard let self else { return }
                
                if !pauseBtn.isSelected {
                    self.presenter.toggleTimer()
                }
                
            } dismissAction: { [weak self] in
                guard let self else { return }
                UIView.animate(withDuration: 0.3) {
                    self.view.layer.opacity = 0
                }
                self.pop(animated: true)
            }
            
            settingsMenu.show(in: self.view)
        }
        
        private func showWinnerPage() {
            let winnerPage = WinnerPage(count: presenter.movesCounter,
                                        time: presenter.time) { [weak self] in
                guard let self else { return }
                
                UIView.animate(withDuration: 0.3) {
                    self.collection.alpha = 0
                } completion: { _ in
                    self.startNewGame()
                    self.collection.alpha = 1
                }

            } dismissAction: { [weak self] in
                guard let self else { return }
                
                UIView.animate(withDuration: 0.3) {
                    self.view.layer.opacity = 0
                }
                self.pop(animated: true)
            }

            winnerPage.show(in: self.view)
        }
        
        private func startNewGame() {
            Vibration.vibrate(type: .rigid)
            slots.shuffle()
            collection.visibleCells.forEach { cell in
                guard let custedCell = cell as? CollectionViewCell else { return }
                custedCell.changeCurtainState(isOpening: false)
                custedCell.isUserInteractionEnabled = true
            }
            collection.reloadData()
            collection.isUserInteractionEnabled = true
            
            movesLabel.text = "MOVIES: 0"
            timeLabel.text = "TIME: 00:00"
            
            if pauseBtn.isSelected {
                pauseBtn.isSelected.toggle()
            }
            
            presenter.reloadAllCounts()
        }
        
        // MARK: - Methods
        
        private func setup() {
            buildHierarchy()
            configureSubviews()
            layoutSubviews()
            setupActions()
        }
        
        private func buildHierarchy() {
            view.addView(background)
            background.addView(counterView)
            counterView.addView(movesLabel)
            counterView.addView(timeLabel)
            background.addView(settingsBtn)
            background.addView(pauseBtn)
            background.addView(cancelBtn)
            background.addView(restartBtn)
            background.addView(collection)
        }
        
        private func configureSubviews() {
            background.isUserInteractionEnabled = true
            
            movesLabel.configure(text: "MOVIES: 0", font: .inter(of: 20), lineHeight: 24)
            timeLabel.configure(text: "TIME: 00:00", font: .inter(of: 20), lineHeight: 24)
            
            collection.delegate = self
            collection.dataSource = self
        }
        
        private func setupActions() {
            settingsBtn.addAction(UIAction(handler: { [weak self] _ in
                guard let self else { return }
                settingsBtn.buttonPressed {
                    if self.presenter.timerCounting {
                        self.presenter.toggleTimer()
                    }
                    self.showSettings()
                }
            }), for: .touchUpInside)
            
            pauseBtn.addAction(UIAction(handler: { [weak self] _ in
                guard let self else { return }
                pauseBtn.buttonPressed {
                    self.presenter.toggleTimer()
                    self.pauseBtn.isSelected.toggle()
                }
            }), for: .touchUpInside)
            
            cancelBtn.addAction(UIAction(handler: { [weak self] _ in
                guard let self else { return }
                cancelBtn.buttonPressed {
                    self.pop(animated: true)
                }
            }), for: .touchUpInside)
            
            restartBtn.addAction(UIAction(handler: { [weak self] _ in
                guard let self else { return }
                restartBtn.buttonPressed {
                    
                    if self.presenter.timerCounting {
                        self.presenter.toggleTimer()
                    }
                    
                    UIView.animate(withDuration: 0.3) {
                        self.collection.alpha = 0
                    } completion: { _ in
                        self.startNewGame()
                        self.collection.alpha = 1
                    }
                }
            }), for: .touchUpInside)
        }
        
        private func layoutSubviews() {
            NSLayoutConstraint.activate([
                background.topAnchor.constraint(equalTo: view.topAnchor),
                background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                counterView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
                counterView.heightAnchor.constraint(equalTo: counterView.widthAnchor, multiplier: 0.124),
                counterView.topAnchor.constraint(equalTo: background.topAnchor, constant: 120),
                counterView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                
                movesLabel.centerYAnchor.constraint(equalTo: counterView.centerYAnchor),
                movesLabel.leadingAnchor.constraint(equalTo: counterView.leadingAnchor, constant: 22),
                
                timeLabel.centerYAnchor.constraint(equalTo: counterView.centerYAnchor),
                timeLabel.leadingAnchor.constraint(equalTo: counterView.centerXAnchor, constant: 36),
                
                settingsBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.112),
                settingsBtn.heightAnchor.constraint(equalTo: settingsBtn.widthAnchor),
                settingsBtn.bottomAnchor.constraint(equalTo: counterView.topAnchor, constant: -12),
                settingsBtn.leadingAnchor.constraint(equalTo: counterView.leadingAnchor, constant: 6),
                
                collection.widthAnchor.constraint(equalTo: view.widthAnchor),
                collection.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
                collection.centerXAnchor.constraint(equalTo: background.centerXAnchor),
                collection.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
                
                pauseBtn.widthAnchor.constraint(equalTo: settingsBtn.widthAnchor),
                pauseBtn.heightAnchor.constraint(equalTo: pauseBtn.widthAnchor),
                pauseBtn.topAnchor.constraint(equalTo: collection.bottomAnchor, constant: 60),
                pauseBtn.leadingAnchor.constraint(equalTo: counterView.leadingAnchor),
                
                cancelBtn.widthAnchor.constraint(equalTo: pauseBtn.widthAnchor),
                cancelBtn.heightAnchor.constraint(equalTo: cancelBtn.widthAnchor),
                cancelBtn.topAnchor.constraint(equalTo: pauseBtn.topAnchor),
                cancelBtn.centerXAnchor.constraint(equalTo: background.centerXAnchor, constant: -10),
                
                restartBtn.widthAnchor.constraint(equalTo: cancelBtn.widthAnchor),
                restartBtn.heightAnchor.constraint(equalTo: restartBtn.widthAnchor),
                restartBtn.topAnchor.constraint(equalTo: cancelBtn.topAnchor),
                restartBtn.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -40)
            ])
        }
    }
}


// MARK: - Extension View

extension GameScreen.View: GameScreenView, UICollectionViewDelegate, UICollectionViewDataSource,
                           UICollectionViewDelegateFlowLayout {
    
    func changeCollectionState() {
        collection.isUserInteractionEnabled = presenter.timerCounting ? true : false
    }
    
    func updateTimeLabel() {
        timeLabel.text = "TIME: " + presenter.time
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        guard let collection = collectionView as? CollectionView else { fatalError("CollectionView is nil")}
        
        let totalCellWidth = cellWidth * 4
        let totalSpacingWidth = collection.spacing 
        let sideInset = (view.frame.size.width - (totalCellWidth + totalSpacingWidth)) / 3
        
        return UIEdgeInsets(top: 0, left: sideInset, bottom: 0, right: sideInset)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { slots.count }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier,
                                                       for: indexPath) as? CollectionViewCell
        else { fatalError("The collectionView could not dequeue a CollectionViewCell") }
        
        cell.setupCell(with: slots[indexPath.row]!)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath != presenter.firstIndexPath {
            Vibration.vibrate(type: .selection)
            presenter.movesCounter += 1
            movesLabel.text = "MOVIES: " + "\(presenter.movesCounter)"
        }
        
        guard let currentImage = slots[indexPath.item] else { return }
        
        if let firstIndexPath = presenter.firstIndexPath {
            if firstIndexPath == indexPath {
                return
            }
            
            if let firstImage = slots[firstIndexPath.item], firstImage == currentImage {
                Vibration.vibrate(type: .success)
                SoundManager.playSound(type: .pair)
                presenter.pairsCount += 1
                collectionView.cellForItem(at: firstIndexPath)?.isUserInteractionEnabled = false
                collectionView.cellForItem(at: indexPath)?.isUserInteractionEnabled = false
                presenter.firstIndexPath = nil
            } else {
                collectionView.isUserInteractionEnabled = false
                Vibration.vibrate(type: .error)
                SoundManager.playSound(type: .notPair)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
                    guard let self else { return }
                    
                    if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell {
                        cell.changeCurtainState(isOpening: false)
                    }
                    
                    if let firstCell = collectionView.cellForItem(at: firstIndexPath) as? CollectionViewCell {
                        firstCell.changeCurtainState(isOpening: false)
                    }
                    
                    self.presenter.firstIndexPath = nil
                    collectionView.isUserInteractionEnabled = true
                }
            }
        } else {
            presenter.firstIndexPath = indexPath
        }
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell else { return }
        cell.changeCurtainState()
        
        if presenter.pairsCount == slots.count / 2 {
            Vibration.vibrate(type: .heavy)
            SoundManager.playSound(type: .win)
            presenter.toggleTimer()
            showWinnerPage()
        }
    }
}
