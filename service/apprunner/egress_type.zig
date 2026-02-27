pub const EgressType = enum {
    default,
    vpc,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .vpc = "VPC",
    };
};
