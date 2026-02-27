pub const LustreDeploymentType = enum {
    scratch_1,
    scratch_2,
    persistent_1,
    persistent_2,

    pub const json_field_names = .{
        .scratch_1 = "SCRATCH_1",
        .scratch_2 = "SCRATCH_2",
        .persistent_1 = "PERSISTENT_1",
        .persistent_2 = "PERSISTENT_2",
    };
};
