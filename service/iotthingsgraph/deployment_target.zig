pub const DeploymentTarget = enum {
    greengrass,
    cloud,

    pub const json_field_names = .{
        .greengrass = "GREENGRASS",
        .cloud = "CLOUD",
    };
};
