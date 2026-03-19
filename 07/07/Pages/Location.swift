//
//  Location.swift
//  07
//
//  Created by Turma01-14 on 17/03/26.
//

struct Location: Hashable {
    let name: String
    let image: String
    let description: String
    let latitude: Double
    let longitude: Double
}

let Locations: [Location] = [
    Location(
        name: "Brazillian Miku House",
        image: "brazillianMikuHouse",
        description: "Hatsune Miku perdeu tudo e está morando de aluguel.",
        latitude: -22.8494037,
        longitude: -43.356112
    ),
    Location(
        name: "Faixa de Gaza",
        image: "mcorelha",
        description: "Na faixa de gaza sou homem bomba, na guerra é tudo ou nada, várias titanium no pente, colete a prova de bala.",
        latitude: 31.4101404,
        longitude: 34.2238827
    ),
    Location(
        name: "Beethoven-Haus Bonn",
        image: "bethoven",
        description: "Casa do século 18 onde Beethoven nasceu, com mostras que incluem manuscritos e o último piano do compositor.",
        latitude: 50.7369154,
        longitude: 7.0986258
    ),
    Location(
        name: "Santa Mônica",
        image: "kratos",
        description: "Athena! You conspire against me? is spoken by Kratos in the 2007 video game God of War II. He says this during a confrontation with the goddess Athena, highlighting his deep distrust of the Olympian gods, whom he believes are betraying him and withholding his freedom.",
        latitude: 34.0087151,
        longitude: -118.5445136
    )
]
