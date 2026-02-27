pub const ConflictExceptionReason = enum {
    conflict_exception,
    concurrent_modification,
    resource_already_exists,
    resource_in_use,
    status_conflict,

    pub const json_field_names = .{
        .conflict_exception = "CONFLICT_EXCEPTION",
        .concurrent_modification = "CONCURRENT_MODIFICATION",
        .resource_already_exists = "RESOURCE_ALREADY_EXISTS",
        .resource_in_use = "RESOURCE_IN_USE",
        .status_conflict = "STATUS_CONFLICT",
    };
};
