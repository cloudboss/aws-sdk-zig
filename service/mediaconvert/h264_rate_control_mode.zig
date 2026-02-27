/// Use this setting to specify whether this output has a variable bitrate
/// (VBR), constant bitrate (CBR) or quality-defined variable bitrate (QVBR).
pub const H264RateControlMode = enum {
    vbr,
    cbr,
    qvbr,

    pub const json_field_names = .{
        .vbr = "VBR",
        .cbr = "CBR",
        .qvbr = "QVBR",
    };
};
