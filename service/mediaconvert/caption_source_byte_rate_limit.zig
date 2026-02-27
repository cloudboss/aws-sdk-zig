/// Choose whether to limit the byte rate at which your SCC input captions are
/// inserted into your output. To not limit the caption rate: We recommend that
/// you keep the default value, Disabled. MediaConvert inserts captions in your
/// output according to the byte rates listed in the EIA-608 specification,
/// typically 2 or 3 caption bytes per frame depending on your output frame
/// rate. To limit your output caption rate: Choose Enabled. Choose this option
/// if your downstream systems require a maximum of 2 caption bytes per frame.
/// Note that this setting has no effect when your output frame rate is 30 or
/// 60.
pub const CaptionSourceByteRateLimit = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
