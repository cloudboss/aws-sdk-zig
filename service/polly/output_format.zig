const std = @import("std");

pub const OutputFormat = enum {
    json,
    mp3,
    ogg_opus,
    ogg_vorbis,
    pcm,
    mulaw,
    alaw,

    pub const json_field_names = .{
        .json = "json",
        .mp3 = "mp3",
        .ogg_opus = "ogg_opus",
        .ogg_vorbis = "ogg_vorbis",
        .pcm = "pcm",
        .mulaw = "mulaw",
        .alaw = "alaw",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .json => "json",
            .mp3 => "mp3",
            .ogg_opus => "ogg_opus",
            .ogg_vorbis => "ogg_vorbis",
            .pcm => "pcm",
            .mulaw => "mulaw",
            .alaw => "alaw",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
