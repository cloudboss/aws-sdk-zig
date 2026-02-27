pub const MinimumThroughputBillingCommitmentOutputStatus = enum {
    enabled,
    disabled,
    enabled_until_earliest_allowed_end,

    pub const json_field_names = .{
        .enabled = "ENABLED",
        .disabled = "DISABLED",
        .enabled_until_earliest_allowed_end = "ENABLED_UNTIL_EARLIEST_ALLOWED_END",
    };
};
