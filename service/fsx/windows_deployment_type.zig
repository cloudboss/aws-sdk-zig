pub const WindowsDeploymentType = enum {
    multi_az_1,
    single_az_1,
    single_az_2,

    pub const json_field_names = .{
        .multi_az_1 = "MULTI_AZ_1",
        .single_az_1 = "SINGLE_AZ_1",
        .single_az_2 = "SINGLE_AZ_2",
    };
};
