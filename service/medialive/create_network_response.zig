const IpPool = @import("ip_pool.zig").IpPool;
const Route = @import("route.zig").Route;
const NetworkState = @import("network_state.zig").NetworkState;

/// Placeholder documentation for CreateNetworkResponse
pub const CreateNetworkResponse = struct {
    /// The ARN of this Network. It is automatically assigned when the Network is
    /// created.
    arn: ?[]const u8 = null,

    associated_cluster_ids: ?[]const []const u8 = null,

    /// The ID of the Network. Unique in the AWS account. The ID is the resource-id
    /// portion of the ARN.
    id: ?[]const u8 = null,

    /// An array of IpPools in your organization's network that identify a
    /// collection of IP addresses in this network that are reserved for use in
    /// MediaLive Anywhere. MediaLive Anywhere uses these IP addresses for Push
    /// inputs (in both Bridge and NAT networks) and for output destinations (only
    /// in Bridge networks). Each IpPool specifies one CIDR block.
    ip_pools: ?[]const IpPool = null,

    /// The name that you specified for the Network.
    name: ?[]const u8 = null,

    /// An array of routes that MediaLive Anywhere needs to know about in order to
    /// route encoding traffic.
    routes: ?[]const Route = null,

    /// The current state of the Network. Only MediaLive Anywhere can change the
    /// state.
    state: ?NetworkState = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .associated_cluster_ids = "AssociatedClusterIds",
        .id = "Id",
        .ip_pools = "IpPools",
        .name = "Name",
        .routes = "Routes",
        .state = "State",
    };
};
