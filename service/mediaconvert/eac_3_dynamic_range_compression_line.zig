/// Choose the Dolby Digital dynamic range control (DRC) profile that
/// MediaConvert uses when encoding the metadata in the Dolby Digital stream for
/// the line operating mode. Related setting: When you use this setting,
/// MediaConvert ignores any value you provide for Dynamic range compression
/// profile. For information about the Dolby Digital DRC operating modes and
/// profiles, see the Dynamic Range Control chapter of the Dolby Metadata Guide
/// at
/// https://developer.dolby.com/globalassets/professional/documents/dolby-metadata-guide.pdf.
pub const Eac3DynamicRangeCompressionLine = enum {
    none,
    film_standard,
    film_light,
    music_standard,
    music_light,
    speech,

    pub const json_field_names = .{
        .none = "NONE",
        .film_standard = "FILM_STANDARD",
        .film_light = "FILM_LIGHT",
        .music_standard = "MUSIC_STANDARD",
        .music_light = "MUSIC_LIGHT",
        .speech = "SPEECH",
    };
};
