CREATE TABLE netflix_titles (
    show_id TEXT ,
    type TEXT,
    title TEXT,
    director TEXT,
    cast_members TEXT,
    country TEXT,
    date_added TEXT,
    release_year INTEGER,
    rating TEXT,
    duration TEXT,
    listed_in TEXT,
    description TEXT
);


COPY netflix_titles 
FROM 'D:/Data Set/New folder/netflix_titles.csv' 
DELIMITER ',' 
CSV HEADER 
ENCODING 'UTF8';


SELECT * FROM netflix_titles LIMIT 5;
select * from netflix_titles;



UPDATE "netflix_titles"
SET 
    "director" = COALESCE("director", 'Unknown'),
    "cast_members" = COALESCE("cast_members", 'Unknown'),
    "country" = COALESCE("country", 'Unknown');


SELECT *, COUNT(*)
FROM netflix_titles
GROUP BY 
    show_id, type, title, director, cast_members, country, 
    date_added, release_year, rating, duration, listed_in, description
HAVING COUNT(*) > 1;

ALTER TABLE "netflix_titles" ADD COLUMN "added_year" INTEGER;

UPDATE "netflix_titles"
SET "added_year" = EXTRACT(YEAR FROM TO_DATE(TRIM("date_added"), 'Month DD, YYYY'))
WHERE "date_added" IS NOT NULL AND "date_added" != '';

ALTER TABLE "netflix_titles" ADD COLUMN "unit_value" INTEGER;
ALTER TABLE "netflix_titles" ADD COLUMN "unit_type" VARCHAR(20);

UPDATE "netflix_titles"
SET 
    "unit_value" = CAST(SPLIT_PART("duration", ' ', 1) AS INTEGER),
    "unit_type" = SPLIT_PART("duration", ' ', 2)
WHERE "duration" IS NOT NULL;