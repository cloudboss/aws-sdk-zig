pub const BaselineOperationType = enum {
    enable_baseline,
    disable_baseline,
    update_enabled_baseline,
    reset_enabled_baseline,

    pub const json_field_names = .{
        .enable_baseline = "ENABLE_BASELINE",
        .disable_baseline = "DISABLE_BASELINE",
        .update_enabled_baseline = "UPDATE_ENABLED_BASELINE",
        .reset_enabled_baseline = "RESET_ENABLED_BASELINE",
    };
};
