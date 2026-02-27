pub const WorkSpaceApplicationState = enum {
    pending,
    @"error",
    available,
    uninstall_only,

    pub const json_field_names = .{
        .pending = "PENDING",
        .@"error" = "ERROR",
        .available = "AVAILABLE",
        .uninstall_only = "UNINSTALL_ONLY",
    };
};
