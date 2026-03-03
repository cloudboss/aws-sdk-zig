const std = @import("std");

/// Type of video codec
pub const VideoCodec = enum {
    av1,
    avc_intra,
    frame_capture,
    gif,
    h_264,
    h_265,
    mpeg2,
    passthrough,
    prores,
    uncompressed,
    vc3,
    vp8,
    vp9,
    xavc,

    pub const json_field_names = .{
        .av1 = "AV1",
        .avc_intra = "AVC_INTRA",
        .frame_capture = "FRAME_CAPTURE",
        .gif = "GIF",
        .h_264 = "H_264",
        .h_265 = "H_265",
        .mpeg2 = "MPEG2",
        .passthrough = "PASSTHROUGH",
        .prores = "PRORES",
        .uncompressed = "UNCOMPRESSED",
        .vc3 = "VC3",
        .vp8 = "VP8",
        .vp9 = "VP9",
        .xavc = "XAVC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .av1 => "AV1",
            .avc_intra => "AVC_INTRA",
            .frame_capture => "FRAME_CAPTURE",
            .gif => "GIF",
            .h_264 => "H_264",
            .h_265 => "H_265",
            .mpeg2 => "MPEG2",
            .passthrough => "PASSTHROUGH",
            .prores => "PRORES",
            .uncompressed => "UNCOMPRESSED",
            .vc3 => "VC3",
            .vp8 => "VP8",
            .vp9 => "VP9",
            .xavc => "XAVC",
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
