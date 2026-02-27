pub const XksProxyConnectivityType = enum {
    public_endpoint,
    vpc_endpoint_service,

    pub const json_field_names = .{
        .public_endpoint = "PUBLIC_ENDPOINT",
        .vpc_endpoint_service = "VPC_ENDPOINT_SERVICE",
    };
};
