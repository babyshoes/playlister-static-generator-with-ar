require 'spec_helper'

describe SiteGenerator do
  let(:site_generator){SiteGenerator.new("./tmp/_site")}
  before do
    reset_database
    seed_database
  end

  it 'accepts a path to generate a site into' do
    expect(site_generator.path).to eq("./tmp/_site")
  end

  it 'builds an index.html' do
    site_generator.build_index
    
    index = File.read("./tmp/_site/index.html")
    expect(index).to include("Artists - 2")
    expect(index).to include("Genres - 2")
    expect(index).to include("Songs - 2")
  end

  it 'builds an artist index' do
    site_generator.build_artists_index

    index = File.read("./tmp/_site/artists/index.html")
    expect(index).to include("Action Bronson")
    expect(index).to include("tUnE-yArDs")
  end

  it 'builds an artist page' do
    artist = Artist.all.first
    site_generator.build_artist_page(artist)

    page = File.read("./tmp/_site/artists/#{artist.to_slug}.html")
    expect(page).to include("Action Bronson")
    expect(page).to include("Larry Csonka")
    expect(page).to include("indie")
  end  

  it 'builds an genre index' do
    site_generator.build_genres_index

    index = File.read("./tmp/_site/genres/index.html")
    expect(index).to include("indie")
    expect(index).to include("dance")
  end

  it 'builds an genre page' do
    genre = Genre.all.first
    site_generator.build_genre_page(genre)

    page = File.read("./tmp/_site/genres/#{genre.to_slug}.html")
    expect(page).to include(genre.songs.first.name)
    expect(page).to include("Action Bronson")
  end  

  it 'builds an song index' do
    site_generator.build_songs_index

    index = File.read("./tmp/_site/songs/index.html")
    expect(index).to include(Song.all[0].name)
    expect(index).to include(Song.all[1].name)
  end

  it 'builds a song page' do
    song = Song.all.first
    site_generator.build_song_page(song)

    page = File.read("./tmp/_site/songs/#{song.to_slug}.html")
    expect(page).to include(song.name)
  end
end