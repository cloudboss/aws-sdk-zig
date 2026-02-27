pub const ScopeStatus = enum {
    succeeded,
    in_progress,
    failed,
    deactivating,
    deactivated,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .in_progress = "IN_PROGRESS",
        .failed = "FAILED",
        .deactivating = "DEACTIVATING",
        .deactivated = "DEACTIVATED",
    };
};
