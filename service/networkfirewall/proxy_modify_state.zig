pub const ProxyModifyState = enum {
    modifying,
    completed,
    failed,

    pub const json_field_names = .{
        .modifying = "MODIFYING",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
