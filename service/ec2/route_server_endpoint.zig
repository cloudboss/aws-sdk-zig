const RouteServerEndpointState = @import("route_server_endpoint_state.zig").RouteServerEndpointState;
const Tag = @import("tag.zig").Tag;

/// Describes a route server endpoint and its properties.
///
/// A route server endpoint is an Amazon Web Services-managed component inside a
/// subnet that facilitates [BGP (Border Gateway
/// Protocol)](https://en.wikipedia.org/wiki/Border_Gateway_Protocol)
/// connections between your route server and your BGP peers.
pub const RouteServerEndpoint = struct {
    /// The IP address of the Elastic network interface for the endpoint.
    eni_address: ?[]const u8,

    /// The ID of the Elastic network interface for the endpoint.
    eni_id: ?[]const u8,

    /// The reason for any failure in endpoint creation or operation.
    failure_reason: ?[]const u8,

    /// The unique identifier of the route server endpoint.
    route_server_endpoint_id: ?[]const u8,

    /// The ID of the route server associated with this endpoint.
    route_server_id: ?[]const u8,

    /// The current state of the route server endpoint.
    state: ?RouteServerEndpointState,

    /// The ID of the subnet to place the route server endpoint into.
    subnet_id: ?[]const u8,

    /// Any tags assigned to the route server endpoint.
    tags: ?[]const Tag,

    /// The ID of the VPC containing the endpoint.
    vpc_id: ?[]const u8,
};
