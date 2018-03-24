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
// ------------------------------------------------------------------------------------------------------------------------
//                                              All Vehicles
// ------------------------------------------------------------------------------------------------------------------------
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

// ------------------------------------------------------------------------------------------------------------------------
//                                              All Combination Vehicles
// ------------------------------------------------------------------------------------------------------------------------
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

// Truck/Trailer.Truck
let kAcvTrtTruckAirElectricConnectors = kAllCombinationVehicles + kTruckTrailer + kTruck + ".air & electric connectors"

// Truck/Trailer.Trailer - Coupling System
let kAcvTrtTrailerCouplingTongueDrawbar = kAllCombinationVehicles + kTruckTrailer + kTrailerCoupling + ".tongue or drawbar"
let kAcvTrtTrailerCouplingMountingBolts = kAllCombinationVehicles + kTruckTrailer + kTrailerCoupling + ".mounting bolts"
let kAcvTrtTrailerCouplingSafetyDevices = kAllCombinationVehicles + kTruckTrailer + kTrailerCoupling + ".safety devices"
let kAcvTrtTrailerCouplingSlidingPintle = kAllCombinationVehicles + kTruckTrailer + kTrailerCoupling + ".sliding pintle"

// Truck/Trailer.Trailer
let kAcvTrtTrailerAirElectricConnectorsLines = kAllCombinationVehicles + kTruckTrailer + kTrailer + ".air & electric connectors & lines"
let kAcvTrtTrailerTongueStorageArea = kAllCombinationVehicles + kTruckTrailer + kTrailer + ".tongue storage area"

// Tractor/Semi-Trailer.Trailer
let kAcvTstTrailerAirElectricConnectors = kAllCombinationVehicles + kTractorSemiTrailer + kTrailer + ".air & electric connectors"

// Tractor/Semi-Trailer.Tractor
let kAcvTstTractorAirElectricConnectorsLines = kAllCombinationVehicles + kTractorSemiTrailer + kTractor + ".air & electric connectors & lines"


// ------------------------------------------------------------------------------------------------------------------------
//                                              Form A
// ------------------------------------------------------------------------------------------------------------------------
let kFormA = "Form A"
let kFrontOfVehicle = ".Front of Vehicle"
let kFormAFovLightsReflectors = kFormA + kFrontOfVehicle + ".lights & reflectors (L-R-4-HL-HB-C)"

let kSteering = ".Steering"
let kFormAStBoxHoses = kFormA + kSteering + ".steering box & hoses"
let kFormAStLinkage = kFormA + kSteering + ".steering linkage"

let kFrontAxle = ".Front Axle"
let kFormAFrontAxleTongueDrawbar = kFormA + kFrontAxle + ".tongue or drawbar"
let kFormAFrontAxleRims = kFormA + kFrontAxle + ".rims"
let kFormAFrontAxleLugNuts = kFormA + kFrontAxle + ".lug nuts"
let kFormAFrontAxleHubOilSeal = kFormA + kFrontAxle + ".hub oil seal"

// Need to add for the multiple choice section

let kFrontSuspension = kFormA + ".Front Suspension"
let kFormAFrontSuspensionSpringsShocks = kFrontSuspension + ".springs and shocks"
let kFormAFrontSuspensionUbolts = kFrontSuspension + ".u-bolts"
let kFormAFrontSuspensionSpringMounts = kFrontSuspension + ".spring mounts"

let kFrontBrake = kFormA + ".Front Brake"
let kFormAFrontBrakeHosesLines = kFrontBrake + ".brake hoses or lines"
let kFormAFrontBrakeChamber = kFrontBrake + ".*brake chamber"
let kFormAFrontBrakeSlackAdjusterPushRod = kFrontBrake + ".*slack adjuster & push-rod"
let kFormAFrontBrakeDrumLingsRotorDisk = kFrontBrake + ".drum & linings or rotor & disk"

let kEngineComparment = kFormA + ".Engine Compartment"
let kFormAEngineCompartmentOilLevel = kEngineComparment + ".oil level"
let kFormAEngineCompartmentPowerSteeringFluidBelt = kEngineComparment + ".power steering fluid/belt"
let kFormAEngineCompartmentWaterPumpGearBelt = kEngineComparment + ".water pump gear/belt"
let kFormAEngineCompartmentLeaksHoses = kEngineComparment + ".leaks & hoses"
let kFormAEngineCompartmentCoolantLevel = kEngineComparment + ".coolant level"
let kFormAEngineCompartmentAlternatorGearBelt = kEngineComparment + ".alternator gear/belt"
let kFormAEngineCompartmentAirCompressorGearBelt = kEngineComparment + ".air compressor gear/belt"

