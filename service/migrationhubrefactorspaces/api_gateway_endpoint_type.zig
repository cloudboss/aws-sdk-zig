pub const ApiGatewayEndpointType = enum {
    regional,
    private,

    pub const json_field_names = .{
        .regional = "REGIONAL",
        .private = "PRIVATE",
    };
};
