const std = @import("std");

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

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .film_light => "FILM_LIGHT",
            .film_standard => "FILM_STANDARD",
            .music_light => "MUSIC_LIGHT",
            .music_standard => "MUSIC_STANDARD",
            .none => "NONE",
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
