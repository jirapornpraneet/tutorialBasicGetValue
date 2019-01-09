//
//  MainResource.swift
//  tutorialBasic
//
//  Created by Jiraporn Praneet on 12/10/2561 BE.
//  Copyright © 2561 InformatixPlusCompanyLimited. All rights reserved.
//

import EVReflection

class LPRResourceItem: EVObject {
    var items: [LPRResource] = [LPRResource]()
}

class LPRResource: EVObject {
    var localImageId: String? = ""
    var cameraName: String? = ""
    var prefixLicense: String? = ""
    var suffixLicense: String? = ""
    var province: String? = ""
    var occurredAt: String?
    var cameraHubNumber: String? = ""
    var cameraHubName: String? = ""
    var vehicleImageUrl: String? = ""
    var plateImageUrl: String? = ""
    var overviewImageUrl: String? = ""
    var watchlistName: String? = ""
    var vehicleBrand: String? = ""
    
    func getPrefixSuffixLicense() -> String {
        let prefixSuffixLicense = prefixLicense! + " " + suffixLicense!
        return prefixSuffixLicense
    }
}
