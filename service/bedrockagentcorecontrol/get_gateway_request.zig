pub const GetGatewayRequest = struct {
    /// The identifier of the gateway to retrieve.
    gateway_identifier: []const u8,

    pub const json_field_names = .{
        .gateway_identifier = "gatewayIdentifier",
    };
};
