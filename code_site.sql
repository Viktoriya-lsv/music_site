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
