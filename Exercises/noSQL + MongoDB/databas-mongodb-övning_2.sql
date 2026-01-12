use myArtists

-- 1. Skapa en kollektion med några artister
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

    -- Kommandon
    -- 2. Visa alla artister
db.myArtists.find()

    -- 3. Visa en speciell artist genom att använda find()
db.myArtists.find({ artist: "Metallica" })

    -- 4. Visa alla artister som är födda efter ett visst årtal
db.myArtists.find({ birth: {$gt: 1990}})

    -- 5. Sök efter en titel på ett album med find o få träff på artisten som givit ut albumet.
db.myArtists.find({ albums: "Magma" })
    -- ...med Regex(sökningen behöver inte vara exakt(?))
db.myArtists.find({ albums: {$regex:"agma"} })

    -- 6. Räkna antalet dokument(artister) som finns i databasen
db.myArtists.countDocuments()

    -- 7. Räkna hur många docs det finns i databasen utifrån ett kriterie
db.myArtists.countDocuments({ birth: {$gte: 1990}})

    -- 8. Gör en updateOne() lägg till ett nytt key/value t ex vilket land artisten kommer ifrån för en specifik artist.
db.myArtists.updateOne(
    { artist: "Metallica" },
    {
        $set: { country: "California, USA"}
    }
)

    -- CRUD-operationer
    -- 9. CREATE: (Lägg till ny artist)
db.myArtists.insertOne({
    artist: "thrown",
    birth: 2019,
    albums: ["Extended Pain", "Excessive Guilt"],
    country: "Sweden"
})

    -- 10. READ: (Kontrollera att det har skapats)
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

    -- 12. DELETE: (Radera den nya artisten)
db.myArtists.deleteOne({ artist: "thrown" })


-- Fortsättning(Dag 2)
-- 1: Skapa ett unikt index
db.authors.createIndex( { "artist": 1 }, { unique: true })


-- 2: Lägg till ett nytt album som ett nytt element med $push
db.myArtists.updateOne(
    { artist: "Metallica" },
    { $push: { albums: "St. Anger" } }
)


-- 3: Uppdatera namn på ett album som finns i en array
db.myArtists.updateOne(
  { artist: "Metallica", albums: "St. Anger" },
  { $set: { "albums.$": "72 Seasons" } }
)

-- 4: Gör några sökningar med find() där du använder sort()
db.myArtists.find().sort( { artist: 1 } ) -- ASC
db.myArtists.find().sort( { artist: -1 } ) -- DESC

    -- Sortera artister från 1990, i stigande ordning
    db.myArtists.find( { birth: { $gte: 1990 } }).sort( { artist: 1 } )


-- 5: Använd find() för att visa artister, specificera vilka fields som ska visas:
db.myArtists.find( { albums: "72 Seasons" }, { artist: 1, albums: 1 } )

    -- Använd också find för att utesluta något fält(id):
db.myArtists.find( { }, { _id: 0 } )


-- 6: Gör en update på en artist men använd _id för att komma åt dokumentet:
db.myArtists.updateOne(
    { _id: ObjectId("696005993673c46f63179c7c") },
    { $push: { albums: "Fortitude" } }
)
