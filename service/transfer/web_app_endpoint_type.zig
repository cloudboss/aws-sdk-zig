pub const WebAppEndpointType = enum {
    public,
    vpc,

    pub const json_field_names = .{
        .public = "PUBLIC",
        .vpc = "VPC",
    };
};
