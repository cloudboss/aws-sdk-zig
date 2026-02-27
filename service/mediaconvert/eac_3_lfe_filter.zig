/// Applies a 120Hz lowpass filter to the LFE channel prior to encoding. Only
/// valid with 3_2_LFE coding mode.
pub const Eac3LfeFilter = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
