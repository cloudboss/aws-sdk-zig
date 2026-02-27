pub const DeploymentUpdateType = enum {
    none,
    current_version,
    minor_version,
    major_version,

    pub const json_field_names = .{
        .none = "NONE",
        .current_version = "CURRENT_VERSION",
        .minor_version = "MINOR_VERSION",
        .major_version = "MAJOR_VERSION",
    };
};
