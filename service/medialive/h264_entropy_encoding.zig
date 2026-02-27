/// H264 Entropy Encoding
pub const H264EntropyEncoding = enum {
    cabac,
    cavlc,

    pub const json_field_names = .{
        .cabac = "CABAC",
        .cavlc = "CAVLC",
    };
};
