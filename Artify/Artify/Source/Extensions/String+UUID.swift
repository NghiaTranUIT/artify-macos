//
//  String+UUID.swift
//  Artify
//
//  Created by Nghia Tran on 6/1/18.
//  Copyright © 2018 com.art.artify.app. All rights reserved.
//

import Foundation

extension String {

    static func macSerialNumber() -> String? {

        // Get the platform expert
        let platformExpert: io_service_t = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("IOPlatformExpertDevice"));

        // Get the serial number as a CFString ( actually as Unmanaged<AnyObject>! )
        let serialNumberAsCFString = IORegistryEntryCreateCFProperty(platformExpert, kIOPlatformSerialNumberKey as CFString, kCFAllocatorDefault, 0);

        // Release the platform expert (we're responsible)
        IOObjectRelease(platformExpert);

        // Take the unretained value of the unmanaged-any-object
        // (so we're not responsible for releasing it)
        // and pass it back as a String or, if it fails, an empty string
        return serialNumberAsCFString?.takeUnretainedValue() as? String

    }

}
