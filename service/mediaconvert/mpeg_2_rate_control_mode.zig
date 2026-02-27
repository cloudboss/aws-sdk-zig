/// Use Rate control mode to specify whether the bitrate is variable (vbr) or
/// constant (cbr).
pub const Mpeg2RateControlMode = enum {
    vbr,
    cbr,

    pub const json_field_names = .{
        .vbr = "VBR",
        .cbr = "CBR",
    };
};
