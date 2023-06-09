//
//  ResponsePodCastEpisodes.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 09/04/23.
//
import Foundation

// MARK: - PodCastEpisodesResponse
struct PodCastEpisodesResponse: Codable {
    let rss: String
    let thumbnail: String
    let latestPubDateMS: Int
    let lookingFor: LookingFor
    let listenScore: Int
    let id: String
    let website: String
    let explicitContent: Bool
    let description: String
    let totalEpisodes: Int
    let image: String
    let language: String
    let updateFrequencyHours: Int
    let episodes: [Episode]
    let title: String
    let itunesID, nextEpisodePubDate: Int
    let listennotesURL: String
    let isClaimed: Bool
    let type: String
    let earliestPubDateMS: Int
    let listenScoreGlobalRank, latestEpisodeID: String
    let genreIDS: [Int]
    let extra: Extra
    let email: String
    let audioLengthSEC: Int
    let country, publisher: String

    enum CodingKeys: String, CodingKey {
        case rss, thumbnail
        case latestPubDateMS = "latest_pub_date_ms"
        case lookingFor = "looking_for"
        case listenScore = "listen_score"
        case id, website
        case explicitContent = "explicit_content"
        case description
        case totalEpisodes = "total_episodes"
        case image, language
        case updateFrequencyHours = "update_frequency_hours"
        case episodes, title
        case itunesID = "itunes_id"
        case nextEpisodePubDate = "next_episode_pub_date"
        case listennotesURL = "listennotes_url"
        case isClaimed = "is_claimed"
        case type
        case earliestPubDateMS = "earliest_pub_date_ms"
        case listenScoreGlobalRank = "listen_score_global_rank"
        case latestEpisodeID = "latest_episode_id"
        case genreIDS = "genre_ids"
        case extra, email
        case audioLengthSEC = "audio_length_sec"
        case country, publisher
    }
}

// MARK: - Episode
struct Episode: Codable {
    let audio: String
    let maybeAudioInvalid: Bool
    let id, description: String
    let explicitContent: Bool
    let guidFromRSS: String
    let audioLengthSEC: Int
    let listennotesURL, link: String
    let thumbnail, image: String
    let title: String
    let pubDateMS: Int64
    let listennotesEditURL: String

    enum CodingKeys: String, CodingKey {
        case audio
        case maybeAudioInvalid = "maybe_audio_invalid"
        case id, description
        case explicitContent = "explicit_content"
        case guidFromRSS = "guid_from_rss"
        case audioLengthSEC = "audio_length_sec"
        case listennotesURL = "listennotes_url"
        case link, thumbnail, image, title
        case pubDateMS = "pub_date_ms"
        case listennotesEditURL = "listennotes_edit_url"
    }
}


