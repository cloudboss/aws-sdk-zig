const std = @import("std");

/// When you want to add Dolby dynamic range compression (DRC) signaling to your
/// output stream, we recommend that you use the mode-specific settings instead
/// of Dynamic range compression profile. The mode-specific settings are Dynamic
/// range compression profile, line mode and Dynamic range compression profile,
/// RF mode. Note that when you specify values for all three settings,
/// MediaConvert ignores the value of this setting in favor of the mode-specific
/// settings. If you do use this setting instead of the mode-specific settings,
/// choose None to leave out DRC signaling. Keep the default Film standard to
/// set the profile to Dolby's film standard profile for all operating modes.
pub const Ac3DynamicRangeCompressionProfile = enum {
    film_standard,
    none,

    pub const json_field_names = .{
        .film_standard = "FILM_STANDARD",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .film_standard => "FILM_STANDARD",
            .none => "NONE",
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
