/// Specify whether the service encodes this MP3 audio output with a constant
/// bitrate (CBR) or a variable bitrate (VBR).
pub const Mp3RateControlMode = enum {
    cbr,
    vbr,

    pub const json_field_names = .{
        .cbr = "CBR",
        .vbr = "VBR",
    };
};
