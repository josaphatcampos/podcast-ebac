//
//  ResponseBest.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 08/04/23.
//

//import Foundation
//
//// MARK: - BestPodCastResponse
//struct BestPodCastResponse: Codable {
//    let id: Int
//    let name: String
//    let parentID: JSONNull?
//    let podcasts: [UrlPodcast]
//    let total: Int
//    let hasNext, hasPrevious: Bool
//    let pageNumber, previousPageNumber, nextPageNumber: Int
//    let listennotesURL: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case parentID = "parent_id"
//        case podcasts, total
//        case hasNext = "has_next"
//        case hasPrevious = "has_previous"
//        case pageNumber = "page_number"
//        case previousPageNumber = "previous_page_number"
//        case nextPageNumber = "next_page_number"
//        case listennotesURL = "listennotes_url"
//    }
//}
//
//// MARK: - Podcast
//struct UrlPodcast: Codable {
//    let id, title, publisher: String
//    let image, thumbnail: String
//    let listennotesURL: String
//    let listenScore, listenScoreGlobalRank: String
//    let totalEpisodes, audioLengthSEC, updateFrequencyHours: Int
//    let explicitContent: Bool
//    let description: String
//    let itunesID: Int
//    let rss: String
//    let latestPubDateMS: Int
//    let latestEpisodeID: String
//    let earliestPubDateMS: Int
//    let language: String
//    let country: String
//    let website: String?
//    let extra: Extra
//    let isClaimed: Bool
//    let email: String
//    let type: TypeEnum
//    let lookingFor: LookingFor
//    let genreIDS: [Int]
//
//    enum CodingKeys: String, CodingKey {
//        case id, title, publisher, image, thumbnail
//        case listennotesURL = "listennotes_url"
//        case listenScore = "listen_score"
//        case listenScoreGlobalRank = "listen_score_global_rank"
//        case totalEpisodes = "total_episodes"
//        case audioLengthSEC = "audio_length_sec"
//        case updateFrequencyHours = "update_frequency_hours"
//        case explicitContent = "explicit_content"
//        case description
//        case itunesID = "itunes_id"
//        case rss
//        case latestPubDateMS = "latest_pub_date_ms"
//        case latestEpisodeID = "latest_episode_id"
//        case earliestPubDateMS = "earliest_pub_date_ms"
//        case language, country, website, extra
//        case isClaimed = "is_claimed"
//        case email, type
//        case lookingFor = "looking_for"
//        case genreIDS = "genre_ids"
//    }
//}
//
//enum Country: String, Codable {
//    case brazil = "Brazil"
//    case unitedStates = "United States"
//}
//
//// MARK: - Extra
//struct Extra: Codable {
//    let twitterHandle, facebookHandle, instagramHandle, wechatHandle: String
//    let patreonHandle, youtubeURL, linkedinURL, spotifyURL: String
//    let googleURL, amazonMusicURL, url1, url2: String
//    let url3: String
//
//    enum CodingKeys: String, CodingKey {
//        case twitterHandle = "twitter_handle"
//        case facebookHandle = "facebook_handle"
//        case instagramHandle = "instagram_handle"
//        case wechatHandle = "wechat_handle"
//        case patreonHandle = "patreon_handle"
//        case youtubeURL = "youtube_url"
//        case linkedinURL = "linkedin_url"
//        case spotifyURL = "spotify_url"
//        case googleURL = "google_url"
//        case amazonMusicURL = "amazon_music_url"
//        case url1, url2, url3
//    }
//}
//
//enum Language: String, Codable {
//    case english = "English"
//    case portuguese = "Portuguese"
//    case spanish = "Spanish"
//}
//
//// MARK: - LookingFor
//struct LookingFor: Codable {
//    let sponsors, guests, cohosts, crossPromotion: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case sponsors, guests, cohosts
//        case crossPromotion = "cross_promotion"
//    }
//}
//
//enum TypeEnum: String, Codable {
//    case episodic = "episodic"
//    case serial = "serial"
//}
//
//// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let bestPodCastResponse = try? JSONDecoder().decode(BestPodCastResponse.self, from: jsonData)

