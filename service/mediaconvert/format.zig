const std = @import("std");

pub const Format = enum {
    mp_4,
    quicktime,
    matroska,
    webm,
    mxf,
    wave,
    avi,
    mpegts,
    mpegps,
    mp_3,
    flac,
    asf,
    ogg,
    three_gp,
    three_g_2,
    aac,
    ac_3,
    eac_3,

    pub const json_field_names = .{
        .mp_4 = "mp4",
        .quicktime = "quicktime",
        .matroska = "matroska",
        .webm = "webm",
        .mxf = "mxf",
        .wave = "wave",
        .avi = "avi",
        .mpegts = "mpegts",
        .mpegps = "mpegps",
        .mp_3 = "mp3",
        .flac = "flac",
        .asf = "asf",
        .ogg = "ogg",
        .three_gp = "three_gp",
        .three_g_2 = "three_g2",
        .aac = "aac",
        .ac_3 = "ac3",
        .eac_3 = "eac3",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mp_4 => "mp4",
            .quicktime => "quicktime",
            .matroska => "matroska",
            .webm => "webm",
            .mxf => "mxf",
            .wave => "wave",
            .avi => "avi",
            .mpegts => "mpegts",
            .mpegps => "mpegps",
            .mp_3 => "mp3",
            .flac => "flac",
            .asf => "asf",
            .ogg => "ogg",
            .three_gp => "three_gp",
            .three_g_2 => "three_g2",
            .aac => "aac",
            .ac_3 => "ac3",
            .eac_3 => "eac3",
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
