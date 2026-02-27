pub const PositioningConfigStatus = enum {
    enabled,
    disabled,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .disabled = "Disabled",
    };
};
