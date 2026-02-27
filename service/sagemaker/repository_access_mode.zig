pub const RepositoryAccessMode = enum {
    platform,
    vpc,

    pub const json_field_names = .{
        .platform = "PLATFORM",
        .vpc = "VPC",
    };
};
