//
//  GameOverViewController.swift
//  EmojiMatchingGame
//
//  Created by Vladimir Lesnykh on 05.10.2023.
//

import UIKit

final class GameOverViewController: UIViewController {
    
    private var gameOverView: GameOverView {
        guard let view = self.view as? GameOverView else {
            return GameOverView(frame: self.view.frame)
        }
        return view
    }
    
    var presenter: GameOverPresentable?
    var finishMode = true
    
    
    override func loadView() {
        view = GameOverView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameOverView.replayLevelButton.addTarget(self, action: #selector(replayLevelButtonTapped(_:)), for: .touchUpInside)
        gameOverView.nextLevelButton.addTarget(self, action: #selector(nextLevelButtonTapped(_:)), for: .touchUpInside)
        gameOverView.tapWinLabel.addTarget(self, action: #selector(winLabelTaps(_:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let animated = presenter?.animated, animated else { return }
        presenter?.soundGenerationToFireworks()
        gameOverView.firework()
    }
    
    func display(time: String, taps: String, isBest: Bool, isFinishMode: Bool) {
        gameOverView.setup(time: time, taps: taps, isBest: isBest, isFinishMode: isFinishMode)
    }
}


extension GameOverViewController: GameOverDisplayable {
    
    @objc
    private func replayLevelButtonTapped(_  sender: UIButton) {
        presenter?.replay()
    }
    
    @objc
    private func nextLevelButtonTapped(_ sender: UIButton) {
        presenter?.next()
    }
    
    @objc
    private func winLabelTaps(_ sender: UITapGestureRecognizer) {
        guard let animated = presenter?.animated, animated else { return }
        switch sender.state {
        case .ended: 
            presenter?.soundGenerationToFireworks()
            gameOverView.firework()
        default: break
        }
    }
}
