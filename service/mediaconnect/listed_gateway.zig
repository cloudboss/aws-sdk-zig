const GatewayState = @import("gateway_state.zig").GatewayState;

/// A summary of a gateway, including its name, ARN, and status.
pub const ListedGateway = struct {
    /// The Amazon Resource Name (ARN) of the gateway.
    gateway_arn: []const u8,

    /// The status of the gateway.
    gateway_state: GatewayState,

    /// The name of the gateway.
    name: []const u8,

    pub const json_field_names = .{
        .gateway_arn = "GatewayArn",
        .gateway_state = "GatewayState",
        .name = "Name",
    };
};
