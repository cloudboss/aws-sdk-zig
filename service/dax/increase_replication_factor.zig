const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Cluster = @import("cluster.zig").Cluster;

pub const IncreaseReplicationFactorInput = struct {
    /// The Availability Zones (AZs) in which the cluster nodes will be created. All
    /// nodes
    /// belonging to the cluster are placed in these Availability Zones. Use this
    /// parameter if
    /// you want to distribute the nodes across multiple AZs.
    availability_zones: ?[]const []const u8 = null,

    /// The name of the DAX cluster that will receive additional nodes.
    cluster_name: []const u8,

    /// The new number of nodes for the DAX cluster.
    new_replication_factor: ?i32 = null,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
        .cluster_name = "ClusterName",
        .new_replication_factor = "NewReplicationFactor",
    };
};

pub const IncreaseReplicationFactorOutput = struct {
    /// A description of the DAX cluster, with its new replication
    /// factor.
    cluster: ?Cluster = null,

    pub const json_field_names = .{
        .cluster = "Cluster",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: IncreaseReplicationFactorInput, options: CallOptions) !IncreaseReplicationFactorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dax", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: IncreaseReplicationFactorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dax", "DAX", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDAXV3.IncreaseReplicationFactor");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !IncreaseReplicationFactorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(IncreaseReplicationFactorOutput, body, allocator);
}
