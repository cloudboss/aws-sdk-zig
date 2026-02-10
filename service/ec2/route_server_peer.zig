const RouteServerBfdStatus = @import("route_server_bfd_status.zig").RouteServerBfdStatus;
const RouteServerBgpOptions = @import("route_server_bgp_options.zig").RouteServerBgpOptions;
const RouteServerBgpStatus = @import("route_server_bgp_status.zig").RouteServerBgpStatus;
const RouteServerPeerState = @import("route_server_peer_state.zig").RouteServerPeerState;
const Tag = @import("tag.zig").Tag;

/// Describes a BGP peer configuration for a route server endpoint.
///
/// A route server peer is a session between a route server endpoint and the
/// device deployed in Amazon Web Services (such as a firewall appliance or
/// other network security function running on an EC2 instance). The device must
/// meet these requirements:
///
/// * Have an elastic network interface in the VPC
///
/// * Support BGP (Border Gateway Protocol)
///
/// * Can initiate BGP sessions
pub const RouteServerPeer = struct {
    /// The current status of the BFD session with this peer.
    bfd_status: ?RouteServerBfdStatus,

    /// The BGP configuration options for this peer, including ASN (Autonomous
    /// System Number) and BFD (Bidrectional Forwarding Detection) settings.
    bgp_options: ?RouteServerBgpOptions,

    /// The current status of the BGP session with this peer.
    bgp_status: ?RouteServerBgpStatus,

    /// The IP address of the Elastic network interface for the route server
    /// endpoint.
    endpoint_eni_address: ?[]const u8,

    /// The ID of the Elastic network interface for the route server endpoint.
    endpoint_eni_id: ?[]const u8,

    /// The reason for any failure in peer creation or operation.
    failure_reason: ?[]const u8,

    /// The IPv4 address of the peer device.
    peer_address: ?[]const u8,

    /// The ID of the route server endpoint associated with this peer.
    route_server_endpoint_id: ?[]const u8,

    /// The ID of the route server associated with this peer.
    route_server_id: ?[]const u8,

    /// The unique identifier of the route server peer.
    route_server_peer_id: ?[]const u8,

    /// The current state of the route server peer.
    state: ?RouteServerPeerState,

    /// The ID of the subnet containing the route server peer.
    subnet_id: ?[]const u8,

    /// Any tags assigned to the route server peer.
    tags: ?[]const Tag,

    /// The ID of the VPC containing the route server peer.
    vpc_id: ?[]const u8,
};
