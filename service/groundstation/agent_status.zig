pub const AgentStatus = enum {
    success,
    failed,
    active,
    inactive,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .failed = "FAILED",
        .active = "ACTIVE",
        .inactive = "INACTIVE",
    };
};
