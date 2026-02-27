/// codec in increasing order of complexity
pub const InputCodec = enum {
    mpeg2,
    avc,
    hevc,

    pub const json_field_names = .{
        .mpeg2 = "MPEG2",
        .avc = "AVC",
        .hevc = "HEVC",
    };
};
