//
//  ResultsPDFView.swift
//  CDLExam
//
//  Created by adeiji on 3/19/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import Foundation
import UIKit

class PDFHeader: UIView {
    
    override func draw(_ rect: CGRect) {
        ResultsPDF.drawHeader(frame: rect, resizing: .stretch, txtName: "Adebayo Ijidakinro", licenseNumber: "8787847", dob: "3/21/2000", date: "3/21/2018", tester: "Johnny Harding", testerNumber: "4878978", preTripScore: "88");
    }
    
}

class PDFAllCombinationVehiclesSection : UIView {
    let results = ExamResults.sharedInstance.results

    override func draw(_ rect: CGRect) {
        ResultsPDF.drawAllCombinationVehicles(frame: rect,
                                              resizing: .stretch,
                                              acvTrtTruckAirElectricConnectrs: UtilityFunctions.toBool(value: self.results[kAcvTrtTruckAirElectricConnectors]),
                                              acvTrtTruckCouplingMountingBolts: UtilityFunctions.toBool(value: self.results[kAcvTrtTruckCouplingMountingBolts]),
                                              acvTrtTruckCouplingPintleHook: UtilityFunctions.toBool(value: self.results[kAcvTrtTruckCouplingPintleHook]),
                                              acvTrtTruckCouplingHitchReleaseLever: UtilityFunctions.toBool(value: self.results[kAcvTrtTruckCouplingHitchReleaseLever]),
                                              acvTrtTruckCouplingSafetyDevices: UtilityFunctions.toBool(value: self.results[kAcvTrtTruckCouplingSafetyDevices]),
                                              acvTrtTrailerAirElectricConnectorsLines: UtilityFunctions.toBool(value: self.results[kAcvTrtTrailerAirElectricConnectors]),
                                              acvTrtTrailerTongueStorageArea: UtilityFunctions.toBool(value: self.results[kAcvTrtTrailerTongueStorageArea]),
                                              acvTrtTrailerCouplingTongueDrawer: UtilityFunctions.toBool(value: self.results[kAcvTrtTrailerCouplingTongueDrawbar]),
                                              acvTrtTrailerCouplingMountingBolts: UtilityFunctions.toBool(value: self.results[kAcvTrtTrailerCouplingMountingBolts]),
                                              acvTrtTrailerCouplingSafetyDevices: UtilityFunctions.toBool(value: self.results[kAcvTrtTrailerCouplingSafetyDevices]),
                                              acvTrtTrailerCouplingSlidingPintle: UtilityFunctions.toBool(value: self.results[kAcvTrtTrailerCouplingSlidingPintle]),
                                              acvTstTractorAirElectricConnectorsLines: UtilityFunctions.toBool(value: self.results[kAcvTstTractorAirElectricConnectors]),
                                              acvTstTractorCouplingMountingBolts: UtilityFunctions.toBool(value: self.results[kAcvTstTractorCouplingMountingBolts]),
                                              acvTstTractorCouplingPlatform: UtilityFunctions.toBool(value: self.results[kAcvTstTractorCouplingPlatform]),
                                              acvTstTractorCouplingLockingJawsLever: UtilityFunctions.toBool(value: self.results[kAcvTstTractorCouplingLockingJawsLever]),
                                              acvTstTractorCouplingReleaseArmSafetyLatch: UtilityFunctions.toBool(value: self.results[kAcvTstTractorCouplingReleaseArmSafetyLatch]),
                                              acvTstTractorCouplingFifthWheelSkidPlate: UtilityFunctions.toBool(value: self.results[kAcvTstTractorCouplingFifthWheelSkidPlate]),
                                              acvTstTractorCouplingSlideFifthWheelPins: UtilityFunctions.toBool(value: self.results[kAcvTstTractorCouplingSideFifthWheelPins]),
                                              acvTstSemiTrailerAirElectricConnectors: false,
                                              acvTstSemiTrailerCouplingMountingBolts: false,
                                              acvTstSemiTrailerCouplingPlatform: false,
                                              acvTstSemiTrailerCouplingLockingJawsLever: false,
                                              acvTstSemiTrailerCouplingReleaseArmSafetyLatch: false,
                                              acvTstSemiTrailerCouplingFifthWheelSkidPlate: false,
                                              acvTstSemiTrailerCouplingSlideFifthWheelPins: false)
    }
}

class PDFAllVehiclesSection: UIView {
    let results = ExamResults.sharedInstance.results;
    var safetyBelt = false;
    var emergencyEquipment = false;
    var safeStart = false;
    var temperateGauge = false;
    var oilPressureGauge = false;
    var voltmeterGauge = false;
    var airGuage = false;
    var lightingIndicators = false;
    var horns = false;
    var heaterDefroster = false;
    var windshieldMirrors = false;
    var wipersWashers = false;
    var parkingBrake = false;
    var serviceBrake = false;
    var airBrakeCheck = false;
    
    // All constants for class are stored in the Constants.swift file
    func getAnswers () {
        for (key, value) in results {
            if key == kSafetyBelt {
                self.safetyBelt = UtilityFunctions.toBool(value: value)
            } else if key == kEmergencyEquipment {
                self.emergencyEquipment = UtilityFunctions.toBool(value: value)
            } else if key == kSafeStart {
                self.safeStart = UtilityFunctions.toBool(value: value)
            } else if key == kTemperatureGauge {
                self.temperateGauge = UtilityFunctions.toBool(value: value)
            } else if key == kOilPressureGauge {
                self.oilPressureGauge = UtilityFunctions.toBool(value: value)
            } else if key == kVoltmeterGauge {
                self.voltmeterGauge = UtilityFunctions.toBool(value: value)
            } else if key == kAirGauge {
                self.airGuage = UtilityFunctions.toBool(value: value)
            } else if key == kLightingIndicators {
                self.lightingIndicators = UtilityFunctions.toBool(value: value)
            } else if key == kHorns {
                self.horns = UtilityFunctions.toBool(value: value)
            } else if key == kHeaterDefroster {
                self.heaterDefroster = UtilityFunctions.toBool(value: value)
            } else if key == kWindshildMirrors {
                self.windshieldMirrors = UtilityFunctions.toBool(value: value)
            } else if key == kWipersWashers {
                self.wipersWashers = UtilityFunctions.toBool(value: value)
            } else if key == kParkingBrake {
                self.parkingBrake = UtilityFunctions.toBool(value: value)
            } else if key == kAirBrakeCheck {
                self.airBrakeCheck = UtilityFunctions.toBool(value: value)
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        self.getAnswers()
        ResultsPDF.drawAllVehicles(frame: rect,
                                resizing: .stretch,
                                safetyBelt: self.safetyBelt,
                                emergencyEquipment: self.emergencyEquipment,
                                safeStart: self.safeStart,
                                temperatureGauge: self.temperateGauge,
                                oilPressureGauge: self.oilPressureGauge,
                                voltmeterGauge: self.voltmeterGauge,
                                airGauge: self.airGuage,
                                lightingIndicators: self.lightingIndicators,
                                horns: self.horns,
                                heaterDefroster: self.heaterDefroster,
                                windshieldMirrors: self.windshieldMirrors,
                                wipersWashers: self.wipersWashers,
                                parkingBrake: self.parkingBrake,
                                serviceBrake: self.serviceBrake,
                                airBrakeCheck: self.airBrakeCheck)
        
    }
}
