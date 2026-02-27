/// Entropy encoding mode. Use CABAC (must be in Main or High profile) or CAVLC.
pub const H264EntropyEncoding = enum {
    cabac,
    cavlc,

    pub const json_field_names = .{
        .cabac = "CABAC",
        .cavlc = "CAVLC",
    };
};
