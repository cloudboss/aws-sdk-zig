const TransitGatewayPropagationState = @import("transit_gateway_propagation_state.zig").TransitGatewayPropagationState;

/// Describes a propagation route table.
pub const TransitGatewayAttachmentPropagation = struct {
    /// The state of the propagation route table.
    state: ?TransitGatewayPropagationState = null,

    /// The ID of the propagation route table.
    transit_gateway_route_table_id: ?[]const u8 = null,
};
