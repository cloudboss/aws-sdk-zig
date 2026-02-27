/// Information about the next hop for a route in the core network.
pub const RoutingInformationNextHop = struct {
    /// The ID of the core network attachment for the next hop.
    core_network_attachment_id: ?[]const u8,

    /// The edge location for the next hop.
    edge_location: ?[]const u8,

    /// The IP address of the next hop.
    ip_address: ?[]const u8,

    /// The ID of the resource for the next hop.
    resource_id: ?[]const u8,

    /// The type of resource for the next hop.
    resource_type: ?[]const u8,

    /// The name of the segment for the next hop.
    segment_name: ?[]const u8,

    pub const json_field_names = .{
        .core_network_attachment_id = "CoreNetworkAttachmentId",
        .edge_location = "EdgeLocation",
        .ip_address = "IpAddress",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
        .segment_name = "SegmentName",
    };
};
