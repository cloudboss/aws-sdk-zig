/// Describes the destination of a network route.
pub const NetworkRouteDestination = struct {
    /// The ID of a core network attachment.
    core_network_attachment_id: ?[]const u8 = null,

    /// The edge location for the network destination.
    edge_location: ?[]const u8 = null,

    /// The network function group name associated with the destination.
    network_function_group_name: ?[]const u8 = null,

    /// The ID of the resource.
    resource_id: ?[]const u8 = null,

    /// The resource type.
    resource_type: ?[]const u8 = null,

    /// The name of the segment.
    segment_name: ?[]const u8 = null,

    /// The ID of the transit gateway attachment.
    transit_gateway_attachment_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .core_network_attachment_id = "CoreNetworkAttachmentId",
        .edge_location = "EdgeLocation",
        .network_function_group_name = "NetworkFunctionGroupName",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
        .segment_name = "SegmentName",
        .transit_gateway_attachment_id = "TransitGatewayAttachmentId",
    };
};
