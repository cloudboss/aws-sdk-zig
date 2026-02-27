/// 'With AV1 outputs, for rate control mode, MediaConvert supports only
/// quality-defined variable bitrate (QVBR). You can''t use CBR or VBR.'
pub const Av1RateControlMode = enum {
    qvbr,

    pub const json_field_names = .{
        .qvbr = "QVBR",
    };
};
