pub const CodeInterpreterNetworkMode = enum {
    public,
    sandbox,
    vpc,

    pub const json_field_names = .{
        .public = "PUBLIC",
        .sandbox = "SANDBOX",
        .vpc = "VPC",
    };
};
