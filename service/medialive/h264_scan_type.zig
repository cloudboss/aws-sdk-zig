/// H264 Scan Type
pub const H264ScanType = enum {
    interlaced,
    progressive,

    pub const json_field_names = .{
        .interlaced = "INTERLACED",
        .progressive = "PROGRESSIVE",
    };
};
