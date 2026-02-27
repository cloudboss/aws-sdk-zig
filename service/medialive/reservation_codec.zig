/// Codec, 'MPEG2', 'AVC', 'HEVC', 'AUDIO', 'LINK', or 'AV1'
pub const ReservationCodec = enum {
    mpeg2,
    avc,
    hevc,
    audio,
    link,
    av1,

    pub const json_field_names = .{
        .mpeg2 = "MPEG2",
        .avc = "AVC",
        .hevc = "HEVC",
        .audio = "AUDIO",
        .link = "LINK",
        .av1 = "AV1",
    };
};
