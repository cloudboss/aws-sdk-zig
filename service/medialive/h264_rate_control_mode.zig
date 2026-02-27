/// H264 Rate Control Mode
pub const H264RateControlMode = enum {
    cbr,
    multiplex,
    qvbr,
    vbr,

    pub const json_field_names = .{
        .cbr = "CBR",
        .multiplex = "MULTIPLEX",
        .qvbr = "QVBR",
        .vbr = "VBR",
    };
};
