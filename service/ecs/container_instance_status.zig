pub const ContainerInstanceStatus = enum {
    active,
    draining,
    registering,
    deregistering,
    registration_failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .draining = "DRAINING",
        .registering = "REGISTERING",
        .deregistering = "DEREGISTERING",
        .registration_failed = "REGISTRATION_FAILED",
    };
};
