/// H265 Scan Type
pub const H265ScanType = enum {
    interlaced,
    progressive,

    pub const json_field_names = .{
        .interlaced = "INTERLACED",
        .progressive = "PROGRESSIVE",
    };
};
