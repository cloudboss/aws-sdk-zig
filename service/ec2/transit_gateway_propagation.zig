const TransitGatewayAttachmentResourceType = @import("transit_gateway_attachment_resource_type.zig").TransitGatewayAttachmentResourceType;
const TransitGatewayPropagationState = @import("transit_gateway_propagation_state.zig").TransitGatewayPropagationState;

/// Describes route propagation.
pub const TransitGatewayPropagation = struct {
    /// The ID of the resource.
    resource_id: ?[]const u8,

    /// The resource type. Note that the `tgw-peering` resource type has been
    /// deprecated.
    resource_type: ?TransitGatewayAttachmentResourceType,

    /// The state.
    state: ?TransitGatewayPropagationState,

    /// The ID of the attachment.
    transit_gateway_attachment_id: ?[]const u8,

    /// The ID of the transit gateway route table announcement.
    transit_gateway_route_table_announcement_id: ?[]const u8,

    /// The ID of the transit gateway route table.
    transit_gateway_route_table_id: ?[]const u8,
};
