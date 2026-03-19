//
//  AnotherView.swift
//  06
//
//  Created by Turma01-14 on 16/03/26.
//

enum ContentType: String {
    case movie = "Filme"
    case serie = "Série"
}

enum ContentGenres: String {
    case action = "Ação"
    case mystery = "Mistério"
    case supernatural = "Sobrenatural"
    case fantasy = "Fantasia"
    case romance = "Romance"
    case ecchi = "Ecchi"
    case adventure = "Aventura"
    case comedy = "Comédia"
}

struct Content: Hashable {
    let category: ContentType
    let name: String
    let coverURL: String
    let year: Int
    let gender: [ContentGenres]
    let malScore: Float
}

let contentArray: [Content] = [
    Content(
        category: ContentType.movie,
        name: "Kizumonogatari I: Tekketsu-hen",
        coverURL: "https://myanimelist.net/images/anime/1783/112810.jpg",
        year: 2016,
        gender: [ContentGenres.action, ContentGenres.mystery, ContentGenres.supernatural],
        malScore: 8.36
    ),
    Content(
        category: ContentType.movie,
        name: "Kizumonogatari II: Nekketsu-hen",
        coverURL: "https://myanimelist.net/images/anime/1981/112812.jpg",
        year: 2016,
        gender: [ContentGenres.action, ContentGenres.mystery, ContentGenres.supernatural],
        malScore: 8.56
    ),
    Content(
        category: ContentType.movie,
        name: "Kizumonogatari III: Reiketsu-hen",
        coverURL: "https://myanimelist.net/images/anime/1084/112813.jpg",
        year: 2017,
        gender: [ContentGenres.action, ContentGenres.mystery, ContentGenres.supernatural],
        malScore: 8.78
    ),
    Content(
        category: ContentType.serie,
        name: "Rakudai Kishi no Cavalry",
        coverURL: "https://myanimelist.net/images/anime/9/76493.jpg",
        year: 2015,
        gender: [ContentGenres.action, ContentGenres.fantasy, ContentGenres.romance, ContentGenres.ecchi],
        malScore: 7.41
    ),
    Content(
        category: ContentType.serie,
        name: "Bleach",
        coverURL: "https://myanimelist.net/images/anime/1541/147774.jpg",
        year: 2004,
        gender: [ContentGenres.action, ContentGenres.adventure, ContentGenres.supernatural],
        malScore: 7.99
    ),
    Content(
        category: ContentType.serie,
        name: "Bleach: Sennen Kessen-hen",
        coverURL: "https://myanimelist.net/images/anime/1908/135431.jpg",
        year: 2022,
        gender: [ContentGenres.action, ContentGenres.adventure, ContentGenres.supernatural],
        malScore: 8.98
    ),
    Content(
        category: ContentType.serie,
        name: "Bleach: Sennen Kessen-hen - Ketsubetsu-tan",
        coverURL: "https://myanimelist.net/images/anime/1164/138058.jpg",
        year: 2023,
        gender: [ContentGenres.action, ContentGenres.adventure, ContentGenres.supernatural],
        malScore: 8.70
    ),
    Content(
        category: ContentType.serie,
        name: "Bleach: Sennen Kessen-hen - Soukoku-tan",
        coverURL: "https://myanimelist.net/images/anime/1595/144074.jpg",
        year: 2024,
        gender: [ContentGenres.action, ContentGenres.adventure, ContentGenres.supernatural],
        malScore: 8.67
    ),
    Content(
        category: ContentType.serie,
        name: "Seireitsukai no Blade Dance",
        coverURL: "https://myanimelist.net/images/anime/7/63031.jpg",
        year: 2014,
        gender: [ContentGenres.action, ContentGenres.comedy, ContentGenres.fantasy, ContentGenres.romance, ContentGenres.ecchi],
        malScore: 6.65
    ),
    Content(
        category: ContentType.serie,
        name: "JoJo no Kimyou na Bouken",
        coverURL: "https://myanimelist.net/images/anime/3/40409.jpg",
        year: 2021,
        gender: [ContentGenres.action, ContentGenres.adventure, ContentGenres.supernatural],
        malScore: 7.87
    ),
    Content(
        category: ContentType.serie,
        name: "JoJo no Kimyou na Bouken Part 3: Stardust Crusaders - Egypt-hen",
        coverURL: "https://myanimelist.net/images/anime/11/75045.jpg",
        year: 2015,
        gender: [ContentGenres.action, ContentGenres.adventure],
        malScore: 8.44
    ),
    Content(
        category: ContentType.serie,
        name: "JoJo no Kimyou na Bouken Part 6: Stone Ocean Part 3",
        coverURL: "https://myanimelist.net/images/anime/1233/128920.jpg",
        year: 2022,
        gender: [ContentGenres.action, ContentGenres.adventure],
        malScore: 8.51
    )
]