import Foundation

// MARK: - BestPodCastResponse
struct BestPodCastResponse: Codable {
    let previousPageNumber: Int
    let podcasts: [UrlPodcast]
    let id: Int
    let name: String
    let listennotesURL: String
    let hasNext: Bool
    let nextPageNumber, pageNumber, parentID, total: Int
    let hasPrevious: Bool

    enum CodingKeys: String, CodingKey {
        case previousPageNumber = "previous_page_number"
        case podcasts, id, name
        case listennotesURL = "listennotes_url"
        case hasNext = "has_next"
        case nextPageNumber = "next_page_number"
        case pageNumber = "page_number"
        case parentID = "parent_id"
        case total
        case hasPrevious = "has_previous"
    }
}

// MARK: - Podcast
struct UrlPodcast: Codable {
    let id: String
    let listenScore, updateFrequencyHours: Int
    let type: TypeEnum
    let thumbnail: String
    let audioLengthSEC: Int
    let listennotesURL: String
    let latestEpisodeID: String
    let explicitContent: Bool
    let itunesID: Int
    let language: String
    let earliestPubDateMS: Int
    let title, description: String
    let lookingFor: LookingFor
    let extra: Extra
    let listenScoreGlobalRank: ListenScoreGlobalRank
    let isClaimed: Bool
    let totalEpisodes: Int
    let genreIDS: [Int]
    let rss: String
    let image: String
    let publisher: String
    let website: String
    let email: String?
    let latestPubDateMS: Int
    let country: String

    enum CodingKeys: String, CodingKey {
        case id
        case listenScore = "listen_score"
        case updateFrequencyHours = "update_frequency_hours"
        case type, thumbnail
        case audioLengthSEC = "audio_length_sec"
        case listennotesURL = "listennotes_url"
        case latestEpisodeID = "latest_episode_id"
        case explicitContent = "explicit_content"
        case itunesID = "itunes_id"
        case language
        case earliestPubDateMS = "earliest_pub_date_ms"
        case title, description
        case lookingFor = "looking_for"
        case extra
        case listenScoreGlobalRank = "listen_score_global_rank"
        case isClaimed = "is_claimed"
        case totalEpisodes = "total_episodes"
        case genreIDS = "genre_ids"
        case rss, image, publisher, website, email
        case latestPubDateMS = "latest_pub_date_ms"
        case country
    }
}

enum Country: String, Codable {
    case unitedStates = "United States"
}

// MARK: - Extra
struct Extra: Codable {
    let amazonMusicURL: String
    let instagramHandle: String
    let linkedinURL, youtubeURL: String
    let twitterHandle: String
    let url1: String
    let url3: String
    let googleURL: String
    let wechatHandle, patreonHandle, url2: String
    let spotifyURL: String
    let facebookHandle: String

    enum CodingKeys: String, CodingKey {
        case amazonMusicURL = "amazon_music_url"
        case instagramHandle = "instagram_handle"
        case linkedinURL = "linkedin_url"
        case youtubeURL = "youtube_url"
        case twitterHandle = "twitter_handle"
        case url1, url3
        case googleURL = "google_url"
        case wechatHandle = "wechat_handle"
        case patreonHandle = "patreon_handle"
        case url2
        case spotifyURL = "spotify_url"
        case facebookHandle = "facebook_handle"
    }
}

enum Language: String, Codable {
    case english = "English"
}

enum ListenScoreGlobalRank: String, Codable {
    case the001 = "0.01%"
    case the005 = "0.05%"
}

// MARK: - LookingFor
struct LookingFor: Codable {
    let sponsors, crossPromotion, guests, cohosts: Bool

    enum CodingKeys: String, CodingKey {
        case sponsors
        case crossPromotion = "cross_promotion"
        case guests, cohosts
    }
}

enum TypeEnum: String, Codable {
    case episodic = "episodic"
}
