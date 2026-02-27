/// Ebu Tt DFill Line Gap Control
pub const EbuTtDFillLineGapControl = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
