pub const FeatureEnableStatus = enum {
    enabled,
    disabled,
    not_allowed,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .not_allowed = "NOT_ALLOWED",
    };
};
