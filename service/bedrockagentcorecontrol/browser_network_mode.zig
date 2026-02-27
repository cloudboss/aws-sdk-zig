pub const BrowserNetworkMode = enum {
    public,
    vpc,

    pub const json_field_names = .{
        .public = "PUBLIC",
        .vpc = "VPC",
    };
};
