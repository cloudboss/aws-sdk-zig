const CustomerGatewayAssociationState = @import("customer_gateway_association_state.zig").CustomerGatewayAssociationState;

/// Describes the association between a customer gateway, a device, and a link.
pub const CustomerGatewayAssociation = struct {
    /// The Amazon Resource Name (ARN) of the customer gateway.
    customer_gateway_arn: ?[]const u8,

    /// The ID of the device.
    device_id: ?[]const u8,

    /// The ID of the global network.
    global_network_id: ?[]const u8,

    /// The ID of the link.
    link_id: ?[]const u8,

    /// The association state.
    state: ?CustomerGatewayAssociationState,

    pub const json_field_names = .{
        .customer_gateway_arn = "CustomerGatewayArn",
        .device_id = "DeviceId",
        .global_network_id = "GlobalNetworkId",
        .link_id = "LinkId",
        .state = "State",
    };
};
