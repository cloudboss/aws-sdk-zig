pub const OntapDeploymentType = enum {
    multi_az_1,
    single_az_1,
    single_az_2,
    multi_az_2,

    pub const json_field_names = .{
        .multi_az_1 = "MULTI_AZ_1",
        .single_az_1 = "SINGLE_AZ_1",
        .single_az_2 = "SINGLE_AZ_2",
        .multi_az_2 = "MULTI_AZ_2",
    };
};
