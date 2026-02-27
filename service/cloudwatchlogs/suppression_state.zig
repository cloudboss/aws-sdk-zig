pub const SuppressionState = enum {
    suppressed,
    unsuppressed,

    pub const json_field_names = .{
        .suppressed = "SUPPRESSED",
        .unsuppressed = "UNSUPPRESSED",
    };
};
