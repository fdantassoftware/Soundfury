//
//  ViewController.swift
//  Soundfury
//
//  Created by Fabio Dantas on 26/10/2016.
//  Copyright © 2016 DantasSoftware. All rights reserved.
//

import UIKit
import CoreData
import Foundation
import AVFoundation

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    var controller: NSFetchedResultsController<Sound>!
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        attemptFetch()
        tableView.reloadData()
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SoundCell", for: indexPath) as? SoundCell {
            let sound = controller.object(at: indexPath)
            sound.created = Date() as NSDate!
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            let currentDate = dateFormatter.string(from: sound.created as! Date)
            cell.dateLabel.text = currentDate
            
           
            cell.mainIMG.image = UIImage(named: "playbt-1.png")
            cell.nameLabel.text = sound.name
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        } else {
            return 0
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        if let section = controller.sections {
            return section.count
        } else {
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sound = controller.object(at: indexPath)
        
        do {
            audioPlayer = try AVAudioPlayer(data: sound.audio as! Data)
            audioPlayer!.play()
        } catch let error as NSError {
            print(error)
        }
        
        
    }

    func attemptFetch() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Sound> = Sound.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        self.controller = controller
        
        do {
            try controller.performFetch()
            
            
        } catch let error as NSError {
            
            print(error)
        }
    }

}

