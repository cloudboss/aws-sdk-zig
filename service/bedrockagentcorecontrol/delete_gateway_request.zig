pub const DeleteGatewayRequest = struct {
    /// The identifier of the gateway to delete.
    gateway_identifier: []const u8,

    pub const json_field_names = .{
        .gateway_identifier = "gatewayIdentifier",
    };
};
