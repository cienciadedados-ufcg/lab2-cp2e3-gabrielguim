library(tidyverse)
library(here)
library(spotifyr)

# Você precisará pegar um id e segredo para seu código aqui: https://developer.spotify.com/my-applications/#!/applications 
# 
chaves = read_csv(here::here("code/chaves-do-spotify.csv"), 
                  col_types = "cc")

Sys.setenv(SPOTIFY_CLIENT_ID = pull(chaves, client_id))
Sys.setenv(SPOTIFY_CLIENT_SECRET = pull(chaves, client_secret))

# Autentica com a API e pega token para usar os endpoints 
access_token <- get_spotify_access_token()


playlist1 = get_user_playlists("spotify") %>% 
    filter(playlist_name == "Afternoon Acoustic")

playlist2 = get_user_playlists("jasonchenmusic") %>% 
    filter(playlist_name == "Acoustic Favorites!")

playlist3 = get_user_playlists("boyceavenue") %>% 
    filter(playlist_name == "Boyce Avenue Acoustic Covers")

playlist4 = get_user_playlists("spotify") %>% 
    filter(playlist_name == "Acoustic Covers")

playlist5 = get_user_playlists("spotify") %>% 
    filter(playlist_name == "Classic Acoustic")


tracks1 = get_playlist_tracks(playlist1)
track_audio_features1 <- get_track_audio_features(tracks1)

tracks2 = get_playlist_tracks(playlist2)
track_audio_features2 <- get_track_audio_features(tracks2)

tracks3 = get_playlist_tracks(playlist3)
track_audio_features3 <- get_track_audio_features(tracks3)

tracks4 = get_playlist_tracks(playlist4)
track_audio_features4 <- get_track_audio_features(tracks4)

tracks5 = get_playlist_tracks(playlist5)
track_audio_features5 <- get_track_audio_features(tracks5)

tots1 <- playlist1 %>%
    select(-playlist_img) %>%
    left_join(tracks1, by = 'playlist_name') %>%
    left_join(track_audio_features1, by = 'track_uri')

tots2 <- playlist2 %>%
    select(-playlist_img) %>%
    left_join(tracks2, by = 'playlist_name') %>%
    left_join(track_audio_features2, by = 'track_uri')

tots3 <- playlist3 %>%
    select(-playlist_img) %>%
    left_join(tracks3, by = 'playlist_name') %>%
    left_join(track_audio_features3, by = 'track_uri')

tots4 <- playlist4 %>%
    select(-playlist_img) %>%
    left_join(tracks4, by = 'playlist_name') %>%
    left_join(track_audio_features4, by = 'track_uri')

tots5 <- playlist5 %>%
    select(-playlist_img) %>%
    left_join(tracks5, by = 'playlist_name') %>%
    left_join(track_audio_features5, by = 'track_uri')

tots <- rbind(tots1, tots2, tots3, tots4, tots5)

tots %>% 
    write_csv(here::here("data/acoustic-spotify-playlist.csv"))
