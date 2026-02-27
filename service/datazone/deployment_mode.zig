pub const DeploymentMode = enum {
    on_create,
    on_demand,

    pub const json_field_names = .{
        .on_create = "ON_CREATE",
        .on_demand = "ON_DEMAND",
    };
};
