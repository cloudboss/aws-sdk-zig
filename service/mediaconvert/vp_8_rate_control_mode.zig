/// With the VP8 codec, you can use only the variable bitrate (VBR) rate control
/// mode.
pub const Vp8RateControlMode = enum {
    vbr,

    pub const json_field_names = .{
        .vbr = "VBR",
    };
};
