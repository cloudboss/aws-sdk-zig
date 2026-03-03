const std = @import("std");

pub const MediaFormat = enum {
    mp3,
    mp4,
    wav,
    flac,
    ogg,
    amr,
    webm,
    m4_a,

    pub const json_field_names = .{
        .mp3 = "mp3",
        .mp4 = "mp4",
        .wav = "wav",
        .flac = "flac",
        .ogg = "ogg",
        .amr = "amr",
        .webm = "webm",
        .m4_a = "m4a",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mp3 => "mp3",
            .mp4 => "mp4",
            .wav => "wav",
            .flac => "flac",
            .ogg => "ogg",
            .amr => "amr",
            .webm => "webm",
            .m4_a => "m4a",
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
