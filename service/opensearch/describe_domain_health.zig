const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainHealth = @import("domain_health.zig").DomainHealth;
const DomainState = @import("domain_state.zig").DomainState;
const EnvironmentInfo = @import("environment_info.zig").EnvironmentInfo;
const MasterNodeStatus = @import("master_node_status.zig").MasterNodeStatus;

pub const DescribeDomainHealthInput = struct {
    /// The name of the domain.
    domain_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
    };
};

pub const DescribeDomainHealthOutput = struct {
    /// The number of active Availability Zones configured for the domain. If the
    /// service is
    /// unable to fetch this information, it will return `NotAvailable`.
    active_availability_zone_count: ?[]const u8 = null,

    /// The number of Availability Zones configured for the domain. If the service
    /// is unable
    /// to fetch this information, it will return `NotAvailable`.
    availability_zone_count: ?[]const u8 = null,

    /// The current health status of your cluster.
    ///
    /// * `Red` - At least one primary shard is not allocated to any
    /// node.
    ///
    /// * `Yellow` - All primary shards are allocated to nodes, but some
    /// replicas aren’t.
    ///
    /// * `Green` - All primary shards and their replicas are allocated to
    /// nodes.
    ///
    /// * `NotAvailable` - Unable to retrieve cluster health.
    cluster_health: ?DomainHealth = null,

    /// The number of data nodes configured for the domain. If the service is unable
    /// to fetch
    /// this information, it will return `NotAvailable`.
    data_node_count: ?[]const u8 = null,

    /// A boolean that indicates if dedicated master nodes are activated for the
    /// domain.
    dedicated_master: ?bool = null,

    /// The current state of the domain.
    ///
    /// * `Processing` - The domain has updates in progress.
    ///
    /// * `Active` - Requested changes have been processed and deployed to
    /// the domain.
    domain_state: ?DomainState = null,

    /// A list of `EnvironmentInfo` for the domain.
    environment_information: ?[]const EnvironmentInfo = null,

    /// The number of nodes that can be elected as a master node. If dedicated
    /// master nodes is
    /// turned on, this value is the number of dedicated master nodes configured for
    /// the domain.
    /// If the service is unable to fetch this information, it will return
    /// `NotAvailable`.
    master_eligible_node_count: ?[]const u8 = null,

    /// Indicates whether the domain has an elected master node.
    ///
    /// * **Available** - The domain has an elected master
    /// node.
    ///
    /// * **UnAvailable** - The master node hasn't yet been
    /// elected, and a quorum to elect a new master node hasn't been reached.
    master_node: ?MasterNodeStatus = null,

    /// The number of standby Availability Zones configured for the domain. If the
    /// service is
    /// unable to fetch this information, it will return `NotAvailable`.
    stand_by_availability_zone_count: ?[]const u8 = null,

    /// The total number of primary and replica shards for the domain.
    total_shards: ?[]const u8 = null,

    /// The total number of primary and replica shards not allocated to any of the
    /// nodes for
    /// the cluster.
    total_un_assigned_shards: ?[]const u8 = null,

    /// The number of warm nodes configured for the domain.
    warm_node_count: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_availability_zone_count = "ActiveAvailabilityZoneCount",
        .availability_zone_count = "AvailabilityZoneCount",
        .cluster_health = "ClusterHealth",
        .data_node_count = "DataNodeCount",
        .dedicated_master = "DedicatedMaster",
        .domain_state = "DomainState",
        .environment_information = "EnvironmentInformation",
        .master_eligible_node_count = "MasterEligibleNodeCount",
        .master_node = "MasterNode",
        .stand_by_availability_zone_count = "StandByAvailabilityZoneCount",
        .total_shards = "TotalShards",
        .total_un_assigned_shards = "TotalUnAssignedShards",
        .warm_node_count = "WarmNodeCount",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDomainHealthInput, options: CallOptions) !DescribeDomainHealthOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDomainHealthInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/opensearch/domain/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/health");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDomainHealthOutput {
    var result: DescribeDomainHealthOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeDomainHealthOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
