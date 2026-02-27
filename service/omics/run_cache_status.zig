pub const RunCacheStatus = enum {
    active,
    deleted,
    failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .deleted = "DELETED",
        .failed = "FAILED",
    };
};
