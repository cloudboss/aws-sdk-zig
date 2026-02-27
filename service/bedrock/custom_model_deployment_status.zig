pub const CustomModelDeploymentStatus = enum {
    creating,
    active,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .failed = "FAILED",
    };
};
