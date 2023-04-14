//
//  ResponseBest.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 08/04/23.
//

import Foundation

// MARK: - BestPodCastResponse
struct BestPodCastResponse: Codable {
    let id: Int
    let name: String
    let parentID: JSONNull?
    let podcasts: [UrlPodcast]
    let total: Int
    let hasNext, hasPrevious: Bool
    let pageNumber, previousPageNumber, nextPageNumber: Int
    let listennotesURL: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case parentID = "parent_id"
        case podcasts, total
        case hasNext = "has_next"
        case hasPrevious = "has_previous"
        case pageNumber = "page_number"
        case previousPageNumber = "previous_page_number"
        case nextPageNumber = "next_page_number"
        case listennotesURL = "listennotes_url"
    }
}

// MARK: - Podcast
struct UrlPodcast: Codable {
    let id, title, publisher: String
    let image, thumbnail: String
    let listennotesURL: String
    let listenScore, listenScoreGlobalRank: String
    let totalEpisodes, audioLengthSEC, updateFrequencyHours: Int
    let explicitContent: Bool
    let description: String
    let itunesID: Int
    let rss: String
    let latestPubDateMS: Int
    let latestEpisodeID: String
    let earliestPubDateMS: Int
    let language: String
    let country: String
    let website: String?
    let extra: Extra
    let isClaimed: Bool
    let email: String
    let type: TypeEnum
    let lookingFor: LookingFor
    let genreIDS: [Int]

    enum CodingKeys: String, CodingKey {
        case id, title, publisher, image, thumbnail
        case listennotesURL = "listennotes_url"
        case listenScore = "listen_score"
        case listenScoreGlobalRank = "listen_score_global_rank"
        case totalEpisodes = "total_episodes"
        case audioLengthSEC = "audio_length_sec"
        case updateFrequencyHours = "update_frequency_hours"
        case explicitContent = "explicit_content"
        case description
        case itunesID = "itunes_id"
        case rss
        case latestPubDateMS = "latest_pub_date_ms"
        case latestEpisodeID = "latest_episode_id"
        case earliestPubDateMS = "earliest_pub_date_ms"
        case language, country, website, extra
        case isClaimed = "is_claimed"
        case email, type
        case lookingFor = "looking_for"
        case genreIDS = "genre_ids"
    }
}

enum Country: String, Codable {
    case brazil = "Brazil"
    case unitedStates = "United States"
}

// MARK: - Extra
struct Extra: Codable {
    let twitterHandle, facebookHandle, instagramHandle, wechatHandle: String
    let patreonHandle, youtubeURL, linkedinURL, spotifyURL: String
    let googleURL, amazonMusicURL, url1, url2: String
    let url3: String

    enum CodingKeys: String, CodingKey {
        case twitterHandle = "twitter_handle"
        case facebookHandle = "facebook_handle"
        case instagramHandle = "instagram_handle"
        case wechatHandle = "wechat_handle"
        case patreonHandle = "patreon_handle"
        case youtubeURL = "youtube_url"
        case linkedinURL = "linkedin_url"
        case spotifyURL = "spotify_url"
        case googleURL = "google_url"
        case amazonMusicURL = "amazon_music_url"
        case url1, url2, url3
    }
}

enum Language: String, Codable {
    case english = "English"
    case portuguese = "Portuguese"
    case spanish = "Spanish"
}

// MARK: - LookingFor
struct LookingFor: Codable {
    let sponsors, guests, cohosts, crossPromotion: Bool

    enum CodingKeys: String, CodingKey {
        case sponsors, guests, cohosts
        case crossPromotion = "cross_promotion"
    }
}

enum TypeEnum: String, Codable {
    case episodic = "episodic"
    case serial = "serial"
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
