/// Audio Only Hls Segment Type
pub const AudioOnlyHlsSegmentType = enum {
    aac,
    fmp4,

    pub const json_field_names = .{
        .aac = "AAC",
        .fmp4 = "FMP4",
    };
};
