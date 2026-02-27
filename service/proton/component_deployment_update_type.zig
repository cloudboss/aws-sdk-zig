pub const ComponentDeploymentUpdateType = enum {
    none,
    current_version,

    pub const json_field_names = .{
        .none = "NONE",
        .current_version = "CURRENT_VERSION",
    };
};
