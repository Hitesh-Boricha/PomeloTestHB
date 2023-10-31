//
//  PopularModel.swift
//  PomeloTestHB
//
//  Created by Hitesh Boricha on 30/10/23.
//

import Foundation
import UIKit

struct PopularModel : Codable {
    let status, copyright : String?
    let num_results : Int?
    let results : [MostPopularResult]?
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case copyright = "copyright"
        case num_results = "num_results"
        case results = "results"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
        num_results = try values.decodeIfPresent(Int.self, forKey: .num_results)
        results = try values.decodeIfPresent([MostPopularResult].self, forKey: .results)
    }
}

struct MostPopularResult : Codable {
    let uri, url, source, published_date, updated, section, subsection, nytdsection, adx_keywords, byline, type, title, abstract : String?
    let id, asset_id, eta_id : Int?
    let column: JSONNull?
    let des_facet : [String]?
    let org_facet : [String]?
    let per_facet : [String]?
    let geo_facet : [String]?
    let media : [MediaResult]?
    
    enum CodingKeys: String, CodingKey {
        case uri = "uri"
        case url = "url"
        case id = "id"
        case asset_id = "asset_id"
        case source = "source"
        case published_date = "published_date"
        case updated = "updated"
        case section = "section"
        case subsection = "subsection"
        case nytdsection = "nytdsection"
        case adx_keywords = "adx_keywords"
        case column = "column"
        case byline = "byline"
        case type = "type"
        case title = "title"
        case abstract = "abstract"
        case des_facet = "des_facet"
        case org_facet = "org_facet"
        case per_facet = "per_facet"
        case geo_facet = "geo_facet"
        case media = "media"
        case eta_id = "eta_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        uri = try values.decodeIfPresent(String.self, forKey: .uri)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        asset_id = try values.decodeIfPresent(Int.self, forKey: .asset_id)
        source = try values.decodeIfPresent(String.self, forKey: .source)
        published_date = try values.decodeIfPresent(String.self, forKey: .published_date)
        updated = try values.decodeIfPresent(String.self, forKey: .updated)
        section = try values.decodeIfPresent(String.self, forKey: .section)
        subsection = try values.decodeIfPresent(String.self, forKey: .subsection)
        nytdsection = try values.decodeIfPresent(String.self, forKey: .nytdsection)
        adx_keywords = try values.decodeIfPresent(String.self, forKey: .adx_keywords)
        column = try values.decodeIfPresent(JSONNull.self, forKey: .column)
        byline = try values.decodeIfPresent(String.self, forKey: .byline)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        abstract = try values.decodeIfPresent(String.self, forKey: .abstract)
        des_facet = try values.decodeIfPresent([String].self, forKey: .des_facet)
        org_facet = try values.decodeIfPresent([String].self, forKey: .org_facet)
        per_facet = try values.decodeIfPresent([String].self, forKey: .per_facet)
        geo_facet = try values.decodeIfPresent([String].self, forKey: .geo_facet)
        media = try values.decodeIfPresent([MediaResult].self, forKey: .media)
        eta_id = try values.decodeIfPresent(Int.self, forKey: .eta_id)
    }
}


struct MediaResult : Codable {
    let type, subtype, caption, copyright : String?
    let approved_for_syndication : Int?
    let mediaList : [MediaMetadata]?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case subtype = "subtype"
        case caption = "caption"
        case copyright = "copyright"
        case approved_for_syndication = "approved_for_syndication"
        case mediaList = "media-metadata"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        subtype = try values.decodeIfPresent(String.self, forKey: .subtype)
        caption = try values.decodeIfPresent(String.self, forKey: .caption)
        copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
        approved_for_syndication = try values.decodeIfPresent(Int.self, forKey: .approved_for_syndication)
        mediaList = try values.decodeIfPresent([MediaMetadata].self, forKey: .mediaList)
    }
    
}


struct MediaMetadata : Codable {
    let url, format : String?
    let height, width : Int?
    enum CodingKeys: String, CodingKey {
        case url = "url"
        case format = "format"
        case height = "height"
        case width = "width"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        format = try values.decodeIfPresent(String.self, forKey: .format)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
    }
    
}

// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
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
