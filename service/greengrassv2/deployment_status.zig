pub const DeploymentStatus = enum {
    active,
    completed,
    canceled,
    failed,
    inactive,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .completed = "COMPLETED",
        .canceled = "CANCELED",
        .failed = "FAILED",
        .inactive = "INACTIVE",
    };
};
