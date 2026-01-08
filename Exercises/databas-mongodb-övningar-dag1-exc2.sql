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

    // Kommandon
    // 2. Visa alla artister
db.myArtists.find()

    // 3. Visa en speciell artist genom att använda find()
db.myArtists.find({ artist: "Metallica" })

    // 4. Visa alla artister som är födda efter ett visst årtal
db.myArtists.find({ birth: {$gt: 1990}})

    // 5. Sök efter en titel på ett album med find o få träff på artisten som givit ut albumet.
db.myArtists.find({ albums: "Magma" })

    // med Regex(sökningen behöver inte vara exakt(?))
db.myArtists.find({ albums: {$regex:"agma"} })

    // 6. Räkna antalet dokument(artister) som finns i databasen
db.myArtists.countDocuments()

    // 7. Räkna hur många docs det finns i databasen utifrån ett kriterie
db.myArtists.countDocuments({ birth: {$gte: 1990}})

    // 8. Gör en updateOne() lägg till ett nytt key/value t ex vilket land artisten kommer ifrån för en specifik artist.
db.myArtists.updateOne(
    { artist: "Metallica" },
    {
        $set: { country: "California, USA"}
    }
)

    // CRUD-operationer
    // 9. CREATE: (Lägg till ny artist)
db.myArtists.insertOne({
    artist: "thrown",
    birth: 2019,
    albums: ["Extended Pain", "Excessive Guilt"],
    country: "Sweden"
})

    // 10. READ: (Kontrollera att det har skapats)
db.myArtists.find()

    // 11. UPDATE: (Uppdatera med något du väljer själv som finns sparat(oklar beskrivning much...?))
db.myArtists.updateOne(
    { artist: "thrown" },
    {
        $set: { genres: [
            "Metalcore", "Harcore"]
        }
    }
)

    // 12. DELETE: (Radera den nya artisten)
db.myArtists.deleteOne({ artist: "thrown" })
