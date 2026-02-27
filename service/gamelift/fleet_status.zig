pub const FleetStatus = enum {
    new,
    downloading,
    validating,
    building,
    activating,
    active,
    deleting,
    @"error",
    terminated,
    not_found,

    pub const json_field_names = .{
        .new = "NEW",
        .downloading = "DOWNLOADING",
        .validating = "VALIDATING",
        .building = "BUILDING",
        .activating = "ACTIVATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .@"error" = "ERROR",
        .terminated = "TERMINATED",
        .not_found = "NOT_FOUND",
    };
};
