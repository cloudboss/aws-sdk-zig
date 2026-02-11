pub const GlobalTableSettingsReplicationMode = enum {
    enabled,
    disabled,
    enabled_with_overrides,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .enabled_with_overrides = "ENABLED_WITH_OVERRIDES",
    };
};
