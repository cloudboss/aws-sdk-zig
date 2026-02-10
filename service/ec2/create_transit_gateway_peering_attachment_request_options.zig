const DynamicRoutingValue = @import("dynamic_routing_value.zig").DynamicRoutingValue;

/// Describes whether dynamic routing is enabled or disabled for the transit
/// gateway peering request.
pub const CreateTransitGatewayPeeringAttachmentRequestOptions = struct {
    /// Indicates whether dynamic routing is enabled or disabled.
    dynamic_routing: ?DynamicRoutingValue,
};
