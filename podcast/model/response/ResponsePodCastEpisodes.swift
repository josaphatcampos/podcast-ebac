//
//  ResponsePodCastEpisodes.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 09/04/23.
//

import Foundation

// MARK: - PodCastEpisodesResponse
struct PodCastEpisodesResponse: Codable {
    let country, listenScore, publisher, rss: String
    let id, title: String
    let updateFrequencyHours: Int
    let listenScoreGlobalRank: String
    let website: String
    let listennotesURL: String
    let itunesID: Int
    let lookingFor: LookingFor
    let email: String
    let genreIDS: [Int]
    let image: String
    let nextEpisodePubDate: Int
    let type: String
    let extra: Extra
    let language: String
    let thumbnail: String
    let description: String
    let audioLengthSEC: Int
    let episodes: [Episode]
    let isClaimed, explicitContent: Bool
    let latestEpisodeID: String
    let totalEpisodes, latestPubDateMS, earliestPubDateMS: Int

    enum CodingKeys: String, CodingKey {
        case country
        case listenScore = "listen_score"
        case publisher, rss, id, title
        case updateFrequencyHours = "update_frequency_hours"
        case listenScoreGlobalRank = "listen_score_global_rank"
        case website
        case listennotesURL = "listennotes_url"
        case itunesID = "itunes_id"
        case lookingFor = "looking_for"
        case email
        case genreIDS = "genre_ids"
        case image
        case nextEpisodePubDate = "next_episode_pub_date"
        case type, extra, language, thumbnail, description
        case audioLengthSEC = "audio_length_sec"
        case episodes
        case isClaimed = "is_claimed"
        case explicitContent = "explicit_content"
        case latestEpisodeID = "latest_episode_id"
        case totalEpisodes = "total_episodes"
        case latestPubDateMS = "latest_pub_date_ms"
        case earliestPubDateMS = "earliest_pub_date_ms"
    }
}

// MARK: - Episode
struct Episode: Codable {
    let pubDateMS: Int
    let title: String
    let image: String
    let audioLengthSEC: Int
    let audio: String
    let id: String
    let link: String
    let guidFromRSS: String
    let listennotesEditURL: String
    let maybeAudioInvalid: Bool
    let description: String
    let listennotesURL: String
    let thumbnail: String
    let explicitContent: Bool

    enum CodingKeys: String, CodingKey {
        case pubDateMS = "pub_date_ms"
        case title, image
        case audioLengthSEC = "audio_length_sec"
        case audio, id, link
        case guidFromRSS = "guid_from_rss"
        case listennotesEditURL = "listennotes_edit_url"
        case maybeAudioInvalid = "maybe_audio_invalid"
        case description
        case listennotesURL = "listennotes_url"
        case thumbnail
        case explicitContent = "explicit_content"
    }
}
