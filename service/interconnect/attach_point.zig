/// Identifies an attach point to use with a Connection.
pub const AttachPoint = union(enum) {
    /// Identifies an attach point by full ARN.
    arn: ?[]const u8,
    /// Identifies an DirectConnect Gateway attach point by DirectConnectGatewayID.
    direct_connect_gateway: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .direct_connect_gateway = "directConnectGateway",
    };
};
