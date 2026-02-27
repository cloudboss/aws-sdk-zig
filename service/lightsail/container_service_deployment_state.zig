pub const ContainerServiceDeploymentState = enum {
    activating,
    active,
    inactive,
    failed,

    pub const json_field_names = .{
        .activating = "ACTIVATING",
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .failed = "FAILED",
    };
};
