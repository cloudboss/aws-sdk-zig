const RoutingPolicyAssociationDetail = @import("routing_policy_association_detail.zig").RoutingPolicyAssociationDetail;
const RoutingPolicyDirection = @import("routing_policy_direction.zig").RoutingPolicyDirection;
const ServiceInsertionAction = @import("service_insertion_action.zig").ServiceInsertionAction;

/// Describes a core network change.
pub const CoreNetworkChangeValues = struct {
    /// The ASN of a core network.
    asn: ?i64,

    /// The attachment identifier in the core network change values.
    attachment_id: ?[]const u8,

    /// The IP addresses used for a core network.
    cidr: ?[]const u8,

    /// The ID of the destination.
    destination_identifier: ?[]const u8,

    /// Indicates whether public DNS support is supported. The default is `true`.
    dns_support: bool = false,

    /// The Regions where edges are located in a core network.
    edge_locations: ?[]const []const u8,

    /// The inside IP addresses used for core network change values.
    inside_cidr_blocks: ?[]const []const u8,

    /// The network function group name if the change event is associated with a
    /// network function group.
    network_function_group_name: ?[]const u8,

    /// The edge locations of peers in the core network change values.
    peer_edge_locations: ?[]const []const u8,

    /// The routing policy configuration in the core network change values.
    routing_policy: ?[]const u8,

    /// The names of the routing policies and other association details in the core
    /// network change values.
    routing_policy_association_details: ?[]const RoutingPolicyAssociationDetail,

    /// The routing policy direction (inbound/outbound) in a core network change
    /// event.
    routing_policy_direction: ?RoutingPolicyDirection,

    /// Indicates whether security group referencing is enabled for the core
    /// network.
    security_group_referencing_support: bool = false,

    /// The names of the segments in a core network.
    segment_name: ?[]const u8,

    /// Describes the service insertion action.
    service_insertion_actions: ?[]const ServiceInsertionAction,

    /// The shared segments for a core network change value.
    shared_segments: ?[]const []const u8,

    /// Indicates whether Equal Cost Multipath (ECMP) is enabled for the core
    /// network.
    vpn_ecmp_support: bool = false,

    pub const json_field_names = .{
        .asn = "Asn",
        .attachment_id = "AttachmentId",
        .cidr = "Cidr",
        .destination_identifier = "DestinationIdentifier",
        .dns_support = "DnsSupport",
        .edge_locations = "EdgeLocations",
        .inside_cidr_blocks = "InsideCidrBlocks",
        .network_function_group_name = "NetworkFunctionGroupName",
        .peer_edge_locations = "PeerEdgeLocations",
        .routing_policy = "RoutingPolicy",
        .routing_policy_association_details = "RoutingPolicyAssociationDetails",
        .routing_policy_direction = "RoutingPolicyDirection",
        .security_group_referencing_support = "SecurityGroupReferencingSupport",
        .segment_name = "SegmentName",
        .service_insertion_actions = "ServiceInsertionActions",
        .shared_segments = "SharedSegments",
        .vpn_ecmp_support = "VpnEcmpSupport",
    };
};
