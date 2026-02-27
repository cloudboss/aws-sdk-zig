pub const EndpointType = enum {
    public,
    vpc,
    vpc_endpoint,

    pub const json_field_names = .{
        .public = "PUBLIC",
        .vpc = "VPC",
        .vpc_endpoint = "VPC_ENDPOINT",
    };
};
