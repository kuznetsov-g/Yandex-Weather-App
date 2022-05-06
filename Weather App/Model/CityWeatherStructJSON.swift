//
//  CityWeatherStructJSON.swift
//  Weather App
//
//  Created by Георгий Кузнецов on 06.05.2022.
//

import Foundation


// MARK: struct for JSON
struct CityData : Decodable {
    var response: ResponseStruct
}

struct ResponseStruct: Decodable {
    var GeoObjectCollection: GeoObjectCollectionStruct
}

struct GeoObjectCollectionStruct: Decodable {
    var featureMember    : [FeatureMemberStruct]
    var metaDataProperty : MetaDataPropertyStructForResultCount
}

struct MetaDataPropertyStructForResultCount: Decodable {
    var GeocoderResponseMetaData: GeocoderResponseMetaDataStruct
}

struct GeocoderResponseMetaDataStruct: Decodable {
    var request: String
    var found  : String
}

struct FeatureMemberStruct: Decodable {
    var GeoObject : GeoObjectStruct
}

struct GeoObjectStruct: Decodable {
    var metaDataProperty : MetaDataPropertyStruct
    var Point            : PointStruct
    var name             : String
}

struct MetaDataPropertyStruct: Decodable {
    var GeocoderMetaData : GeocoderMetaDataStruct
}

struct GeocoderMetaDataStruct: Decodable {
    var Address : AddressStruct
}

struct AddressStruct: Decodable {
    var Components : [ComponentsStruct]
}

struct ComponentsStruct: Decodable {
    var kind: String
    var name: String                        //name of the city
}

struct PointStruct: Decodable {
    var pos : String                        //coordinates in the format "56.229434 58.01045" (longitude / latitude)
}
