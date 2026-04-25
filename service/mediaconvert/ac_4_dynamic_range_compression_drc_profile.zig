const std = @import("std");

/// Choose the Dolby AC-4 dynamic range control (DRC) profile that MediaConvert
/// uses when encoding the metadata in the Dolby AC-4 stream for the specified
/// decoder mode. For information about the Dolby AC-4 DRC profiles, see the
/// Dolby AC-4 specification.
pub const Ac4DynamicRangeCompressionDrcProfile = enum {
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

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .film_standard => "FILM_STANDARD",
            .film_light => "FILM_LIGHT",
            .music_standard => "MUSIC_STANDARD",
            .music_light => "MUSIC_LIGHT",
            .speech => "SPEECH",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
