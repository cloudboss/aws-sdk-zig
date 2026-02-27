const DirectConnectGatewayState = @import("direct_connect_gateway_state.zig").DirectConnectGatewayState;
const Tag = @import("tag.zig").Tag;

/// Information about a Direct Connect gateway, which enables you to connect
/// virtual interfaces and virtual private gateway or transit gateways.
pub const DirectConnectGateway = struct {
    /// The autonomous system number (AS) for the Amazon side of the connection.
    amazon_side_asn: ?i64,

    /// The ID of the Direct Connect gateway.
    direct_connect_gateway_id: ?[]const u8,

    /// The name of the Direct Connect gateway.
    direct_connect_gateway_name: ?[]const u8,

    /// The state of the Direct Connect gateway. The following are the possible
    /// values:
    ///
    /// * `pending`: The initial state after calling CreateDirectConnectGateway.
    ///
    /// * `available`: The Direct Connect gateway is ready for use.
    ///
    /// * `deleting`: The initial state after calling DeleteDirectConnectGateway.
    ///
    /// * `deleted`: The Direct Connect gateway is deleted and cannot pass traffic.
    direct_connect_gateway_state: ?DirectConnectGatewayState,

    /// The ID of the Amazon Web Services account that owns the Direct Connect
    /// gateway.
    owner_account: ?[]const u8,

    /// The error message if the state of an object failed to advance.
    state_change_error: ?[]const u8,

    /// Information about a tag.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .amazon_side_asn = "amazonSideAsn",
        .direct_connect_gateway_id = "directConnectGatewayId",
        .direct_connect_gateway_name = "directConnectGatewayName",
        .direct_connect_gateway_state = "directConnectGatewayState",
        .owner_account = "ownerAccount",
        .state_change_error = "stateChangeError",
        .tags = "tags",
    };
};
