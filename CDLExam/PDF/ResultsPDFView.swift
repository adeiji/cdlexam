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

class PDFFormASection : UIView {
    let results = ExamResults.sharedInstance.results
    
    override func draw(_ rect: CGRect) {
        ResultsPDF.drawFormA(frame: rect,
                             resizing: .stretch,
                             formAFovLightsReflectors: UtilityFunctions.toBool(value: self.results[kFormAFovLightsReflectors]),
                             formAEcOilLevel: UtilityFunctions.toBool(value: self.results[kFormAEngineCompartmentOilLevel]),
                             formAEcCoolantLevel: UtilityFunctions.toBool(value: self.results[kFormAEngineCompartmentCoolantLevel]),
                             formAEcPowerSteeringFluidBelt: UtilityFunctions.toBool(value: self.results[kFormAEngineCompartmentPowerSteeringFluidBelt]),
                             formAEcWaterPumpGearBelt: UtilityFunctions.toBool(value: self.results[kFormAEngineCompartmentWaterPumpGearBelt]),
                             formAEcAlternatorgearBelt: UtilityFunctions.toBool(value: self.results[kFormAEngineCompartmentAlternatorGearBelt]),
                             formAEcAirCompressorGearBelt: UtilityFunctions.toBool(value: self.results[kFormAEngineCompartmentAirCompressorGearBelt]),
                             formAEcLeaksHoses: UtilityFunctions.toBool(value: self.results[kFormAEngineCompartmentLeaksHoses]),
                             formASteeringBoxHoses: UtilityFunctions.toBool(value: self.results[kFormAStBoxHoses]),
                             formASteeringLinkage: UtilityFunctions.toBool(value: self.results[kFormAStLinkage]),
                             formAFrontAxleFrontWheelTires: false,
                             formAFrontAxleFrontWheelRims: UtilityFunctions.toBool(value: self.results[kFormAFrontAxleRims]),
                             formAFrontAxleFrontWheelLugNuts: UtilityFunctions.toBool(value: self.results[kFormAFrontAxleRims]),
                             formAFrontAxleFrontWheelHubOilSeal: UtilityFunctions.toBool(value: self.results[kFormAFrontAxleLugNuts]),
                             formAFrontAxleFrontSuspensionSpringsShocks: UtilityFunctions.toBool(value: self.results[kFormAFrontAxleHubOilSeal]),
                             formAFrontAxleFrontSuspensionUbolts: UtilityFunctions.toBool(value: self.results[kFormAFrontSuspensionUbolts]),
                             formAFrontAxleFrontSuspensionSpringMounts: UtilityFunctions.toBool(value: self.results[kFormAFrontSuspensionSpringMounts]),
                             formAFrontAxleFrontBrakeHosesLines: UtilityFunctions.toBool(value: self.results[kFormAFrontBrakeHosesLines]),
                             formAFrontAxleFrontBrakeChamber: UtilityFunctions.toBool(value: self.results[kFormAFrontBrakeChamber]),
                             formAFrontAxleFrontBrakeSlackAdjustorPushRod: UtilityFunctions.toBool(value: self.results[kFormAFrontBrakeSlackAdjusterPushRod]),
                             formAFrontAxleFrontBrakeDrumLiningsRoterDisk: UtilityFunctions.toBool(value: self.results[kFormAFrontBrakeDrumLingsRotorDisk]))
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
                                              acvTrtTrailerAirElectricConnectorsLines: UtilityFunctions.toBool(value: self.results[kAcvTrtTrailerAirElectricConnectorsLines]),
                                              acvTrtTrailerTongueStorageArea: UtilityFunctions.toBool(value: self.results[kAcvTrtTrailerTongueStorageArea]),
                                              acvTrtTrailerCouplingTongueDrawer: UtilityFunctions.toBool(value: self.results[kAcvTrtTrailerCouplingTongueDrawbar]),
                                              acvTrtTrailerCouplingMountingBolts: UtilityFunctions.toBool(value: self.results[kAcvTrtTrailerCouplingMountingBolts]),
                                              acvTrtTrailerCouplingSafetyDevices: UtilityFunctions.toBool(value: self.results[kAcvTrtTrailerCouplingSafetyDevices]),
                                              acvTrtTrailerCouplingSlidingPintle: UtilityFunctions.toBool(value: self.results[kAcvTrtTrailerCouplingSlidingPintle]),
                                              acvTstTractorAirElectricConnectorsLines: UtilityFunctions.toBool(value: self.results[kAcvTstTractorAirElectricConnectorsLines]),
                                              acvTstTractorCouplingMountingBolts: UtilityFunctions.toBool(value: self.results[kAcvTstTractorCouplingMountingBolts]),
                                              acvTstTractorCouplingPlatform: UtilityFunctions.toBool(value: self.results[kAcvTstTractorCouplingPlatform]),
                                              acvTstTractorCouplingLockingJawsLever: UtilityFunctions.toBool(value: self.results[kAcvTstTractorCouplingLockingJawsLever]),
                                              acvTstTractorCouplingReleaseArmSafetyLatch: UtilityFunctions.toBool(value: self.results[kAcvTstTractorCouplingReleaseArmSafetyLatch]),
                                              acvTstTractorCouplingFifthWheelSkidPlate: UtilityFunctions.toBool(value: self.results[kAcvTstTractorCouplingFifthWheelSkidPlate]),
                                              acvTstTractorCouplingSlideFifthWheelPins: UtilityFunctions.toBool(value: self.results[kAcvTstTractorCouplingSideFifthWheelPins]),
                                              acvTstSemiTrailerAirElectricConnectors: UtilityFunctions.toBool(value: self.results[kAcvTstTrailerAirElectricConnectors]),
                                              acvTstSemiTrailerCouplingKingpin: UtilityFunctions.toBool(value: self.results[kAcvTstTrailerCouplingKingpin]),
                                              acvTstSemiTrailerCouplingApron: UtilityFunctions.toBool(value: self.results[kAcvTstTrailerCouplingApron]),
                                              acvTstSemiTrailerCouplingGap: UtilityFunctions.toBool(value: self.results[kAcvTstTrailerCouplingGap]))
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
