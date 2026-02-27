/// H265 Rate Control Mode
pub const H265RateControlMode = enum {
    cbr,
    multiplex,
    qvbr,

    pub const json_field_names = .{
        .cbr = "CBR",
        .multiplex = "MULTIPLEX",
        .qvbr = "QVBR",
    };
};
