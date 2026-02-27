/// Eac3 Drc Rf
pub const Eac3DrcRf = enum {
    film_light,
    film_standard,
    music_light,
    music_standard,
    none,
    speech,

    pub const json_field_names = .{
        .film_light = "FILM_LIGHT",
        .film_standard = "FILM_STANDARD",
        .music_light = "MUSIC_LIGHT",
        .music_standard = "MUSIC_STANDARD",
        .none = "NONE",
        .speech = "SPEECH",
    };
};
