pub const FlowStatus = enum {
    failed,
    prepared,
    preparing,
    not_prepared,

    pub const json_field_names = .{
        .failed = "FAILED",
        .prepared = "PREPARED",
        .preparing = "PREPARING",
        .not_prepared = "NOT_PREPARED",
    };
};
