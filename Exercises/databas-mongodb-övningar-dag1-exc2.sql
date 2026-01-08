use myArtists

// 1. Skapa en kollektion med några artister
    db.myArtists.insertMany([
        {
        artist: "Metallica",
        birth: 1981,
        albums: [
            "...And Justice for All",
            "Master of Puppets",
            "Metallica"
            ]
        },
        {
        artist: "Gojira",
        birth: 1996,
        albums: [
            "From Mars to Sirius",
            "L'Enfant Sauvage",
            "Magma"
            ]
        },
        {
        artist: "Currents",
        birth: 2011,
        albums: [
            "I Let the Devil In",
            "The Way It Ends",
            "The Death We Seek"
            ]
        }
    ])
