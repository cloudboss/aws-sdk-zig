pub const AppNetworkAccessType = enum {
    public_internet_only,
    vpc_only,

    pub const json_field_names = .{
        .public_internet_only = "PublicInternetOnly",
        .vpc_only = "VpcOnly",
    };
};
