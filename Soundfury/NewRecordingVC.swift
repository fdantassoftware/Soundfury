//
//  NewRecordingVC.swift
//  Soundfury
//
//  Created by Fabio Dantas on 26/10/2016.
//  Copyright © 2016 DantasSoftware. All rights reserved.
//

import UIKit

class NewRecordingVC: UIViewController {
    @IBOutlet weak var savePressed: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        savePressed.layer.cornerRadius = 5.0
        savePressed.clipsToBounds = true

        
    }

}
