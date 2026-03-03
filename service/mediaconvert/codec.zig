const std = @import("std");

pub const Codec = enum {
    unknown,
    aac,
    ac3,
    eac3,
    flac,
    mp3,
    opus,
    pcm,
    vorbis,
    av1,
    avc,
    hevc,
    jpeg2000,
    mjpeg,
    mpeg1,
    mp4_v,
    mpeg2,
    prores,
    theora,
    vfw,
    vp8,
    vp9,
    qtrle,
    c608,
    c708,
    webvtt,

    pub const json_field_names = .{
        .unknown = "UNKNOWN",
        .aac = "AAC",
        .ac3 = "AC3",
        .eac3 = "EAC3",
        .flac = "FLAC",
        .mp3 = "MP3",
        .opus = "OPUS",
        .pcm = "PCM",
        .vorbis = "VORBIS",
        .av1 = "AV1",
        .avc = "AVC",
        .hevc = "HEVC",
        .jpeg2000 = "JPEG2000",
        .mjpeg = "MJPEG",
        .mpeg1 = "MPEG1",
        .mp4_v = "MP4V",
        .mpeg2 = "MPEG2",
        .prores = "PRORES",
        .theora = "THEORA",
        .vfw = "VFW",
        .vp8 = "VP8",
        .vp9 = "VP9",
        .qtrle = "QTRLE",
        .c608 = "C608",
        .c708 = "C708",
        .webvtt = "WEBVTT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unknown => "UNKNOWN",
            .aac => "AAC",
            .ac3 => "AC3",
            .eac3 => "EAC3",
            .flac => "FLAC",
            .mp3 => "MP3",
            .opus => "OPUS",
            .pcm => "PCM",
            .vorbis => "VORBIS",
            .av1 => "AV1",
            .avc => "AVC",
            .hevc => "HEVC",
            .jpeg2000 => "JPEG2000",
            .mjpeg => "MJPEG",
            .mpeg1 => "MPEG1",
            .mp4_v => "MP4V",
            .mpeg2 => "MPEG2",
            .prores => "PRORES",
            .theora => "THEORA",
            .vfw => "VFW",
            .vp8 => "VP8",
            .vp9 => "VP9",
            .qtrle => "QTRLE",
            .c608 => "C608",
            .c708 => "C708",
            .webvtt => "WEBVTT",
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
