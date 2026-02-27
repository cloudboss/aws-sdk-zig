/// The status of the configuration for retrieving occurrences of sensitive data
/// reported by findings. Valid values are:
pub const RevealStatus = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
