//
//  GlobalFunctions.swift
//  WeatherApp
//
//  Created by HsiaoAi on 2018/6/8.
//  Copyright © 2018 HsiaoAi. All rights reserved.
//

import UIKit
import CoreLocation

public func goToAppSettingsForLocation() {
    let url = CLLocationManager.locationServicesEnabled() ? URL(string: UIApplicationOpenSettingsURLString) : URL(string: "App-Prefs:root=Privacy&path=LOCATION")
    UIApplication.shared.open(url!, options: [:], completionHandler: nil)
}

public func getWindDirectionAbbr(with degree: Double) -> String? {
    if (degree >= 0 && degree < 22.5) || degree == 360 {
        return "N"
    } else if degree >= 22.5 && degree < 45 {
        return "NNE"
    } else if degree >= 45 && degree < 67.5 {
        return "NE"
    } else if degree >= 67.5 && degree < 90.0 {
        return "ENE"
    } else if degree >= 90.0 && degree < 112.5 {
        return "E"
    } else if degree >= 112.5 && degree < 135 {
        return "ESE"
    } else if degree >= 135 && degree < 157.5 {
        return "SE"
    } else if degree >= 157.5 && degree < 180 {
        return "SSE"
    } else if degree >= 180 && degree < 202.5 {
        return "S"
    } else if degree >= 202.5 && degree < 225 {
        return "SSW"
    } else if degree >= 225 && degree < 247.5 {
        return "SW"
    } else if degree >= 247.5 && degree < 270 {
        return "WSW"
    } else if degree >= 270 && degree < 292.5 {
        return "W"
    } else if degree >= 292.5 && degree < 315 {
        return "WNW"
    } else if degree >= 315 && degree < 337.5 {
        return "NW"
    } else if degree >= 337.5 && degree < 360 {
        return "NNW"
    } else {
        return nil
    }
}

public func getWeatherIcon(with icon: String) -> UIImage {
    switch icon {
        
    case "01d":
        return #imageLiteral(resourceName: "ClearSkyDay")
    case "01n":
        return #imageLiteral(resourceName: "ClearSkyNight")
        
    case "02d":
        return #imageLiteral(resourceName: "FewCloudsDay")
    case "02n":
        return #imageLiteral(resourceName: "FewCloudsDayNight")
        
    case "03d":
        return #imageLiteral(resourceName: "ScatteredCloudsDay")
    case "03n":
        return #imageLiteral(resourceName: "ScatteredCloudsNight")
        
    case "04d":
        return #imageLiteral(resourceName: "BrokenCloudsDay")
    case "04n":
        return #imageLiteral(resourceName: "BrokenCloudsNight")
        
    case "09d":
        return #imageLiteral(resourceName: "ShowerRainDay")
    case "09n":
        return #imageLiteral(resourceName: "ShowerRainNight")
        
    case "10d":
        return #imageLiteral(resourceName: "RainDay")
    case "10n":
        return #imageLiteral(resourceName: "RainNight")
        
    case "11d":
        return #imageLiteral(resourceName: "ThunderstormDay")
    case "11n":
        return #imageLiteral(resourceName: "ThunderstormNight")
        
    case "13d":
        return #imageLiteral(resourceName: "SnowDay")
    case "13n":
        return #imageLiteral(resourceName: "SnowNight")
        
    case "50d":
        return #imageLiteral(resourceName: "MistDay")
    case "50n":
        return #imageLiteral(resourceName: "MistNight")
        
    default:
        NSLog("Can't find image")
        return UIImage()
    }
}

public func getContryFullName(with abbr: String) -> String? {
    let fullName = contryNameDictionaries[abbr]
    return fullName
}

