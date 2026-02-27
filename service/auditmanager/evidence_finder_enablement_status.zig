pub const EvidenceFinderEnablementStatus = enum {
    enabled,
    disabled,
    enable_in_progress,
    disable_in_progress,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .enable_in_progress = "ENABLE_IN_PROGRESS",
        .disable_in_progress = "DISABLE_IN_PROGRESS",
    };
};
