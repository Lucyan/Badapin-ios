//
//  CustomCell.swift
//  Badapin
//
//  Created by Leonardo Olivares on 16-08-15.
//  Copyright (c) 2015 Badapin. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var nick: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var votacionView: UIView!
    @IBOutlet weak var votarView: UIView!
    @IBOutlet weak var resultadoView: UIView!
    
    @IBOutlet weak var lblAburrido: UILabel!
    @IBOutlet weak var lvlEgo: UILabel!
    @IBOutlet weak var lvlEstilo: UILabel!
    @IBOutlet weak var lvlSexo: UILabel!
    @IBOutlet weak var lvlAmor: UILabel!
    @IBOutlet weak var lvlBelleza: UILabel!
    @IBOutlet weak var lvlFreak: UILabel!
    @IBOutlet weak var lvlFuerza: UILabel!
    @IBOutlet weak var lvlSalvaje: UILabel!
    @IBOutlet weak var lvlGracioso: UILabel!
    
    
    @IBOutlet weak var chartView: UIView!
    
    
    var votado : Bool = false
}
