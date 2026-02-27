/// Specify whether your input audio has an additional center rear surround
/// channel matrix encoded into your left and right surround channels.
pub const Eac3AtmosSurroundExMode = enum {
    not_indicated,
    enabled,
    disabled,

    pub const json_field_names = .{
        .not_indicated = "NOT_INDICATED",
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
