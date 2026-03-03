const TransitGatewayRegistrationStateReason = @import("transit_gateway_registration_state_reason.zig").TransitGatewayRegistrationStateReason;

/// Describes the registration of a transit gateway to a global network.
pub const TransitGatewayRegistration = struct {
    /// The ID of the global network.
    global_network_id: ?[]const u8 = null,

    /// The state of the transit gateway registration.
    state: ?TransitGatewayRegistrationStateReason = null,

    /// The Amazon Resource Name (ARN) of the transit gateway.
    transit_gateway_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .global_network_id = "GlobalNetworkId",
        .state = "State",
        .transit_gateway_arn = "TransitGatewayArn",
    };
};
