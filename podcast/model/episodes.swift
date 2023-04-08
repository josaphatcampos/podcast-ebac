////
////  episodes.swift
////  meu podcast
////
////  Created by Josaphat Campos Pereira on 07/04/23.
////
//
//import Foundation
//
//// MARK: - Result
//struct Episode: Codable {
//    let audio: String
//    let audioLengthSEC: Int
//    let rss, descriptionHighlighted, descriptionOriginal, titleHighlighted: String
//    let titleOriginal: String
//    let transcriptsHighlighted: [JSONAny]
//    let image, thumbnail: String
//    let itunesID, pubDateMS: Int
//    let id: String
//    let listennotesURL: String
//    let explicitContent: Bool
//    let link: String
//    let guidFromRSS: String
//    let podcast: Podcast
//
//    enum CodingKeys: String, CodingKey {
//        case audio
//        case audioLengthSEC = "audio_length_sec"
//        case rss
//        case descriptionHighlighted = "description_highlighted"
//        case descriptionOriginal = "description_original"
//        case titleHighlighted = "title_highlighted"
//        case titleOriginal = "title_original"
//        case transcriptsHighlighted = "transcripts_highlighted"
//        case image, thumbnail
//        case itunesID = "itunes_id"
//        case pubDateMS = "pub_date_ms"
//        case id
//        case listennotesURL = "listennotes_url"
//        case explicitContent = "explicit_content"
//        case link
//        case guidFromRSS = "guid_from_rss"
//        case podcast
//    }
//}
