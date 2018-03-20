//
//  Constants.swift
//  CDLExam
//
//  Created by adeiji on 3/19/18.
//  Copyright © 2018 Dephyned. All rights reserved.
//

import Foundation

// We need to write a unit test for this most certainly

// All Vehicles
let kAllVehicles = "All Vehicles"
let kSafetyBelt = kAllVehicles + ".safety belt"
let kEmergencyEquipment = kAllVehicles + ".emergency equipment(F-E-T)"
let kSafeStart = kAllVehicles + ".safe start"
let kTemperatureGauge = kAllVehicles + ".temperature guage"
let kOilPressureGauge = kAllVehicles + ".oil pressure guage"
let kVoltmeterGauge = kAllVehicles + ".ammeter or motmeter garage"
let kAirGauge = kAllVehicles + ".air guage"
let kLightingIndicators = kAllVehicles + ".lighting indicators (L-R-4-H)"
let kHorns = kAllVehicles + ".horn(s)"
let kHeaterDefroster = kAllVehicles + ".heater & defroster"
let kWindshildMirrors = kAllVehicles + ".windshield & mirrors"
let kWipersWashers = kAllVehicles + ".wipers & washers"
let kParkingBrake = kAllVehicles + ".parking brake"
let kAirBrakeCheck = kAllVehicles + ".*air brake check (L-A-B)"

// All Combination Vehicles
let kAllCombinationVehicles = "All Combination Vehicles"
let kTractorSemiTrailer = ".Tractor/Semi-Trailer"
let kTruckTrailer = ".Truck/Trailer"
let kTrailerCoupling = ".Trailer - Coupling System"
let kTractorCoupling = ".Tractor - Coupling System"
let kTruckCoupling = ".Truck - Coupling System"

let kTrailer = ".Trailer"
let kTractor = ".Tractor"
let kTruck = ".Truck"

// Abbreviation Acv = All Combination Vehicles
// Abbreviation Tst = Tractor/Semi-Trailer

// Tractor/Semi-Trailer
let kAcvTstTrailerCouplingKingpin = kAllCombinationVehicles + kTractorSemiTrailer + kTrailerCoupling + ".kingpin"
let kAcvTstTrailerCouplingApron = kAllCombinationVehicles + kTractorSemiTrailer + kTrailerCoupling + ".apron"
let kAcvTstTrailerCouplingGap = kAllCombinationVehicles + kTractorSemiTrailer + kTrailerCoupling + ".gap"

let kAcvTstTractorCouplingMountingBolts = kAllCombinationVehicles + kTractorSemiTrailer + kTractorCoupling + ".mounting bolts"
let kAcvTstTractorCouplingPlatform = kAllCombinationVehicles + kTractorSemiTrailer + kTractorCoupling + ".platform"
let kAcvTstTractorCouplingLockingJawsLever = kAllCombinationVehicles + kTractorSemiTrailer + kTractorCoupling + ".locking jaws or lever"
let kAcvTstTractorCouplingReleaseArmSafetyLatch = kAllCombinationVehicles + kTractorSemiTrailer + kTractorCoupling + ".release arm and safety latch"
let kAcvTstTractorCouplingFifthWheelSkidPlate = kAllCombinationVehicles + kTractorSemiTrailer + kTractorCoupling + ".5th wheel skid plate"
let kAcvTstTractorCouplingSideFifthWheelPins = kAllCombinationVehicles + kTractorSemiTrailer + kTractorCoupling + ".side 5th wheel pins (clearance)"

let kAcvTstTractorAirElectricConnectors = kAllCombinationVehicles + kTractorSemiTrailer + kTractor + ".air & electric connectors"
let kAcvTstTrailerAirElectricConnectorsLines = kAllCombinationVehicles + kTractorSemiTrailer + kTrailer + ".air & electric connectors & lines"

// Truck/Trailer.Truck - Coupling System
let kAcvTrtTruckCouplingMountingBolts = kAllCombinationVehicles + kTruckTrailer + kTruckCoupling + ".mounting bolts"
let kAcvTrtTruckCouplingPintleHook = kAllCombinationVehicles + kTruckTrailer + kTruckCoupling + ".pintle hook"
let kAcvTrtTruckCouplingHitchReleaseLever = kAllCombinationVehicles + kTruckTrailer + kTruckCoupling + ".hitch release lever"
let kAcvTrtTruckCouplingSafetyDevices = kAllCombinationVehicles + kTruckTrailer + kTruckCoupling + ".safety devices"

// Truck/Trailer.Trailer - Coupling System
let kAcvTrtTrailerCouplingTongueDrawbar = kAllCombinationVehicles + kTruckTrailer + kTrailerCoupling + ".tongue or drawbar"
let kAcvTrtTrailerCouplingMountingBolts = kAllCombinationVehicles + kTruckTrailer + kTrailerCoupling + ".mounting bolts"
let kAcvTrtTrailerCouplingSafetyDevices = kAllCombinationVehicles + kTruckTrailer + kTrailerCoupling + ".safety devices"
let kAcvTrtTrailerCouplingSlidingPintle = kAllCombinationVehicles + kTruckTrailer + kTrailerCoupling + ".sliding pintle"

// Truck/Trailer.Truck
let kAcvTrtTruckAirElectricConnectors = kAllCombinationVehicles + kTruckTrailer + kTruck + ".air & electric connectors"

// Truck/Trailer.Trailer
let kAcvTrtTrailerAirElectricConnectors = kAllCombinationVehicles + kTruckTrailer + kTrailer + ".air & electric connectors & lines"
let kAcvTrtTrailerTongueStorageArea = kAllCombinationVehicles + kTruckTrailer + kTrailer + ".tongue storage area"
