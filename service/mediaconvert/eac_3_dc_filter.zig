/// Activates a DC highpass filter for all input channels.
pub const Eac3DcFilter = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
    };
};
