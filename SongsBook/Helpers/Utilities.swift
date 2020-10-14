//
//  Utilities.swift
//  SongsBook
//
//  Created by Daniel Yamrak on 14.10.2020.
//  Copyright © 2020 DanielYarmak. All rights reserved.
//

import Foundation

class Utilities {

static func isPasswordValid(_ password: String) -> Bool {
    
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*(a-z)(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    return passwordTest.evaluate(with: password)
}

}
