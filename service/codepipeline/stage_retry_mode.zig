pub const StageRetryMode = enum {
    failed_actions,
    all_actions,

    pub const json_field_names = .{
        .failed_actions = "FAILED_ACTIONS",
        .all_actions = "ALL_ACTIONS",
    };
};
