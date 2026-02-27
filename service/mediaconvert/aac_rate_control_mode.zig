/// Specify the AAC rate control mode. For a constant bitrate: Choose CBR. Your
/// AAC output bitrate will be equal to the value that you choose for Bitrate.
/// For a variable bitrate: Choose VBR. Your AAC output bitrate will vary
/// according to your audio content and the value that you choose for Bitrate
/// quality.
pub const AacRateControlMode = enum {
    cbr,
    vbr,

    pub const json_field_names = .{
        .cbr = "CBR",
        .vbr = "VBR",
    };
};
