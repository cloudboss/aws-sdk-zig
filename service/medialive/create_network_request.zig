const aws = @import("aws");

const IpPoolCreateRequest = @import("ip_pool_create_request.zig").IpPoolCreateRequest;
const RouteCreateRequest = @import("route_create_request.zig").RouteCreateRequest;

/// A request to create a Network.
pub const CreateNetworkRequest = struct {
    /// An array of IpPoolCreateRequests that identify a collection of IP addresses
    /// in your network that you want to reserve for use in MediaLive Anywhere.
    /// MediaLiveAnywhere uses these IP addresses for Push inputs (in both Bridge
    /// and NATnetworks) and for output destinations (only in Bridge networks).
    /// EachIpPoolUpdateRequest specifies one CIDR block.
    ip_pools: ?[]const IpPoolCreateRequest = null,

    /// Specify a name that is unique in the AWS account. We recommend that you
    /// assign a name that hints at the type of traffic on the network. Names are
    /// case-sensitive.
    name: ?[]const u8 = null,

    /// An ID that you assign to a create request. This ID ensures idempotency when
    /// creating resources.
    request_id: ?[]const u8 = null,

    /// An array of routes that MediaLive Anywhere needs to know about in order to
    /// route encoding traffic.
    routes: ?[]const RouteCreateRequest = null,

    /// A collection of key-value pairs.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .ip_pools = "IpPools",
        .name = "Name",
        .request_id = "RequestId",
        .routes = "Routes",
        .tags = "Tags",
    };
};
