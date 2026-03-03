const std = @import("std");

pub const AudioFormat = enum {
    mp3,
    opus,
    wav,
    aac,
    flac,
    mp4,
    ogg,
    mkv,
    mka,
    x_aac,
    m4_a,
    mpeg,
    mpga,
    pcm,
    webm,

    pub const json_field_names = .{
        .mp3 = "mp3",
        .opus = "opus",
        .wav = "wav",
        .aac = "aac",
        .flac = "flac",
        .mp4 = "mp4",
        .ogg = "ogg",
        .mkv = "mkv",
        .mka = "mka",
        .x_aac = "x-aac",
        .m4_a = "m4a",
        .mpeg = "mpeg",
        .mpga = "mpga",
        .pcm = "pcm",
        .webm = "webm",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mp3 => "mp3",
            .opus => "opus",
            .wav => "wav",
            .aac => "aac",
            .flac => "flac",
            .mp4 => "mp4",
            .ogg => "ogg",
            .mkv => "mkv",
            .mka => "mka",
            .x_aac => "x-aac",
            .m4_a => "m4a",
            .mpeg => "mpeg",
            .mpga => "mpga",
            .pcm => "pcm",
            .webm => "webm",
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