// ------------------------------------------------------------------------------------------------------------------------
//                                              Form B
// ------------------------------------------------------------------------------------------------------------------------
let kFormB = "Form B"

// Under Vehicle Section
let kUnderVehicle = kFormB + ".Under Vehicle"
let kFormBUnderVehicleDriveShaft = kUnderVehicle + ".drive shaft"
let kFormBUnderVehicleExhaustSystem = kUnderVehicle + ".exhaust system"
let kFormBUnderVehicleFrame = kUnderVehicle + ".frame"

// Rear Axles Section
let kRearAxles = kFormB + ".Rear Axles"
let kFormBRearAxlesRearWheels = kRearAxles + ".rear wheels (F/R)"
let kFormBRearAxlesTires = kRearAxles + ".tires (T-C-P)"
let kFormBRearAxlesRims = kRearAxles + ".rims"
let kFormBRearAxlesLugNuts = kRearAxles + ".lug nuts"
let kFormBRearAxlesAxleSeal = kRearAxles + ".axle seal"
let kFormBRearAxlesSpacersBudSpacing = kRearAxles + ".spacers or bud spacing"

// Driver/Fuel Area Section
let kDriverFuelArea = kFormB + ".Driver/Fuel Area"
let kFormBDriverFuelAreaDoorMirror = kDriverFuelArea + ".door & mirror"
let kFormBDriverFuelAreaFuelTankCapsLeaks = kDriverFuelArea + ".fuel tank & caps & leaks"
let kFormBDriverFuelAreaCatwalkSteps = kDriverFuelArea + ".catwalk & steps"
let kFormBDriverFuelAreaLightsReflectors = kDriverFuelArea + ".lights and reflectors (L-E-4-C)"

//Rear of Vehicle
let kRearOfVehicle = kFormB + ".Rear of Vehicle"
let kFormBRearOfVehicleDoorsTiesLifts = kRearOfVehicle + ".doors & ties & lift"
let kFormBRearOfVehicleSplashGuards = kRearOfVehicle + ".splash guards"
let kFormBRearOfVehicleLightsReflectorsReflectiveTape = kRearOfVehicle + ".lights, reflectors, reflective tape (L-R-4-TL-BL-C)"

//Rear Brakes
let kRearBrakes = kFormB + ".Rear Brakes"
let kFormBRearBrakesHosesLines = kRearBrakes + ".brake hoses or lines"
let kFormBRearBrakesChamber = kRearBrakes + ".*brake chamber"
let kFormBRearBrakesSlackAdjustorPushRod = kRearBrakes + ".*slack adjustor & push-rod"
let kFormBRearBrakesDrumLiningsRotorDisk = kRearBrakes + ".drum & linings or rotor & disk"

//Rear Suspension
let kRearSuspension = kFormB + ".Rear Suspension"
let kFormBRearSuspensionSpringsAirbagsShocks = kRearSuspension + ".springs & airbags & shocks"
let kFormBRearSuspensionUbolts = kRearSuspension + ".u-bolts"
let kFormBRearSuspensionSpringsAirMountsTorqueArm = kRearSuspension + ".springs/air mounts & torque arm"

// ------------------------------------------------------------------------------------------------------------------------
//                                              Form C
// ------------------------------------------------------------------------------------------------------------------------

let kFormC = "Form C (Combinations)"
// Trailer Front
let kTrailerFront = kFormC + ".Trailer Front"
let kFormCTrailerFrontHeaderBoardBulkhead = kTrailerFront + ".header board or bulkhead"
let kFormCTrailerFrontLightsReflectors = kTrailerFront + ".lights & reflectors (C)"

// Side of Trailer
let kSideOfTrailer = kFormC + ".Side of Trailer"
let kFormCSideOfTrailerLightsReflectors = kSideOfTrailer + ".lights & reflectors (L-R-4-C)"
let kFormCSideOfTrailerLandingGear = kSideOfTrailer + ".landing gear"
let kFormCSideOfTrailerFrameTandemRelease = kSideOfTrailer + ".frame & tandem release"
let kFormCSideOfTrailerDoorsTiesLifts = kSideOfTrailer + ".doors & ties & lifts"

// Rear of Vehicle
let kFormCRearOfVehicle = kFormC + ".Rear of Vehicle"
let kFormCRearOfVehicleDoorsTiesLift = kFormCRearOfVehicle + ".doors & ties & lift"
let kFormCRearOfVehicleSplashGuards = kFormCRearOfVehicle + ".splash guards"
let kFormCRearOfVehicleLightsReflectorsReflectiveTape = kFormCRearOfVehicle + ".lights, reflectors, reflective tape (L-R-4-TL-BL-C)"

