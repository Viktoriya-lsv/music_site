CREATE table if not exists Genres (
	id SERIAL primary key,
	name VARCHAR(255) not null unique
);

create table if not exists Artists (
	id SERIAL primary key,
	name VARCHAR(255) not null
);

create table if not exists Artist_Genre (
	artist_id INT references Artists(id) on delete cascade,
	genre_id INT references Genres(id) on delete cascade,
	primary key (artist_id, genre_id)
);

create table if not exists Albums (
	id SERIAL primary key,
	name VARCHAR(255) not null,
	year INT not null
);

create table if not exists Artist_Album (
	artist_id INT references Artists(id) on delete cascade,
	album_id INT references Albums(id) on delete cascade,
	primary key (artist_id, album_id)
);

create table if not exists Tracks (
	id SERIAL primary key,
	name VARCHAR(255) not null,
	duration INTERVAL not null,
	album_id INT references Albums(id) on delete cascade
);

create table if not exists Compilations (
	id SERIAL primary key,
	name VARCHAR(255) not null,
	year INT not null
);

create table if not exists Track_Compilation (
	track_id INT references Tracks(id) on delete cascade,
	compilation_id INT references Compilations(id) on delete cascade,
	primary key (track_id, compilation_id)
);

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
WHERE name ilike '%my%';

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
JOIN artist_album ON artists.id = artist_album.artist_id
JOIN albums ON artist_album.album_id = albums.id
WHERE albums.year != 2020;

SELECT DISTINCT compilations.name
FROM compilations
JOIN track_compilation ON compilations.id = track_compilation.compilation_id
JOIN tracks ON track_compilation.track_id = tracks.id
JOIN albums ON tracks.album_id = albums.id
JOIN artist_album ON albums.id = artist_album.album_id
JOIN artists ON artist_album.artist_id = artists.id
WHERE artists.name = 'Eminem';
