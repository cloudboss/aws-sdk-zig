const std = @import("std");

pub const MediaEncoding = enum {
    pcm,
    ogg_opus,
    flac,
    g711_alaw,
    g711_ulaw,
    g729,

    pub const json_field_names = .{
        .pcm = "pcm",
        .ogg_opus = "ogg-opus",
        .flac = "flac",
        .g711_alaw = "g711-alaw",
        .g711_ulaw = "g711-ulaw",
        .g729 = "g729",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pcm => "pcm",
            .ogg_opus => "ogg-opus",
            .flac => "flac",
            .g711_alaw => "g711-alaw",
            .g711_ulaw => "g711-ulaw",
            .g729 => "g729",
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
