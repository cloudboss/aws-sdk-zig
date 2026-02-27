/// Av1 Rate Control Mode
pub const Av1RateControlMode = enum {
    cbr,
    qvbr,

    pub const json_field_names = .{
        .cbr = "CBR",
        .qvbr = "QVBR",
    };
};
