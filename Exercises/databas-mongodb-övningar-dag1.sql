-- 1. Lägg till en ny författare med tillhörande böcker med insertOne med följande key:value - author, birth, books (som en array), language, genres (som en array).

use MyAuthors;

    db.authors.insertOne(
        {
            author: "Tolkien",
            birth: "1892",
            books: [
                "Sagan om ringen",
                "Sagan om de två tornen",
                "Sagn om konungens återkomst"
                ]
        }
    )


-- 2. Räkna hur många författare det finns totalt.
    db.authors.countDocuments()

-- 3. Räkna hur många författare som finns inom en viss genre.
    db.authors.countDocuments( {genres: "fantasy"})

-- 4. Uppdatera författarna Astrid lindgren, August Strindberg samt din nya författare du har lagt till så att de har key:value för death (med årtal när de dog).

    db.authors.updateOne(
        { author: "Astrid Lindgren" },
        {
            $set: { death: 2002 }
        }
    )

        db.authors.updateOne(
        { author: "August Strindberg" },
        {
            $set: { death: 1912 }
        }
    )

        db.authors.updateOne(
        { author: "Tolkien" },
        {
            $set: { death: 1973 }
        }
    )

-- 5. Räkna hur många författare som dog efter 1950.
    db.authors.find( { death: { $gt: 1950 }})

-- 6. Uppdatera Astrid Lindgren så att hon har några fler böcker
    db.authors.updateOne(
        { author: "Astrid Lindgren" },
        {
            $set: { author: "Astrid Lindgren", books: [
                "Bröderna Lejonhjärta", "Här kommer Pippi Långstrump", "Mio min Mio", "Ronja Rövardotter"
                ]
                }
        }
    )

-- 7. Lägg till minst två författare med insertMany med följande key:value - author, birth, books (som en array), language, genres (som en array), death.
    db.authors.insertMany([
        { author: "Akira Toriyama",
            birth: 1955,
            books: [
                "Dragon Ball"
                ],
            death: 2024
            },
        {
            author: "Hajime Isayama",
            birth: 1986,
            books: [
                "Attack on Titan"
                ],
        }
    ]
    )
