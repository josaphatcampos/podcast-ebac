//
//  ResponseBest.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 08/04/23.
//

import Foundation

// MARK: - BestPodCastResponse
struct BestPodCastResponse: Codable {
    let id: Int?
    let name: String?
    let total: Int?
    let hasNext: Bool?
    let podcasts: [UrlPodcast]?
    let parentID, pageNumber: Int?
    let hasPrevious: Bool?
    let listennotesURL: String?
    let nextPageNumber, previousPageNumber: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, total
        case hasNext = "has_next"
        case podcasts
        case parentID = "parent_id"
        case pageNumber = "page_number"
        case hasPrevious = "has_previous"
        case listennotesURL = "listennotes_url"
        case nextPageNumber = "next_page_number"
        case previousPageNumber = "previous_page_number"
    }
}

// MARK: - Podcast
struct UrlPodcast: Codable {
    let id: String?
    let rss: String?
    let type: TypeEnum?
    let email: String?
    let extra: Extra?
    let image: String?
    let title: String?
    let country: String?
    let website: String?
    let language: String?
    let genreIDS: [Int]?
    let itunesID: Int?
    let publisher: String?
    let thumbnail: String?
    let isClaimed: Bool?
    let description: String?
    let lookingFor: LookingFor?
    let listenScore, totalEpisodes: Int?
    let listennotesURL: String?
    let audioLengthSEC: Int?
    let explicitContent: Bool?
    let latestEpisodeID: String?
    let latestPubDateMS, earliestPubDateMS, updateFrequencyHours: Int?
    let listenScoreGlobalRank: ListenScoreGlobalRank?

    enum CodingKeys: String, CodingKey {
        case id, rss, type, email, extra, image, title, country, website, language
        case genreIDS = "genre_ids"
        case itunesID = "itunes_id"
        case publisher, thumbnail
        case isClaimed = "is_claimed"
        case description
        case lookingFor = "looking_for"
        case listenScore = "listen_score"
        case totalEpisodes = "total_episodes"
        case listennotesURL = "listennotes_url"
        case audioLengthSEC = "audio_length_sec"
        case explicitContent = "explicit_content"
        case latestEpisodeID = "latest_episode_id"
        case latestPubDateMS = "latest_pub_date_ms"
        case earliestPubDateMS = "earliest_pub_date_ms"
        case updateFrequencyHours = "update_frequency_hours"
        case listenScoreGlobalRank = "listen_score_global_rank"
    }
}

enum Country: String, Codable {
    case unitedStates = "United States"
}

// MARK: - Extra
struct Extra: Codable {
    let url1: String?
    let url2, url3: String?
    let googleURL, spotifyURL, youtubeURL, linkedinURL: String?
    let wechatHandle, patreonHandle, twitterHandle, facebookHandle: String?
    let amazonMusicURL: String?
    let instagramHandle: String?

    enum CodingKeys: String, CodingKey {
        case url1, url2, url3
        case googleURL = "google_url"
        case spotifyURL = "spotify_url"
        case youtubeURL = "youtube_url"
        case linkedinURL = "linkedin_url"
        case wechatHandle = "wechat_handle"
        case patreonHandle = "patreon_handle"
        case twitterHandle = "twitter_handle"
        case facebookHandle = "facebook_handle"
        case amazonMusicURL = "amazon_music_url"
        case instagramHandle = "instagram_handle"
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
    let guests, cohosts, sponsors, crossPromotion: Bool?

    enum CodingKeys: String, CodingKey {
        case guests, cohosts, sponsors
        case crossPromotion = "cross_promotion"
    }
}

enum TypeEnum: String, Codable {
    case episodic = "episodic"
}
