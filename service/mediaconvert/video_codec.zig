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
};
