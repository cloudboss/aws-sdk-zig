pub const ApplicationDeploymentLifecycle = enum {
    deploying,
    deployed,

    pub const json_field_names = .{
        .deploying = "DEPLOYING",
        .deployed = "DEPLOYED",
    };
};
