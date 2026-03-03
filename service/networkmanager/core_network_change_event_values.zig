const RoutingPolicyAssociationDetail = @import("routing_policy_association_detail.zig").RoutingPolicyAssociationDetail;
const RoutingPolicyDirection = @import("routing_policy_direction.zig").RoutingPolicyDirection;

/// Describes a core network change event.
pub const CoreNetworkChangeEventValues = struct {
    /// The ID of the attachment if the change event is associated with an
    /// attachment.
    attachment_id: ?[]const u8 = null,

    /// For a `STATIC_ROUTE` event, this is the IP address.
    cidr: ?[]const u8 = null,

    /// The edge location for the core network change event.
    edge_location: ?[]const u8 = null,

    /// The changed network function group name.
    network_function_group_name: ?[]const u8 = null,

    /// The edge location of the peer in a core network change event.
    peer_edge_location: ?[]const u8 = null,

    /// The names of the routing policies and other association details in the core
    /// network change values.
    routing_policy_association_details: ?[]const RoutingPolicyAssociationDetail = null,

    /// The routing policy direction (inbound/outbound) in a core network change
    /// event.
    routing_policy_direction: ?RoutingPolicyDirection = null,

    /// The segment name if the change event is associated with a segment.
    segment_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .attachment_id = "AttachmentId",
        .cidr = "Cidr",
        .edge_location = "EdgeLocation",
        .network_function_group_name = "NetworkFunctionGroupName",
        .peer_edge_location = "PeerEdgeLocation",
        .routing_policy_association_details = "RoutingPolicyAssociationDetails",
        .routing_policy_direction = "RoutingPolicyDirection",
        .segment_name = "SegmentName",
    };
};
