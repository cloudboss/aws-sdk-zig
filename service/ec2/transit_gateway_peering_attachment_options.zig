const DynamicRoutingValue = @import("dynamic_routing_value.zig").DynamicRoutingValue;

/// Describes dynamic routing for the transit gateway peering attachment.
pub const TransitGatewayPeeringAttachmentOptions = struct {
    /// Describes whether dynamic routing is enabled or disabled for the transit
    /// gateway peering attachment.
    dynamic_routing: ?DynamicRoutingValue = null,
};
