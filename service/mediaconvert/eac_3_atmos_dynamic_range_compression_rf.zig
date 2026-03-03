const std = @import("std");

/// Choose the Dolby dynamic range control (DRC) profile that MediaConvert uses
/// when encoding the metadata in the Dolby stream for the RF operating mode.
/// Default value: Film light Related setting: To have MediaConvert use the
/// value you specify here, keep the default value, Custom for the setting
/// Dynamic range control. Otherwise, MediaConvert ignores Dynamic range
/// compression RF. For information about the Dolby DRC operating modes and
/// profiles, see the Dynamic Range Control chapter of the Dolby Metadata Guide
/// at
/// https://developer.dolby.com/globalassets/professional/documents/dolby-metadata-guide.pdf.
pub const Eac3AtmosDynamicRangeCompressionRf = enum {
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
