pub const WorkspaceImageState = enum {
    available,
    pending,
    @"error",

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .pending = "PENDING",
        .@"error" = "ERROR",
    };
};
