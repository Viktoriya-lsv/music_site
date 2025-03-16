INSERT INTO artists (id, name) VALUES
(1, 'Imagine Dragons'),
(2, 'Coldplay'),
(3, 'Eminem'),
(4, 'Adele');

INSERT INTO genres (id, name) VALUES
(1, 'Rock'),
(2, 'Pop'),
(3, 'Rap');

INSERT INTO artist_genre (artist_id, genre_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 2), (1, 2);

INSERT INTO albums (id, name, year) VALUES
(1, 'Evolve', 2017),
(2, 'Music of the Spheres', 2021),
(3, 'The Eminem Show', 2002);

INSERT INTO artist_album (artist_id, album_id) VALUES
(1, 1), (2, 2), (3, 3);

INSERT INTO tracks (id, name, duration, album_id) VALUES
(1, 'Believer', interval '204 seconds', 1),
(2, 'Thunder', interval '187 seconds', 1),
(3, 'Higher Power', INTERVAL '229 seconds', 2),
(4, 'Lose Yourself', INTERVAL '326 seconds', 3),
(5, 'Sky Full of Stars', INTERVAL '268 seconds', 2),
(6, 'Someone Like You', INTERVAL '285 seconds', 3);

INSERT INTO compilations (id, name, year) VALUES
(1, 'Top Hits 2018', 2018),
(2, 'Best of Rock', 2019),
(3, 'Pop Magic', 2020),
(4, 'Rap Legends', 2021);

INSERT INTO track_compilation (compilation_id, track_id) VALUES
(1, 1), (2, 3), (3, 5), (4, 4), (1, 6);

SELECT name, duration FROM tracks
order by duration desc
limit 1;

SELECT name FROM tracks
WHERE duration >= INTERVAL '3 minutes 30 seconds';

SELECT name, year
FROM compilations
WHERE year BETWEEN 2018 AND 2020;

SELECT name
FROM artists
WHERE name NOT LIKE '% %';

SELECT name FROM tracks
WHERE name ilike 'my %'
or name ilike '% my %'
or name ilike '% my'
or name ilike 'my';

SELECT g.name, COUNT(ag.artist_id) AS artist_count
FROM genres g
LEFT JOIN artist_genre ag ON g.id = ag.genre_id
GROUP BY g.name;

SELECT COUNT(tracks.id) AS track_count
FROM tracks
JOIN albums ON tracks.album_id = albums.id
WHERE albums.year BETWEEN 2019 AND 2020;

SELECT albums.name, AVG(EXTRACT(EPOCH FROM tracks.duration)) AS avg_duration_seconds
FROM albums
JOIN tracks ON albums.id = tracks.album_id
GROUP BY albums.name;

SELECT DISTINCT artists.name
FROM artists
where artists.name not in (
	select artists.name
	FROM artists
	JOIN artist_album ON artists.id = artist_album.artist_id
	JOIN albums ON artist_album.album_id = albums.id
	where albums.year = 2020);

SELECT DISTINCT compilations.name
FROM compilations
JOIN track_compilation ON compilations.id = track_compilation.compilation_id
JOIN tracks ON track_compilation.track_id = tracks.id
JOIN albums ON tracks.album_id = albums.id
JOIN artist_album ON albums.id = artist_album.album_id
JOIN artists ON artist_album.artist_id = artists.id
WHERE artists.name = 'Eminem';