let contryNameDictionaries: [String: String] = [
    "AD": "Andorra",
    "AE": "United Arab Emirates",
    "AF": "Afghanistan",
    "AG": "Antigua and Barbuda",
    "AI": "Anguilla",
    "AL": "Albania",
    "AM": "Armenia",
    "AN": "Netherlands Antilles",
    "AO": "Angola",
    "AQ": "Antarctica",
    "AR": "Argentina",
    "AS": "American Samoa",
    "AT": "Austria",
    "AU": "Australia",
    "AW": "Aruba",
    "AX": "Åland Islands",
    "AZ": "Azerbaijan",
    "BA": "Bosnia and Herzegovina",
    "BB": "Barbados",
    "BD": "Bangladesh",
    "BE": "Belgium",
    "BF": "Burkina Faso",
    "BG": "Bulgaria",
    "BH": "Bahrain",
    "BI": "Burundi",
    "BJ": "Benin",
    "BL": "Saint Barthélemy",
    "BM": "Bermuda",
    "BN": "Brunei",
    "BO": "Bolivia",
    "BR": "Brazil",
    "BS": "Bahamas",
    "BT": "Bhutan",
    "BV": "Bouvet Island",
    "BW": "Botswana",
    "BY": "Belarus",
    "BZ": "Belize",
    "CA": "Canada",
    "CC": "Cocos [Keeling] Islands",
    "CD": "Congo - Kinshasa",
    "CF": "Central African Republic",
    "CG": "Congo - Brazzaville",
    "CH": "Switzerland",
    "CI": "Côte d’Ivoire",
    "CK": "Cook Islands",
    "CL": "Chile",
    "CM": "Cameroon",
    "CN": "China",
    "CO": "Colombia",
    "CR": "Costa Rica",
    "CU": "Cuba",
    "CV": "Cape Verde",
    "CX": "Christmas Island",
    "CY": "Cyprus",
    "CZ": "Czech Republic",
    "DE": "Germany",
    "DJ": "Djibouti",
    "DK": "Denmark",
    "DM": "Dominica",
    "DO": "Dominican Republic",
    "DZ": "Algeria",
    "EC": "Ecuador",
    "EE": "Estonia",
    "EG": "Egypt",
    "EH": "Western Sahara",
    "ER": "Eritrea",
    "ES": "Spain",
    "ET": "Ethiopia",
    "FI": "Finland",
    "FJ": "Fiji",
    "FK": "Falkland Islands",
    "FM": "Micronesia",
    "FO": "Faroe Islands",
    "FR": "France",
    "GA": "Gabon",
    "GB": "United Kingdom",
    "GD": "Grenada",
    "GE": "Georgia",
    "GF": "French Guiana",
    "GG": "Guernsey",
    "GH": "Ghana",
    "GI": "Gibraltar",
    "GL": "Greenland",
    "GM": "Gambia",
    "GN": "Guinea",
    "GP": "Guadeloupe",
    "GQ": "Equatorial Guinea",
    "GR": "Greece",
    "GS": "South Georgia and the South Sandwich Islands",
    "GT": "Guatemala",
    "GU": "Guam",
    "GW": "Guinea-Bissau",
    "GY": "Guyana",
    "HK": "Hong Kong SAR China",
    "HM": "Heard Island and McDonald Islands",
    "HN": "Honduras",
    "HR": "Croatia",
    "HT": "Haiti",
    "HU": "Hungary",
    "ID": "Indonesia",
    "IE": "Ireland",
    "IL": "Israel",
    "IM": "Isle of Man",
    "IN": "India",
    "IO": "British Indian Ocean Territory",
    "IQ": "Iraq",
    "IR": "Iran",
    "IS": "Iceland",
    "IT": "Italy",
    "JE": "Jersey",
    "JM": "Jamaica",
    "JO": "Jordan",
    "JP": "Japan",
    "KE": "Kenya",
    "KG": "Kyrgyzstan",
    "KH": "Cambodia",
    "KI": "Kiribati",
    "KM": "Comoros",
    "KN": "Saint Kitts and Nevis",
    "KP": "North Korea",
    "KR": "South Korea",
    "KW": "Kuwait",
    "KY": "Cayman Islands",
    "KZ": "Kazakhstan",
    "LA": "Laos",
    "LB": "Lebanon",
    "LC": "Saint Lucia",
    "LI": "Liechtenstein",
    "LK": "Sri Lanka",
    "LR": "Liberia",
    "LS": "Lesotho",
    "LT": "Lithuania",
    "LU": "Luxembourg",
    "LV": "Latvia",
    "LY": "Libya",
    "MA": "Morocco",
    "MC": "Monaco",
    "MD": "Moldova",
    "ME": "Montenegro",
    "MF": "Saint Martin",
    "MG": "Madagascar",
    "MH": "Marshall Islands",
    "MK": "Macedonia",
    "ML": "Mali",
    "MM": "Myanmar [Burma]",
    "MN": "Mongolia",
    "MO": "Macau SAR China",
    "MP": "Northern Mariana Islands",
    "MQ": "Martinique",
    "MR": "Mauritania",
    "MS": "Montserrat",
    "MT": "Malta",
    "MU": "Mauritius",
    "MV": "Maldives",
    "MW": "Malawi",
    "MX": "Mexico",
    "MY": "Malaysia",
    "MZ": "Mozambique",
    "NA": "Namibia",
    "NC": "New Caledonia",
    "NE": "Niger",
    "NF": "Norfolk Island",
    "NG": "Nigeria",
    "NI": "Nicaragua",
    "NL": "Netherlands",
    "NO": "Norway",
    "NP": "Nepal",
    "NR": "Nauru",
    "NU": "Niue",
    "NZ": "New Zealand",
    "OM": "Oman",
    "PA": "Panama",
    "PE": "Peru",
    "PF": "French Polynesia",
    "PG": "Papua New Guinea",
    "PH": "Philippines",
    "PK": "Pakistan",
    "PL": "Poland",
    "PM": "Saint Pierre and Miquelon",
    "PN": "Pitcairn Islands",
    "PR": "Puerto Rico",
    "PS": "Palestinian Territories",
    "PT": "Portugal",
    "PW": "Palau",
    "PY": "Paraguay",
    "QA": "Qatar",
    "RE": "Réunion",
    "RO": "Romania",
    "RS": "Serbia",
    "RU": "Russia",
    "RW": "Rwanda",
    "SA": "Saudi Arabia",
    "SB": "Solomon Islands",
    "SC": "Seychelles",
    "SD": "Sudan",
    "SE": "Sweden",
    "SG": "Singapore",
    "SH": "Saint Helena",
    "SI": "Slovenia",
    "SJ": "Svalbard and Jan Mayen",
    "SK": "Slovakia",
    "SL": "Sierra Leone",
    "SM": "San Marino",
    "SN": "Senegal",
    "SO": "Somalia",
    "SR": "Suriname",
    "ST": "São Tomé and Príncipe",
    "SV": "El Salvador",
    "SY": "Syria",
    "SZ": "Swaziland",
    "TC": "Turks and Caicos Islands",
    "TD": "Chad",
    "TF": "French Southern Territories",
    "TG": "Togo",
    "TH": "Thailand",
    "TJ": "Tajikistan",
    "TK": "Tokelau",
    "TL": "Timor-Leste",
    "TM": "Turkmenistan",
    "TN": "Tunisia",
    "TO": "Tonga",
    "TR": "Turkey",
    "TT": "Trinidad and Tobago",
    "TV": "Tuvalu",
    "TW": "Taiwan",
    "TZ": "Tanzania",
    "UA": "Ukraine",
    "UG": "Uganda",
    "UM": "U.S. Minor Outlying Islands",
    "US": "United States",
    "UY": "Uruguay",
    "UZ": "Uzbekistan",
    "VA": "Vatican City",
    "VC": "Saint Vincent and the Grenadines",
    "VE": "Venezuela",
    "VG": "British Virgin Islands",
    "VI": "U.S. Virgin Islands",
    "VN": "Vietnam",
    "VU": "Vanuatu",
    "WF": "Wallis and Futuna",
    "WS": "Samoa",
    "YE": "Yemen",
    "YT": "Mayotte",
    "ZA": "South Africa",
    "ZM": "Zambia",
    "ZW": "Zimbabwe"
]

enum Weekday: Int {
    case sun = 1
    case mon, tue, wed, thur, fri, sat
}





