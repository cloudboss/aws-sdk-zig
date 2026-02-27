pub const WorkspaceBundleState = enum {
    available,
    pending,
    @"error",

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .pending = "PENDING",
        .@"error" = "ERROR",
    };
};
