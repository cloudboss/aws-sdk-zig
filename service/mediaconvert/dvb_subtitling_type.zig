const std = @import("std");

/// Specify whether your DVB subtitles are standard or for hearing impaired.
/// Choose hearing impaired if your subtitles include audio descriptions and
/// dialogue. Choose standard if your subtitles include only dialogue.
pub const DvbSubtitlingType = enum {
    hearing_impaired,
    standard,

    pub const json_field_names = .{
        .hearing_impaired = "HEARING_IMPAIRED",
        .standard = "STANDARD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .hearing_impaired => "HEARING_IMPAIRED",
            .standard => "STANDARD",
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