// Rear Brakes
let kFormCRearBrakes = kFormC + ".Rear Brakes"
let kFormCRearBrakesHosesLines = kFormCRearBrakes + ".brake hoses or lines"
let kFormCRearBrakesChamber = kFormCRearBrakes + ".*brake chamber"
let kFormCRearBrakesSlackAdjustorPushRod = kFormCRearBrakes + ".*slack adjustor & push-rod"
let kFormCRearBrakesDrumLiningsRotorDisk = kFormCRearBrakes + ".drum & linings or rotor & disk"

// Trailer Axles
let kFormCTrailerAxles = kFormC + ".Trailer Axles"
let kFormCTrailerAxlesWheels = kFormCTrailerAxles + ".wheels (F/R)"
let kFormCTrailerAxlesTires = kFormCTrailerAxles + ".tires (T-C-P)"
let kFormCTrailerAxlesRims = kFormCTrailerAxles + ".rims"
let kFormCTrailerAxlesLugNuts = kFormCTrailerAxles + ".lug nuts"
let kFormCTrailerAxlesAxleHubOilSeal = kFormCTrailerAxles + ".axle or hub oil seal"
let kFormCTrailerAxlesSpacersBudSpacing = kFormCTrailerAxles + ".spacers or bud spacing"

// Rear Suspension
let kFormCRearSuspension = kFormC + ".Rear Suspension"
let kFormCRearSuspensionSpringsAirbagsShocks = kFormCRearSuspension + ".springs & airbags & shocks"
let kFormCRearSuspensionUbolts = kFormCRearSuspension + ".u-bolts"
let kFormCRearSuspensionSpringsAirMountsTorqueArm = kFormCRearSuspension + ".springs/air mounts & torque arm"

// ------------------------------------------------------------------------------------------------------------------------
//                                              ALL PASSENGER VEHICLES
// ------------------------------------------------------------------------------------------------------------------------
let kAllPassengerVehicles = "All Passenger Vehicles"
let kPassengerItemsOnly = kAllPassengerVehicles + ".Passenger Items Only"
let kPassengerItemsBaggageCompartment = kPassengerItemsOnly + ".Baggage Compartment"
let kPassengerItemsBaggageCompartmentDoorsSecure = kPassengerItemsBaggageCompartment + ".doors secure (baggage)"
let kPassengerItemsBaggageCompartmentSteeringLinkage = kPassengerItemsBaggageCompartment + ".steering linkage"

let kPassengerItemsSection = kPassengerItemsOnly + ".Passenger Items"
let kPassengerItemsEntryLift = kPassengerItemsSection + ".passenger entry & lift"
let kPassengerItemsEmergencyExits = kPassengerItemsSection + ".emergency exits"
let kPassengerItemsSeating = kPassengerItemsSection + ".seating"

let kSchoolBusOnly = kAllPassengerVehicles + ".School Bus Only"
let kSchoolBusFrontSuspension = kSchoolBusOnly + ".Front Suspension"
let kSchoolBusFrontSuspensionStudentLights = kSchoolBusFrontSuspension + ".student lights (front, back)"

let kSchoolBusStudentSafetyItems = kSchoolBusOnly + ".Student Safety Items"
let kSchoolBusStudentSafetyItemsStopArmSafetyArm = kSchoolBusStudentSafetyItems + ".stop arm & safety arm"
let kSchoolBusStudentSafetyItemsStudentMirror = kSchoolBusStudentSafetyItems + ".student mirror"
let kSchoolBusStudentSafetyItemsEmergencyKitBodyFluidKit = kSchoolBusStudentSafetyItems + ".emergency kit & body fluid kit"

// ------------------------------------------------------------------------------------------------------------------------
//                                              VEHICLE INFO
// ------------------------------------------------------------------------------------------------------------------------
let kVehicleInfo = "Vehicle Info"
let kVehicleInfoAxles = kVehicleInfo + ".Vehicle Axles"
let kVehicleInfoTrailerAxles = kVehicleInfo + ".Trailer Axles"
let kVehicleInfoAirBrakes = kVehicleInfo + ".Air Brakes"
let kVehicleInfoGVWR = kVehicleInfo + ".GVWR"

let kNoShow = "NO SHOW"
let kClientRequested = "CLIENT REQUESTED"
let kWeather = "WEATHER"
