//
//  ViewController.swift
//  timer
//
//  Created by Mishel on 03.02.2024.
//

import UIKit

class TimerViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!

    
    var timer: Timer?
    var counter: Int = 0
    var rounds: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetTimer()
        tableView.dataSource = self
        tableView.delegate = self


    }
    
    @IBAction func startStopButtonTapped(_ sender: UIButton) {
        if timer != nil {
            stopTimer()
        } else {
            startTimer()
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        if timer == nil {
               resetTimer()
           } else {
               addRound()
               tableView.reloadData()
           }

    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        startStopButton.setTitle("Stop", for: .normal)
        self.startStopButton.backgroundColor = UIColor.red
        resetButton.setTitle("Round", for: .normal)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        startStopButton.setTitle("Start", for: .normal)
        self.startStopButton.backgroundColor = UIColor.green
        resetButton.setTitle("Reset", for: .normal)
    }
    
    func resetTimer() {
        stopTimer()
        counter = 0
        timerLabel.text = "00:00:00"
        rounds.removeAll()
        tableView.reloadData()
    }
    
    func addRound() {
        let round = timerLabel.text ?? ""
        rounds.append(round)
        tableView.reloadData()
        print(rounds)
    }
    
    @objc func updateTimer() {
        counter += 1
        let hours = counter / 3600
        let minutes = (counter % 3600) / 60
        let seconds = (counter % 3600) % 60
        timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

extension TimerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rounds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoundCell", for: indexPath)
        cell.textLabel?.text = rounds[indexPath.row]
        return cell
    }
}

