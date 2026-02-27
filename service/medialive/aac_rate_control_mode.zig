/// Aac Rate Control Mode
pub const AacRateControlMode = enum {
    cbr,
    vbr,

    pub const json_field_names = .{
        .cbr = "CBR",
        .vbr = "VBR",
    };
};
